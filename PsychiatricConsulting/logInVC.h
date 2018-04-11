//
//  logInVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "thirdlogVC.h"
@interface logInVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


{
    SCREEN_WIDTH_AND_HEIGHT
     UITableView     *_tableView;
    UITextField     *_phone_tf;
    UITextField     *_password_tf;

    NSArray *platArray ;
    NSArray *platAuthArray ;
    NSString *markPlat;

}
@end
