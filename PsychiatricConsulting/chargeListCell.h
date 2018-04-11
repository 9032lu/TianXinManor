//
//  chargeListCell.h
//  logRegister
//
//  Created by apple on 15-1-27.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chargeListCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;

}
@property(nonatomic,strong)UIImageView*shopLogo;
@property(nonatomic,strong)UILabel*shopName;
@property(nonatomic,strong)UILabel*chargeName;
@property(nonatomic,strong)UILabel*chargePrice;
@property(nonatomic,strong)UILabel*couponsDesc;
@property(nonatomic,strong)UILabel*endTime;
@property(nonatomic,strong)UIButton*receiveBtn;
@property(nonatomic,strong)UIView*kuang;
@property(nonatomic,assign)BOOL isOpen;

@end
