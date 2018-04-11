//
//  AskVC.h
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskVC : UIViewController
{
    SCREEN_WIDTH_AND_HEIGHT
    UIScrollView *_scrollview;
    NSArray *type_A;
    UITextView *_textView;
    NSString*askType;
    UIButton *oldBt;
    UILabel *plach_l;
//    int keyboardHeight;
//    BOOL keyboardIsShowing;

}
@property(nonatomic,copy)NSString*productId;

//@property (nonatomic, retain) UITextView *currentTextView;
@end
