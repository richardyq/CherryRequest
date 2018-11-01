//
//  CRViewController.m
//  CherryRequest
//
//  Created by richardyq@163.com on 11/01/2018.
//  Copyright (c) 2018 richardyq@163.com. All rights reserved.
//

#import "CRViewController.h"

#import "CRUserRequestUtil.h"

@interface CRViewController ()

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [CRUserRequestUtil createLoginRequst:@"yinquan" password:@"123456" success:^(id result) {
        NSLog(@"UserLogin request success");
    } failed:^(NSInteger errorCode, NSString *message) {
        NSLog(@"UserLogin request failed %ld, msg = %@", errorCode, message);
    } complete:^(NSInteger errorCode) {
        NSLog(@"UserLogin request complete %ld", errorCode);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
