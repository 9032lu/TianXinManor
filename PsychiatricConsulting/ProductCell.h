//
//  ProductCell.h
//  TianXinManor
//
//  Created by apple on 15/12/11.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProductCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;
}

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIView *shuXian;

@end
