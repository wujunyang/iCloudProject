//
//  LoginViewController.m
//  testProject
//
//  Created by wujunyang on 2016/10/17.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>
#import "iCloudHelper.h"

@interface LoginViewController ()
@property(strong,nonatomic)UIButton *saveButton;
@property(strong,nonatomic)UITextField *userNameTextFiled,*passwordTextFiled;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (!self.userNameTextFiled) {
        self.userNameTextFiled=[[UITextField alloc]init];
        self.userNameTextFiled.placeholder=@"请输入用户名";
        self.userNameTextFiled.backgroundColor=[UIColor grayColor];
        [self.view addSubview:self.userNameTextFiled];
        [self.userNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];
    }
    
    
    if (!self.passwordTextFiled) {
        self.passwordTextFiled=[[UITextField alloc]init];
        self.passwordTextFiled.placeholder=@"请输入密码";
        self.passwordTextFiled.backgroundColor=[UIColor grayColor];
        [self.view addSubview:self.passwordTextFiled];
        [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.userNameTextFiled.mas_bottom).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    
    if (!self.saveButton) {
        self.saveButton=[[UIButton alloc]init];
        self.saveButton.backgroundColor=[UIColor blueColor];
        [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [self.view addSubview:self.saveButton];
        [self.saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveAction
{
    [iCloudHelper addCloudDataWithPublic:YES name:self.userNameTextFiled.text password:self.passwordTextFiled.text];
}


@end
