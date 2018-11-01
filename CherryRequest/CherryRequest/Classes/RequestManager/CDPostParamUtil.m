//
//  CDPostParamUtil.m
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import "CDPostParamUtil.h"

//version
static NSString* const kVersionKey = @"version";
//phoneModel
static NSString* const kPhoneModelKey = @"phoneModel";
//phoneSystem
static NSString* const kPhoneSystemKey = @"phoneSystem";

@implementation CDPostParamUtil

+ (NSMutableDictionary*) commonPostParam{
    NSMutableDictionary* commonParam = [NSMutableDictionary dictionary];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    //version
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [commonParam setValue:app_Version forKey:kVersionKey];
    
    //phoneModel
    NSString* deviceName = [[UIDevice currentDevice] model];
    [commonParam setObject:deviceName forKey:kPhoneModelKey];
    
    //phoneSystem
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    phoneVersion = [NSString stringWithFormat:@"iOS%@", phoneVersion];
    [commonParam setObject:phoneVersion forKey:kPhoneSystemKey];
    
    return commonParam;
}
@end
