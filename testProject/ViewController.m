//
//  ViewController.m
//  testProject
//
//  Created by wujunyang on 16/9/28.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

static const int ddLogLevel = DDLogLevelVerbose;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogError(@"wujy");
    DDLogVerbose(@"sdfsdfsf");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
