//
//  AppDelegate.m
//  testProject
//
//  Created by wujunyang on 16/9/28.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "iCloudViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "FirstViewController.h"
@interface AppDelegate ()

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //JiaCore基础模块相关配置
    JiaCoreConfigManager *jiaCoreConfig=[JiaCoreConfigManager sharedInstance];
    jiaCoreConfig.recordlogger=YES;
    jiaCoreConfig.openDebug=NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FirstViewController *vc = [[FirstViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = navc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)setupMainViewController
{
    MainViewController *logInVc = [[MainViewController alloc]init];
    UINavigationController *navcLogin = [[UINavigationController alloc]initWithRootViewController:logInVc];
    self.window.rootViewController = navcLogin;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

-(void)setupLoginViewController
{
    LoginViewController *logInVc = [[LoginViewController alloc]init];
    UINavigationController *navcLogin = [[UINavigationController alloc]initWithRootViewController:logInVc];
    [navcLogin setNavigationBarHidden:YES];
    self.window.rootViewController = navcLogin;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [super applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [super applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [super applicationWillTerminate:application];
}

@end
