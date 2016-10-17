//
//  iCloudViewController.m
//  testProject
//
//  Created by wujunyang on 2016/10/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "iCloudViewController.h"
#import <CloudKit/CloudKit.h>

@interface iCloudViewController ()

@end

@implementation iCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isOpenCloud];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isOpenCloud
{
    id cloudUrl=[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    //判断是否打开iCloud功能
    if(cloudUrl)
    {
        //提示
        [self showAlertMessage:@"已经打开iColud功能"];
        
        //[self saveImageDataWithPublic:YES recordID:@"imageWJYID" name:@"tabwu" password:@"12987"];
        
        //增加一条记录
        //[self addCloudDataWithPublic:YES recordID:@"wujunyangID" name:@"wujunyang" password:@"123456789"];
        
        //查找多条功能
        //[self searchRecordWithFormPublic:YES withRecordTypeName:@"User"];
        
        //查找单条功能
        //[self searchRecordWithRecordID:@"wujunyangID" withFormPublic:YES];
        
        //更新单条功能
        //[self updateRecordWithFormPublic:YES withRecordTypeName:@"User" withRecordID:@"wujunyangID"];
        
        //删除单条功能
        //[self deleteRecordWithFormPublic:YES withRecordID:@"IDName"];
        
        return YES;
    }
    
    [self showAlertMessage:@"没有打开iColud功能"];
    return NO;
}


//增加一条记录
-(void)addCloudDataWithPublic:(BOOL)isPublic recordID:(NSString *)recordID name:(NSString *)name password:(NSString *)password
{
    CKContainer *container=[CKContainer defaultContainer];
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase; //公共数据
    }
    else
    {
        database=container.privateCloudDatabase;//隐藏数据
    }
    
    //创建主键ID  这个ID可以到时查找有用到
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordID];
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

//增加带图片的提交 图片的保存,需要用到CKAsset,他的初始化需要一个URL,所以这里,我先把图片数据保存到本地沙盒,生成一个URL,然后再去创建CKAsset:
-(void)saveImageDataWithPublic:(BOOL)isPublic recordID:(NSString *)recordID name:(NSString *)name password:(NSString *)password
{
    //保存图片 图片的保存,需要用到CKAsset,他的初始化需要一个URL,所以这里,我先把图片数据保存到本地沙盒,生成一个URL,然后再去创建CKAsset:
    UIImage *image=[UIImage imageNamed:@"icloudImage"];
    NSData *imageData = UIImagePNGRepresentation(image);
    if (imageData == nil) {
        imageData = UIImageJPEGRepresentation(image, 0.6);
    }
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:tempPath]) {
        
        [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,@"iCloudImage"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [imageData writeToURL:url atomically:YES];
    
    CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
    
    //与iCloud进行交互
    CKContainer *container=[CKContainer defaultContainer];
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase; //公共数据
    }
    else
    {
        database=container.privateCloudDatabase;//隐藏数据
    }
    
    //创建主键ID  这个ID可以到时查找有用到
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordID];
    //创建CKRecord 保存数据
    CKRecord *noteRecord = [[CKRecord alloc]initWithRecordType:@"User" recordID:noteId];
    
    //设置数据
    [noteRecord setObject:name forKey:@"name"];
    [noteRecord setObject:password forKey:@"password"];
    [noteRecord setObject:asset forKey:@"userImage"];
    
    //保存操作
    [database saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            [self showAlertMessage:@"保存成功"];
        }
    }];
}


//查找单条记录
-(void)searchRecordWithRecordID:(NSString *)recordID withFormPublic:(BOOL)isPublic
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordID];
    
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
    
    __weak typeof(self)weakSelf = self;
    //查找操作
    [database fetchRecordWithID:noteId completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        NSString *message=[NSString stringWithFormat:@"获得RecordID为%@ 的数据：%@，%@",recordID,[record objectForKey:@"name"],[record objectForKey:@"password"]];
        [weakSelf showAlertMessage:message];
    }];
}

//查找多条记录（可以用谓词进行）
-(void)searchRecordWithFormPublic:(BOOL)isPublic withRecordTypeName:(NSString *)recordTypeName
{
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
    
    NSPredicate *predicate=[NSPredicate predicateWithValue:YES];
    CKQuery *query=[[CKQuery alloc]initWithRecordType:recordTypeName predicate:predicate];
    
    __weak typeof(self)weakSelf = self;
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        [weakSelf showAlertMessage:[NSString stringWithFormat:@"%@",results]];
    }];
}

//更新一条记录 首先要查找出这一条  然后再对它进行修改
-(void)updateRecordWithFormPublic:(BOOL)isPublic withRecordTypeName:(NSString *)recordTypeName withRecordID:(NSString *)recordID
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordID];
    
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
    
    __weak typeof(self)weakSelf = self;
    //查找操作
    [database fetchRecordWithID:noteId completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            
            //对原有的健值进行修改
            [record setObject:@"aa123456789" forKey:@"password"];
            //如果健值不存在 则会增加一个
            [record setObject:@"男" forKey:@"gender"];
            
            [database saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                if (!error) {
                    [weakSelf showAlertMessage:@"修改保存成功"];
                }
                else
                {
                    [weakSelf showAlertMessage:[NSString stringWithFormat:@"出错误 ：%@",error]];
                }
            }];
            
        }
    }];
}

//删除记录
-(void)deleteRecordWithFormPublic:(BOOL)isPublic withRecordID:(NSString *)recordID
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordID];

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
    
    __weak typeof(self)weakSelf = self;
    [database deleteRecordWithID:noteId completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        if (!error) {
            [weakSelf showAlertMessage:@"删除成功"];
            return;
        }
        [weakSelf showAlertMessage:[NSString stringWithFormat:@"删除失败 %@",error]];
    }];
    
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
