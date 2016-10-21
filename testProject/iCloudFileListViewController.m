//
//  iCloudFileListViewController.m
//  testProject
//
//  Created by wujunyang on 2016/10/20.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "iCloudFileListViewController.h"
#import "iCloud.h"

@interface iCloudFileListViewController ()

@end

@implementation iCloudFileListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//消息提示
-(void)showAlertMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    });
}

@end
