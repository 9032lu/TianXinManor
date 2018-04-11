//
//  setPassWordVC.h
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setPassWordVC : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextFieldDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView        *_scrollView;

    UITableView     *_tableView;
    UIButton        *_getCoderButton;
    UITextField     *_coder_L;
    int             _time;
    NSTimer         *_timer;


    UITextField     *_phone_tf;
    UITextField     *_passWord_tf;
    UITextField     *_passWord_Sure_tf;


    NSString        *_coderString;

}
@property(nonatomic,copy)NSString*whoPush;
@end
