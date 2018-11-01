//
//  CRUserRequestUtil.h
//  CherryRequest_Example
//
//  Created by YinQ on 2018/11/1.
//  Copyright © 2018年 richardyq@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDRequestManager.h"

@interface CRUserRequestUtil : NSObject

+ (void) createLoginRequst:(NSString*) account
                  password:(NSString*) password
                   success:(CDRequestSuccess) successHandler
                    failed:(CDRequestFailed) failedHandler
                  complete:(CDRequestComplete) completeHandler;

@end
