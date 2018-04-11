//
//  newProductListVC.h
//  logRegister
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
#import "Goods.h"
@interface newProductListVC : UIViewController<UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource>

{
    CGFloat         _width;
    CGFloat         _height;

    UIButton        *_button;
    UIButton        *_currentBtn;

    UIView          *_moveView;
    UITableView     *_tabView;

    NSMutableArray  *_array;
    UITextField     *_search_tf;

    UIImageView     *_xiangxia;
    UIImageView     *_xiangshang;


    int             priceCount;
    UIView          *_loadingView;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;



    BOOL            isJiazai;
    BOOL            isXiangying;
}
@property(nonatomic,assign)BOOL isClick;
@property(nonatomic,copy)NSString*sortName;
@property(nonatomic,copy)NSString*cagetoryId;

@property(nonatomic,copy)NSString*cityId;

@property(nonatomic,copy)NSString*whoPush;
@property(nonatomic,copy)NSString*aboutStr;
@property(nonatomic,strong)Goods*good;
@end
