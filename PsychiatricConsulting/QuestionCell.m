//
//  QuestionCell.m
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen ].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        UILabel *name_l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _width*0.5, 25)];
        name_l.text = @"网        友:";
        name_l.textColor = [UIColor darkGrayColor];
        name_l.font = [UIFont systemFontOfSize:14];
        [self addSubview:name_l];

        _name = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, _width-90, 25)];
        _name.text = @"菜籽油没油";
        _name.textColor = [UIColor blackColor];
        _name.numberOfLines = 0;
        _name.font = [UIFont systemFontOfSize:14];
        [self addSubview:_name];

        UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, _width*0.5, 25)];
        type.text = @"咨询类型:";
        type.textColor = [UIColor darkGrayColor];
        type.font = [UIFont systemFontOfSize:14];
        [self addSubview:type];

        _type_l = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, _width-90, 25)];
        _type_l.text = @"菜籽油没油";
        _type_l.textColor = [UIColor blackColor];
        _type_l.numberOfLines = 0;
        _type_l.font = [UIFont systemFontOfSize:14];
        [self addSubview:_type_l];

        _time_l =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _width-20, 20)];
        _time_l.text = @"2016-01-02 02:20:12";
        _time_l.textAlignment = NSTextAlignmentRight;
        _time_l.textColor = [UIColor darkGrayColor];
        _time_l.font = [UIFont systemFontOfSize:12];
        [self addSubview:_time_l];

        _title_Con = [[UILabel alloc]initWithFrame:CGRectMake(10, 25+25, _width*0.5, 25)];
        _title_Con.text = @"咨询内容:";
        _title_Con.textColor = [UIColor darkGrayColor];
        _title_Con.font = [UIFont systemFontOfSize:14];
        [self addSubview:_title_Con];

        _context_l = [[UILabel alloc]initWithFrame:CGRectMake(80, _title_Con.frame.origin.y, _width-90, 25)];
        _context_l.text = @"能够不撞上墙，自动避开桌子椅子不撞上么";
        _context_l.textColor = [UIColor blackColor];
        _context_l.numberOfLines = 0;
        _context_l.font = [UIFont systemFontOfSize:14];
        [self addSubview:_context_l];

        _title_rep = [[UILabel alloc]initWithFrame:CGRectMake(10, _title_Con.frame.origin.y+_title_Con.frame.size.height, 70, 25)];
        _title_rep.text = @"商家回复:";

        _title_rep.textColor = [UIColor orangeColor];
        _title_rep.font = [UIFont systemFontOfSize:14];
        [self addSubview:_title_rep];

         _replay_l= [[UILabel alloc]initWithFrame:CGRectMake(80, _title_rep.frame.origin.y, _width-90, 25)];
        _replay_l.text = @"您好！感谢您的惠顾！您可以手机操控一下的哦，科沃斯祝您生活愉快！感谢您对京东的支持！祝您购物愉快！";
        _replay_l.numberOfLines =0 ;
        _replay_l.textColor = [UIColor orangeColor];
        _replay_l.font = [UIFont systemFontOfSize:14];
        [self addSubview:_replay_l];


        _time_title =[[UILabel alloc]initWithFrame:CGRectMake(10, _replay_l.frame.origin.y+_replay_l.frame.size.height, 80, 25)];
        _time_title.text = @"回复时间:";
        _time_title.textColor = [UIColor darkGrayColor];
        _time_title.font = [UIFont systemFontOfSize:14];
        [self addSubview:_time_title];


        _time_rep =[[UILabel alloc]initWithFrame:CGRectMake(80,  _time_title.frame.origin.y, _width-20, 25)];
        _time_rep.text = @"2016-01-02 02:20:12";
        _time_rep.textColor = [UIColor darkGrayColor];
        _time_rep.font = [UIFont systemFontOfSize:14];
        [self addSubview:_time_rep];
        






    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
