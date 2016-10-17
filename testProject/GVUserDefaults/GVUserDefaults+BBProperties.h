//
//  GVUserDefaults+BBProperties.h
//  GrowthDiary
//
//  Created by haibao on 15/4/29.
//  Copyright (c) 2015年 zhangchun. All rights reserved.
//

#import "GVUserDefaults.h"

#define BBUserDefault [GVUserDefaults standardUserDefaults]

@interface GVUserDefaults (BBProperties)
@property(weak,nonatomic) NSString *userName;
@property(weak,nonatomic) NSString *password;
@property(assign,nonatomic)BOOL isSuccess;

@property (weak, nonatomic) NSString *sinaWeiBoUserID;

@end
