//
//  CDRequestObservice.m
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import "CDRequestObservice.h"


@implementation CDRequestObservice

- (id) initWithSuccess:(CDRequestSuccess) success
                failed:(CDRequestFailed) failed
              complete:(CDRequestComplete) complete{
    self = [super init];
    if(self){
        _successHandler = success;
        _failedHandler = failed;
        _completeHandler = complete;
    }
    return self;
}

@end
