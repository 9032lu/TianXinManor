//
//  commentVC.h
//  logRegister
//
//  Created by apple on 15-1-21.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentVC : UIViewController<UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UITableView     *_tableView;

    
    UIView          *_bgView;
    UITextView      *_tv;
    float              _keyBoard_H;
    float               _KeyH;

    UITextField     *_current_Tf;
    BOOL  isGo;
    NSArray         *_goodsArray;
}
@property(nonatomic,strong)NSDictionary*dic;
@end
