//
//  PostSale.m
//  TianXinManor
//
//  Created by apple on 15/12/10.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "PostSale.h"
@interface PostSale ()

@end

@implementation PostSale

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"退款/换货")
    StateArray = @[@"申请中",@"成功",@"失败"];
    typeArray = @[@"",@"换货",@"退款"];
    dataArray = [[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) ];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.backgroundColor = RGB(234, 234, 234);
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];

    _refesh = [SDRefreshHeaderView refreshView];
    __block PostSale *blockSelf  = self;
    [_refesh addToScrollView:_tableView];
    _refesh.beginRefreshingOperation = ^{
        [blockSelf getData];
    };
    _refesh.isEffectedByNavigationController=NO;

    
    [self getData];

}

-(void)getData{
    [dataArray removeAllObjects];
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

LOADVIEW
    NSString *url = [NSString stringWithFormat:@"%@/order/backList.action?userId=%@",BASE_URLL,USERID];
    NSLog(@"---%@",url);
    LOADREMOVE
    [requestData getData:url complete:^(NSDictionary *dic) {
        [_refesh endRefreshing];
        NSArray *arr= dic[@"data"];
        for (NSDictionary *dictt in arr) {
            [dataArray addObject:dictt];
        }

        if (dataArray.count==0||dataArray==nil) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有相关订单";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }

        [_tableView reloadData];
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _width*0.22+74;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell =[[PostSaleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (dataArray.count!=0) {

    NSDictionary *dic= dataArray[indexPath.row];
//    NSString*number=[dic objectForKey:@"number"];
    NSString*productImage=[dic objectForKey:@"productImage"];
    NSString*productName=[dic objectForKey:@"productName"];
    NSInteger ruturnState=[[dic objectForKey:@"ruturnState"] integerValue];
    NSInteger returnType=[[dic objectForKey:@"returnType"] integerValue];

    
    [cell.productIv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            float  W=(_width*0.22)*image.size.width/image.size.height;

            cell.productIv.frame = CGRectMake((_width*0.22-W)/2+_width*0.05, 15, W, _width*0.22);
                  }
           }];

    UIView*kuang=[[UIView alloc]init];
    kuang.bounds = CGRectMake(0, 0, _width*0.22+2, _width*0.22+2);
    kuang.center = cell.productIv.center;

    kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
    kuang.layer.borderWidth=1;
    [cell.contentView addSubview:kuang];


    if (productName.length>13) {
        cell.productName.numberOfLines=2;
        cell.productName.frame=CGRectMake(_width*0.29, 15, _width*0.71-10, 40);
    }
    cell.productName.text=productName;



    cell.stateLab.text =[NSString stringWithFormat:@"%@%@",typeArray[returnType],StateArray[ruturnState]];


    NSString*string_p;
    if (returnType==1) {
        string_p=[NSString stringWithFormat:@"退款金额：￥%.2f",[@0 doubleValue]];

    }else{
        string_p=[NSString stringWithFormat:@"退款金额：￥%.2f",[[dic objectForKey:@"ratePrice"] doubleValue]];

    }

    NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:string_p];
    [atts addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 4)];
    cell.RealPrice_La.attributedText=atts;

 }


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PUSH(productVC)

    NSDictionary *dic = dataArray[indexPath.row];
    vc.productId = [NSString stringWithFormat:@"%@",dic[@"productId"]];
}

-(CGSize)boundWithSize:(CGSize)size  WithString:(NSString*)str  WithFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};

    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;

    return retSize;
}

-(void)backClick{
POP
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
