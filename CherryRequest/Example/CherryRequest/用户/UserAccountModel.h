//
//  UserAccountModel.h
//  CherryRequest_Example
//
//  Created by YinQ on 2018/11/1.
//  Copyright © 2018年 richardyq@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountModel : NSObject

@property (nonatomic, strong) NSString* account;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* lastLoginDateTime;

@end
