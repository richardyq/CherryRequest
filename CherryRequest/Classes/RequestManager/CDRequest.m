//
//  CDRequest.m
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import "CDRequest.h"
#import "MJExtension.h"
#import "CDRequestManager.h"

static NSString* const kClassNameKey = @"classname";
static NSString* const kRequestParamKey    = @"RequestParam";

@interface CDRequest ()
{
    NSCondition* cdiLock;
}

@end

@implementation CDRequest

@synthesize requestId = _requestId;

- (instancetype)init
{
    self = [super init];
    if (self) {
        cdiLock = [[NSCondition alloc ]init];
        _errorCode = 0;
    }
    return self;
}

- (void) lock
{
    [cdiLock lock];
    [cdiLock wait];
    [cdiLock unlock];
}

- (void) unlock
{
    [cdiLock lock];
    [cdiLock signal];
    [cdiLock unlock];
}

- (void) main{
    [self requestFunc];
    [self performSelectorOnMainThread:@selector(requestComplete) withObject:nil waitUntilDone:NO];
}

- (void) requestFunc{
    
}

#pragma mark - settingAndGetting
- (NSString*) requestId{
    if(!_requestId)
    {
        NSMutableDictionary* requestDictionary = [NSMutableDictionary dictionary];
        NSString* className = NSStringFromClass([self class]);
        [requestDictionary setValue:className forKey:kClassNameKey];
        
        if(self.paramDictionary){
            [requestDictionary setValue:self.paramDictionary forKey:kRequestParamKey];
        }
        
        _requestId = [requestDictionary mj_JSONString];
    }
    return _requestId;
}

- (void) requestComplete{
    CDRequestManager* manager = [CDRequestManager shareInstance];
    [manager requestComplete:self];
}
@end
