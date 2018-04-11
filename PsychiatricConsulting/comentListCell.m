//
//  comentListCell.m
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "comentListCell.h"

@implementation comentListCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        _userface=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 7.5, 25, 25)];
        _userface.layer.cornerRadius=12.5;
        _userface.clipsToBounds=YES;
        [self addSubview:_userface];

        _username=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.06+20, 10, _width*0.5 , 20)];
        _username.textAlignment=NSTextAlignmentLeft;
        _username.textColor=[UIColor darkGrayColor];
        _username.font=[UIFont systemFontOfSize:12];
        [self addSubview:_username];

        _userGrade=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.95-_width*0.15, 10, _width*0.15 , 17)];
        _userGrade.textAlignment=NSTextAlignmentCenter;
        _userGrade.textColor=[UIColor whiteColor];
        _userGrade.font=[UIFont systemFontOfSize:11];
        _userGrade.backgroundColor=APP_ClOUR;
        _userGrade.layer.cornerRadius=3;
        _userGrade.clipsToBounds=YES;
        [self addSubview:_userGrade];

        UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03, 35, _width, 1)];
        grayline.backgroundColor=RGB(234, 234, 234);
        [self addSubview:grayline];


        _commentView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, _width, 50)];

        [self addSubview:_commentView];

        _comment=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.9, 20)];
        _comment.textAlignment=NSTextAlignmentLeft;
        _comment.textColor=[UIColor darkGrayColor];
        _comment.font=[UIFont italicSystemFontOfSize:12];
        _comment.numberOfLines=0;
        [_commentView addSubview:_comment];

        _commentDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.5, _comment.frame.size.height, _width*0.48,15)];
        _commentDate.textAlignment=NSTextAlignmentRight;
        _commentDate.textColor=[UIColor darkGrayColor];
        _commentDate.font=[UIFont italicSystemFontOfSize:10];
        [_comment addSubview:_commentDate];

        _commentSku=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _comment.frame.size.height, _width*0.45,15)];
        _commentSku.textAlignment=NSTextAlignmentLeft;
        _commentSku.textColor=[UIColor darkGrayColor];

        _commentSku.font=[UIFont italicSystemFontOfSize:10];
        [_comment addSubview:_commentSku];


        _replayView=[[UIView alloc]initWithFrame:CGRectMake(0,80 , _width, 35)];
        //_replayView.backgroundColor=[UIColor redColor];
        [self addSubview:_replayView];

        _replay=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.9, 20)];
        _replay.textAlignment=NSTextAlignmentLeft;
        _replay.textColor=[UIColor blackColor];
        _replay.font=[UIFont italicSystemFontOfSize:12];
        [_replayView addSubview:_replay];

        _replayDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.5, _replay.frame.size.height, _width*0.48,15)];
        _replayDate.textAlignment=NSTextAlignmentRight;
        _replayDate.textColor=[UIColor darkGrayColor];
        _replayDate.font=[UIFont italicSystemFontOfSize:10];
        [_replayView addSubview:_replayDate];



     

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
