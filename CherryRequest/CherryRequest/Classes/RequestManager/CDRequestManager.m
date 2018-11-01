//
//  CDRequestManager.m
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import "CDRequestManager.h"

@interface CDRequestManager ()

@property (nonatomic, strong) NSMutableDictionary* observiceDictionary;   //回调字典
@property (nonatomic, strong) NSOperationQueue* requestQueue;

@end

static CDRequestManager* defaultManager = nil;

@implementation CDRequestManager

+ (CDRequestManager*) shareInstance{
    if(!defaultManager){
        defaultManager = [CDRequestManager new];
    }
    return defaultManager;
}

#pragma mark - 添加请求
- (void) createRequest:(CDRequest*) request
             observice:(CDRequestObservice*) observice{
    if(!request || !request.requestId || request.requestId.length == 0)
        return;
    //添加回调
    if(![self requestObserviceHasBeenExisted:observice requestId:request.requestId]){
        NSMutableArray<CDRequestObservice*>* observices = (NSMutableArray<CDRequestObservice*>*)[self.observiceDictionary valueForKey:request.requestId];
        if(!observices){
            observices = [NSMutableArray<CDRequestObservice*> array];
            [self.observiceDictionary setValue:observices forKey:request.requestId];
        }
        
        [observices addObject:observice];
    }
    
    //添加请求
    if(![self requestHasBeenExisted:request]){
        [self.requestQueue addOperation:request];
    }
}

- (BOOL) requestHasBeenExisted:(CDRequest*) request{
    NSArray* requests = [self.requestQueue operations];
    __block BOOL requestHasBeenExisted = NO;
    
    [requests enumerateObjectsUsingBlock:^(CDRequest* existedRequest, NSUInteger idx, BOOL * _Nonnull stop) {
        requestHasBeenExisted = [request.requestId isEqualToString:existedRequest.requestId];
        if(requestHasBeenExisted){
            *stop = YES;
        }
    }];
    
    return requestHasBeenExisted;
}

- (BOOL) requestObserviceHasBeenExisted:(CDRequestObservice*) observice
                              requestId:(NSString*) requestId{
    __block BOOL observiceHasBeenExisted = NO;
    
    NSMutableArray<CDRequestObservice*>* observices = (NSMutableArray<CDRequestObservice*>*)[self.observiceDictionary valueForKey:requestId];
    if(!observices){
        observices = [NSMutableArray<CDRequestObservice*> array];
        [self.observiceDictionary setValue:observices forKey:requestId];
    }
    [observices enumerateObjectsUsingBlock:^(CDRequestObservice * _Nonnull existedObservice, NSUInteger idx, BOOL * _Nonnull stop) {
        if(observice.successHandler != existedObservice.successHandler){
            return;
        }
        if(observice.failedHandler != existedObservice.failedHandler){
            return;
        }
        if(observice.completeHandler != existedObservice.completeHandler){
            return;
        }
        observiceHasBeenExisted = YES;
        *stop = YES;
    }];
    return observiceHasBeenExisted;
}

//请求执行成功
- (void) requestSuccess:(CDRequest*) request
                 result:(id) result{
    if(!request || !request.requestId || request.requestId.length == 0)
        return;
    NSMutableArray<CDRequestObservice*>* observices = (NSMutableArray<CDRequestObservice*>*)[self.observiceDictionary valueForKey:request.requestId];
    //调用回调
    [observices enumerateObjectsUsingBlock:^(CDRequestObservice * _Nonnull observice, NSUInteger idx, BOOL * _Nonnull stop) {
        if(observice.successHandler){
            observice.successHandler(result);
        }
    }];
}

//请求执行失败
- (void) requestFailed:(CDRequest*) request
             errroCode:(NSInteger) errorCode
          errorMessage:(NSString*) message{
    if(!request || !request.requestId || request.requestId.length == 0)
        return;
    NSMutableArray<CDRequestObservice*>* observices = (NSMutableArray<CDRequestObservice*>*)[self.observiceDictionary valueForKey:request.requestId];
    //调用回调
    [observices enumerateObjectsUsingBlock:^(CDRequestObservice * _Nonnull observice, NSUInteger idx, BOOL * _Nonnull stop) {
        if(observice.failedHandler){
            observice.failedHandler(errorCode, message);
        }
    }];
}

- (void) requestComplete:(CDRequest*) request{
    if(!request || !request.requestId || request.requestId.length == 0)
        return;
    NSMutableArray<CDRequestObservice*>* observices = (NSMutableArray<CDRequestObservice*>*)[self.observiceDictionary valueForKey:request.requestId];
    //调用回调
    [observices enumerateObjectsUsingBlock:^(CDRequestObservice * _Nonnull observice, NSUInteger idx, BOOL * _Nonnull stop) {
        if(observice.completeHandler){
            observice.completeHandler(request.errorCode);
        }
    }];
    
    //清理回调
    [self.observiceDictionary removeObjectForKey:request.requestId];
}


#pragma mark - settingAndGetting

- (NSMutableDictionary*) observiceDictionary{
    if(!_observiceDictionary){
        _observiceDictionary = [NSMutableDictionary dictionary];
    }
    return _observiceDictionary;
}

- (NSOperationQueue*) requestQueue{
    if(!_requestQueue){
        _requestQueue = [[NSOperationQueue alloc] init];
        _requestQueue.maxConcurrentOperationCount = 5;
    }
    return _requestQueue;
}
@end
