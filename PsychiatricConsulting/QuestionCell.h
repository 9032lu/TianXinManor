//
//  QuestionCell.h
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;
}
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *type_l;

@property(nonatomic,strong)UILabel *time_l;
@property(nonatomic,strong)UILabel *context_l;
@property(nonatomic,strong)UILabel *title_Con;

@property(nonatomic,strong)UILabel *title_rep;
@property(nonatomic,strong)UILabel *time_rep;
@property(nonatomic,strong)UILabel *time_title;

@property(nonatomic,strong)UILabel *replay_l;

@end
