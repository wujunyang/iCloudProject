//
//  main.m
//  testProject
//
//  Created by wujunyang on 16/9/28.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSUInteger count=99;
        NSString *objs=@"red";
        
        NSLog(@"内容为：%ld,%@",count,objs);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
