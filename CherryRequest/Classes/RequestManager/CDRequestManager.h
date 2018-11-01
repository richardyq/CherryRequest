//
//  CDRequestManager.h
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import <Foundation/Foundation.h>
#import "CDRequest.h"
#import "CDRequestObservice.h"

@interface CDRequestManager : NSObject

+ (CDRequestManager*) shareInstance;

- (void) createRequest:(CDRequest*) request
             observice:(CDRequestObservice*) observice;


//请求执行成功
- (void) requestSuccess:(CDRequest*) request
                 result:(id) result;

//请求执行失败
- (void) requestFailed:(CDRequest*) request
             errroCode:(NSInteger) errorCode
          errorMessage:(NSString*) message;

- (void) requestComplete:(CDRequest*) request;

@end
