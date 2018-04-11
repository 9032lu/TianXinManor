//
//  postOnWayVC.h
//  logRegister
//
//  Created by apple on 15-1-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface postOnWayVC : UIViewController<UIWebViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UIView          *_loadingView;
    
}
@property(nonatomic,strong)NSDictionary*dic;

@end
