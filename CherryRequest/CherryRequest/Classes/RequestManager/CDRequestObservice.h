//
//  CDRequestObservice.h
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import <Foundation/Foundation.h>

typedef void(^CDRequestSuccess)(id result);
typedef void(^CDRequestFailed)(NSInteger errorCode, NSString* message);
typedef void(^CDRequestComplete)(NSInteger errorCode);

@interface CDRequestObservice : NSObject

@property (nonatomic, strong) CDRequestSuccess  successHandler;
@property (nonatomic, strong) CDRequestFailed   failedHandler;
@property (nonatomic, strong) CDRequestComplete completeHandler;

- (id) initWithSuccess:(CDRequestSuccess) success
                failed:(CDRequestFailed) failed
              complete:(CDRequestComplete) complete;
@end
