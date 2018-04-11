//
//  remarkVC.h
//  logRegister
//
//  Created by apple on 15-3-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface remarkVC : UIViewController<UITextViewDelegate,UIScrollViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView    *_scrollView;

    UITextView      *_textview;
    UITextField     *_placeholderLabel;

    UITableView     *_tableView;
}
@end
