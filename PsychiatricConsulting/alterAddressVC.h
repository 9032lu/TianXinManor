//
//  alterAddressVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-4-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alterAddressVC : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView    *_scrollView;
    UITableView     *_tableView;


    UITextField     *_adress_tf;
    UITextField     *_detailA_tf;
    UITextField     *_name_tf;
    UITextField     *_phone_tf;
    UITextField     *_email_tf;


    UIButton        *_provice_B;
    NSString        *_ssq_str;
}
@property(nonatomic,strong)NSDictionary*dataDic;
@end
