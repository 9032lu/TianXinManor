//
//  AppDelegate.h
//  PsychiatricConsulting
//
//  Created by apple on 15-5-5.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jpushVC.h"
#import "url.h"

#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,WXApiDelegate>
{
    NSString*_couponsId;
    NSString*_noticeId;
    NSString*_type;
    CGFloat         _width;
    CGFloat         _height;

}
@property (strong, nonatomic) UIWindow *window;


@end

