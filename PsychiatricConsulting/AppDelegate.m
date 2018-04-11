//
//  AppDelegate.m
//  PsychiatricConsulting
//
//  Created by apple on 15-5-5.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "danli.h"
#import "homePage.h"
#import "APService.h"
#import "define.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AlipaySDK/AlipaySDK.h>
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [NSThread sleepForTimeInterval:1.5];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    


    ViewController*vc=[[ViewController alloc]init];

    self.window.rootViewController=vc;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
#pragma mark 极光推送
    //注册通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    // Required
    [APService setupWithOption:launchOptions];
//    [APService setDebugMode];

#pragma mark友盟配置
    [UMSocialData setAppKey:UMAPPKEY];
//     [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialData openLog:YES];


    [UMSocialQQHandler setQQWithAppId:@"1104870321" appKey:@"adu5pi4yRnPmmzv8" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];

    return YES;
}

//2您注册了推送功能，iOS 会自动回调以下方法，得到deviceToken，您需要将deviceToken传给SDK
// 将得到的deviceToken传给SDK
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    [APService registerDeviceToken:deviceToken];

}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{

    [APService handleRemoteNotification:userInfo];
//调用震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    //调用声音
    AudioServicesPlaySystemSound(1007);

//    NSLog(@"%@===+++++++++++++===",userInfo);
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    //UIApplication
    _type=[userInfo objectForKey:@"type"];
    _noticeId=[userInfo objectForKey:@"noticeId"];
    _couponsId=[userInfo objectForKey:@"couponsId"];

    NSString*string=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"新消息" message:string delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"查看", nil];
    [alert show];

    completionHandler(UIBackgroundFetchResultNewData);


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if (buttonIndex==0) {

    }else
    {
        jpushVC*vc=[[jpushVC alloc]init];


        if ([_type intValue]==1) {
            vc.whoPush=@"coup";
            vc.url=NOTICE_DETAIL(_couponsId);

        }else
        {
            vc.whoPush=@"noti";
            vc.url=NOTICE_DETAIL(_noticeId);

        }

        [[self activityViewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}
- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];

        id nextResponder = [frontView nextResponder];

        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }

    return activityViewController;
}

//注(2)微信支付跳转处理
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"handleOpenURL==%@",url);
        if ([UMSocialSnsService handleOpenURL:url]) {

            return  [UMSocialSnsService handleOpenURL:url];

        }else{

            return [WXApi handleOpenURL:url delegate:self];

        }

}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    NSLog(@"openURL==%@",url);


    if ([url.host isEqualToString:@"safepay"]) {
//        跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);

        }];
        
        return YES;
    }
    else  if ([UMSocialSnsService handleOpenURL:url]) {

        return  [UMSocialSnsService handleOpenURL:url];

    }else{

        return [WXApi handleOpenURL:url delegate:self];
        
    }


}
//注3.回调方法
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;

    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];

        
        NSLog(@"resp.errCode==%d",resp.errCode);

        switch (resp.errCode) {
            case WXSuccess:{

                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];

                break;
            }
        }
    }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
}

//8.注册失败
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"error --------------------------------------------------------------------------------------- %@",error);

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||

            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {


    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

//    danli*myapp=[danli shareClient];
//    if (myapp.isremember) {
//
//    }else
//    {
//        [requestData cancelLonIn];
//    }


}


@end
