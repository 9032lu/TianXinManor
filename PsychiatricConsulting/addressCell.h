//
//  addressCell.h
//  logRegister
//
//  Created by apple on 15-1-15.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface addressCell : UITableViewCell

{
    CGFloat         _width;
    CGFloat         _height;
}
@property(nonatomic,strong)UIView*adressView;
@property(nonatomic,strong)UILabel*linkName_L;
@property(nonatomic,strong)UILabel*address_L;
@property(nonatomic,strong)UILabel*phone_L;

@property(nonatomic,strong)UIImageView*isdefault_IV;
@property(nonatomic,strong)UIButton*isdefault_B;
@property(nonatomic,strong)UIButton*alter_B;
@property(nonatomic,strong)UIButton*delete_B;



@end
