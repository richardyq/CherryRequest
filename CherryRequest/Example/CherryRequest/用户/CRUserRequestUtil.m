//
//  CRUserRequestUtil.m
//  CherryRequest_Example
//
//  Created by YinQ on 2018/11/1.
//  Copyright © 2018年 richardyq@163.com. All rights reserved.
//

#import "CRUserRequestUtil.h"
#import "CRUserLoginRequest.h"


@implementation CRUserRequestUtil

+ (void) createLoginRequst:(NSString*) account
                            password:(NSString*) password
                             success:(CDRequestSuccess) successHandler
                              failed:(CDRequestFailed) failedHandler
                            complete:(CDRequestComplete) completeHandler{
    CDRequestObservice* observice = [[CDRequestObservice alloc] initWithSuccess:successHandler failed:failedHandler complete:completeHandler];
    CDJsonRequest* request = [[CRUserLoginRequest alloc] initWithAccount:account password:password];
    [[CDRequestManager shareInstance] createRequest:request observice:observice];
}
@end
