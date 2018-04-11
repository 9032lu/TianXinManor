//
//  myButton.h
//  PsychiatricConsulting
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Modle.h"

@interface myButton : UIButton
@property(nonatomic,assign)BOOL isClicked;
@property(nonatomic,strong)Modle *IDstring;
@property(nonatomic,copy)NSString *catagerid;
@property(nonatomic,copy)NSString *nameString;



@end
