//
//  jubaoVC.h
//  logRegister
//
//  Created by apple on 15-1-23.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jubaoVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat     _width;
    CGFloat     _height;
    UITextField *_tf;
    NSArray     *_array;
    UIButton    *_sendbutton;

    float           _keyBoard_H;
    UILabel         *_showlabel;
    UIScrollView    *_scrollView;
//    UILabel          *_denglu;

}
@property(nonatomic,copy)NSString*userId;
@property(nonatomic,copy)NSString*topicsId;
@end





