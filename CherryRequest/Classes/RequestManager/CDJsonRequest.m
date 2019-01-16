//
//  CDJsonRequst.m
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import "CDJsonRequest.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "CDRequestManager.h"
#import "CDPostParamUtil.h"

@implementation CDJsonRequest

@synthesize errorCode = _errorCode;

- (AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *sessionManager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化Manager
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 30.0;
        //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        //        sessionManager.securityPolicy = securityPolicy;
    });
    return sessionManager;
}

- (NSDictionary*) postParamDictionary{
    NSMutableDictionary* postDict = [NSMutableDictionary dictionaryWithDictionary:self.paramDictionary];
    [postDict addEntriesFromDictionary:[CDPostParamUtil commonPostParam]];
    
    return postDict;
}

- (void) requestFunc{
    // 初始化Manager
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    // post请求
    NSString* sUrl = [self postUrl];
    __weak typeof(self) weakSelf = self;
    
    NSDictionary* postParam = [self postParamDictionary];
    
    
    
    [manager POST:sUrl parameters:postParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(!weakSelf)
            return ;
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf jsonPostSuccess:task Response:responseObject];
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(!weakSelf)
            return ;
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf jsonPostFailed:task Error:error];
        NSLog(@"%@", [error localizedDescription]);
    }];
    [self lock];
}

- (NSString*) postUrl{
    return nil;
}



- (void) jsonPostSuccess:(NSURLSessionDataTask *) task Response:(id) responseObject
{
    NSLog(@"jsonPostSuccess operation %@", task.response.URL.absoluteString);
    if (responseObject )
    {
        NSString* strResp = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary* respDictionary = (NSDictionary*)[strResp mj_JSONObject];
        
        if(!respDictionary || ![respDictionary isKindOfClass:[NSDictionary class]])
        {
            //解析返回数据失败
            [[CDRequestManager shareInstance] requestFailed:self errroCode:-2 errorMessage:@"解析返回数据失败。"];
            goto END;
        }
        
        NSNumber* retCode = [respDictionary valueForKey:@"code"];
        NSString* err_msg = [respDictionary valueForKey:@"message"];
        id retResult = [respDictionary valueForKey:@"result"];
        
        if(!err_msg || ![err_msg isKindOfClass:[NSString class]] || err_msg.length == 0){
            err_msg = @"解析返回数据失败。";
        }
        if(!retCode || ![retCode isKindOfClass:[NSNumber class]] || retCode.integerValue != 0){
            _errorCode = retCode.integerValue;
            [[CDRequestManager shareInstance] requestFailed:self errroCode:-2 errorMessage:err_msg];
            goto END;
        }
        
        if(retResult){
            id result = [self parserResult:retResult];
            [[CDRequestManager shareInstance] requestSuccess:self result:result];
        }
        
    }
    
END:
    [self unlock];
}

- (id) parserResult:(id) result{
    return result;
}

- (void) jsonPostFailed:(NSURLSessionDataTask *) task Error:(NSError*) error
{
    NSLog(@"jsonPostFailed called.");
    [[CDRequestManager shareInstance] requestFailed:self errroCode:-1 errorMessage:@"数据请求失败。"];
    [self unlock];
}

@end
