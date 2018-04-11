//
//  addAdressVC.h
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addAdressVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView    *_scrollView;


    UITextField     *_adress_tf;
    UITextField     *_detailA_tf;
    UITextField     *_name_tf;
    UITextField     *_phone_tf;
    UITextField     *_email_tf;


    UIButton        *_provice_B;
    NSString        *_ssq_str;

    
}
@end
