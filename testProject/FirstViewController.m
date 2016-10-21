//
//  FirstViewController.m
//  testProject
//
//  Created by wujunyang on 2016/10/17.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(strong,nonatomic)UILabel *myLabel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.myLabel) {
        self.myLabel=[[UILabel alloc]init];
        self.myLabel.text=@"动画加载中（请求数据中）...";
        self.myLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:self.myLabel];
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(44);
        }];
    }
    
    id cloudUrl=[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    //判断是否打开iCloud功能
    if(!cloudUrl)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"查看是否登录iCloud账号并开启iCloud开关" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [iCloudHelper searchRecordWithFormPublic:YES withCompletion:^(NSError *error, NSString *userName, NSString *password) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error||userName.length==0) {
            [(AppDelegate*)([[UIApplication sharedApplication] delegate]) setupLoginViewController];
            }
            else
            {
                BBUserDefault.userName=userName;
                BBUserDefault.password=password;
                 [(AppDelegate*)([[UIApplication sharedApplication] delegate]) setupMainViewController];
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
