//
//  jpushVC.h
//  logRegister
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
@interface jpushVC : UIViewController<UIWebViewDelegate>

{
    CGFloat         _width;
    CGFloat         _height;
    UIView          *_loadingView;
}
@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*whoPush;

@end
