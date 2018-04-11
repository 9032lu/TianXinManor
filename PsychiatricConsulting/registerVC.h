//
//  registerVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface registerVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;
    UITextField     *_phone_tf;
    UITextField     *_password_tf;
    UITextField     *_password_sure_tf;
    UIButton        *_regBtn;
    UIButton        *_logInBtn;
    UITextField    *_phoneCode;

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



//    NSString        *_checkCode;
    UIButton * _testBtn;
    int             _time;
    NSTimer         *_timer;
}
@end
