//
//  CRUserLoginRequest.m
//  CherryRequest_Example
//
//  Created by YinQ on 2018/11/1.
//  Copyright © 2018年 richardyq@163.com. All rights reserved.
//

#import "CRUserLoginRequest.h"

@implementation CRUserLoginRequest

@synthesize paramDictionary = _paramDictionary;

- (id) initWithAccount:(NSString*) account
              password:(NSString*) password{
    self = [super init];
    if(self){

        NSMutableDictionary* postParam = [NSMutableDictionary dictionary];
        [postParam setValue:account forKey:@"account"];
        [postParam setValue:password forKey:@"password"];
        
        _paramDictionary = postParam;
    }
    return self;
}

- (NSString*) postUrl{
    return @"http://127.0.0.1:8080/ServletExample/CherryTest/CherrySevlet?do=baseInterface&method=login&service=userService";
}

- (id) parserResult:(id) result{
    
    return result;
}
@end
