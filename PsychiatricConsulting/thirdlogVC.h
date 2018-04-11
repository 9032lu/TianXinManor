//
//  thirdlogVC.h
//  TianXinManor
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface thirdlogVC : UIViewController
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;
    UITextField     *_phone_tf;
    UITextField     *_password_tf;
    UITextField     *_password_sure_tf;
    UITextField    *_phoneCode;

    UIButton *mybutton;
    UIView*line;
    UIButton*logInBtn;

    UIScrollView *_scrollView;
    UIImageView *_userFace;
    UITextField     *_niceName;
    UITextField     *_realName;
    //    UITextField     *_sex;
    UITextField     *_identifierCode;
    UITextField     *_email;
    UILabel *_sexlab;
    UILabel *_marrayStatu;
    NSString*checkCode;

    NSString        *_imageDataStr;
    UIImage         *_image;

    NSDictionary *marDic;
    NSDictionary *sexDic;
    UIButton * _testBtn;

    int             _time;
    NSTimer         *_timer;

}
@property(nonatomic,copy)NSString *Auth_UID;
@property(nonatomic,copy)NSString *usid;
@end
