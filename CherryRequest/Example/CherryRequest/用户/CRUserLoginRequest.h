//
//  CRUserLoginRequest.h
//  CherryRequest_Example
//
//  Created by YinQ on 2018/11/1.
//  Copyright © 2018年 richardyq@163.com. All rights reserved.
//

#import "CDJsonRequest.h"

@interface CRUserLoginRequest : CDJsonRequest

- (id) initWithAccount:(NSString*) account
              password:(NSString*) password;

@end
