//
//  comentListCell.h
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comentListCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;
}

@property(nonatomic,strong)UIImageView*userface;
@property(nonatomic,strong)UILabel*username;
@property(nonatomic,strong)UILabel*userGrade;

@property(nonatomic,strong)UIView*commentView;
@property(nonatomic,strong)UILabel*comment;
@property(nonatomic,strong)UILabel*commentDate;
@property(nonatomic,strong)UILabel*commentSku;

@property(nonatomic,strong)UIView*replayView;
@property(nonatomic,strong)UILabel*replay;
@property(nonatomic,strong)UILabel*replayDate;

@end
