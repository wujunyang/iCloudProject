//
//  iCloudHelper.h
//  testProject
//
//  Created by wujunyang on 2016/10/17.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import <UIKit/UIKit.h>
#import "UIDevice+FCUUID.h"
#import "GVUserDefaults+BBProperties.h"

typedef void (^CompletionHandler)(NSError *error,NSString *userName,NSString *password);


@interface iCloudHelper : NSObject

@property (nonatomic, copy) CompletionHandler completionBlock;

+(void)addCloudDataWithPublic:(BOOL)isPublic name:(NSString *)name password:(NSString *)password;

+(void)searchRecordWithFormPublic:(BOOL)isPublic withCompletion:(CompletionHandler)completionHandler;

@end
