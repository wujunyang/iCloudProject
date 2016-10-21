//
//  MainViewController.m
//  testProject
//
//  Created by wujunyang on 2016/10/17.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MainViewController.h"
#import "iCloudHelper.h"
#import "ListViewController.h"

@interface MainViewController ()
@property(strong,nonatomic)UILabel *myLabel;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"首页";
    
    if (!self.myLabel) {
        self.myLabel=[[UILabel alloc]init];
        self.myLabel.textColor=[UIColor redColor];
        self.myLabel.text=[NSString stringWithFormat:@"当前账号：%@ 密码： %@",BBUserDefault.userName,BBUserDefault.password];
        self.myLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:self.myLabel];
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(44);
        }];
    }

    
    //设置右边
//    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,70,30)];
//    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [rightButton setTitle:@"iCloud文件" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(iCloudFileManager)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem= rightItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)iCloudFileManager
{
    ListViewController *vc=[[ListViewController alloc]init];
    
     [self.navigationController pushViewController:vc animated:YES];
}

@end
