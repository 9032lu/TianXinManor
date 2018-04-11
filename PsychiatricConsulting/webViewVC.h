//
//  webViewVC.h
//  logRegister
//
//  Created by apple on 14-12-31.
//  Copyright (c) 2014年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myView.h"
@interface webViewVC : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    CGFloat         _width;
    CGFloat         _height;
    UIView          *_loadingView;

    myView          *viewh;
    UITableView            *_downwardView;
    NSArray         *_dataArray;
    UIWebView*web;

    
}
@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*whoPush;
@end
