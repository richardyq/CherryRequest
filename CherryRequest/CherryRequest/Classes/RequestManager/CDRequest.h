//
//  CDRequest.h
//  CherryRequest
//
//  Created by YinQ on 2018/11/1.
//

#import <Foundation/Foundation.h>

@interface CDRequest : NSOperation


@property (nonatomic, readonly) NSInteger errorCode;

@property (nonatomic, readonly) NSString* requestId;

@property (nonatomic, readonly) NSDictionary* paramDictionary;


- (void) lock;
- (void) unlock;

@end
