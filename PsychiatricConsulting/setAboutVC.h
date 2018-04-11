//
//  setAboutVC.h
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setAboutVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UITableView     *_tableView;
    NSString        *_testString;
    NSDictionary    *_dic;
    

}


@end
