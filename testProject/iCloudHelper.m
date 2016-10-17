//
//  iCloudHelper.m
//  testProject
//
//  Created by wujunyang on 2016/10/17.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "iCloudHelper.h"
#import "AppDelegate.h"

@implementation iCloudHelper


//增加一条记录
+(void)addCloudDataWithPublic:(BOOL)isPublic name:(NSString *)name password:(NSString *)password
{
    id cloudUrl=[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    //判断是否打开iCloud功能
    if(!cloudUrl)
    {
        [self showAlertMessage:@"还没打开iColud功能,会直接写入业务数据库中，同样可以登录"];
        return;
    }
    
    
    CKContainer *container=[CKContainer defaultContainer];
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase; //公共数据
    }
    else
    {
        database=container.privateCloudDatabase;//隐藏数据
    }
    
    UIDevice *dev=[[UIDevice alloc]init];
    //创建主键ID  这个ID可以到时查找有用到
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:[dev uuid]];
    //创建CKRecord 保存数据
    CKRecord *noteRecord = [[CKRecord alloc]initWithRecordType:@"User" recordID:noteId];
    
    //设置数据
    [noteRecord setObject:name forKey:@"name"];
    [noteRecord setObject:password forKey:@"password"];
    
    //保存操作
    [database saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            [self showAlertMessage:@"保存成功"];
        }
    }];
}

//查找单条记录
+(void)searchRecordWithFormPublic:(BOOL)isPublic withCompletion:(CompletionHandler)completionHandler
{
    
    id cloudUrl=[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    //判断是否打开iCloud功能
    if(!cloudUrl)
    {
        [self showAlertMessage:@"还没打开iColud功能"];
        return;
    }
    
    UIDevice *dev=[[UIDevice alloc]init];
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:[dev uuid]];
    
    //获得容器
    CKContainer *container=[CKContainer defaultContainer];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase;
    }
    else
    {
        database=container.privateCloudDatabase;
    }

    //查找操作
    [database fetchRecordWithID:noteId completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        completionHandler(error,[record objectForKey:@"name"],[record objectForKey:@"password"]);
    }];
}

//消息提示
+(void)showAlertMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(AppDelegate*)([[UIApplication sharedApplication] delegate]) setupMainViewController];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    });
}

@end
