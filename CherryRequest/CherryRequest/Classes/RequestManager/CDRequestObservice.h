//
//  CDRequestObservice.h
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import <Foundation/Foundation.h>

typedef void(^JARequestSuccess)(id result);
typedef void(^JARequestFailed)(NSInteger errorCode, NSString* message);
typedef void(^JARequestComplete)(NSInteger errorCode);

@interface CDRequestObservice : NSObject

@property (nonatomic, strong) JARequestSuccess  successHandler;
@property (nonatomic, strong) JARequestFailed   failedHandler;
@property (nonatomic, strong) JARequestComplete completeHandler;

- (id) initWithSuccess:(JARequestSuccess) success
                failed:(JARequestFailed) failed
              complete:(JARequestComplete) complete;
@end
