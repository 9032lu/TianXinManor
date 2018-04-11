//
//  missingView.h
//  PsychiatricConsulting
//
//  Created by apple on 15-5-7.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface missingView : UIView

{
    UILabel*_label;
    SCREEN_WIDTH_AND_HEIGHT
}
@property(nonatomic,copy)NSString*tishi;
@property(nonatomic,assign)  CGRect *labelFrame;

@end
