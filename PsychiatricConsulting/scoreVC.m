//
//  scoreVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "scoreVC.h"
#import "scoreProductVC.h"
#import "webViewVC.h"
@interface scoreVC ()

@end

@implementation scoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"积分乐园")
//    backTi.hidden=YES;
//    backBtn.hidden=YES;

    self.navigationController.navigationBar.hidden=YES;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    [self getData];

    _refesh=[SDRefreshHeaderView refreshView];
    __block scoreVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData];
        
        
    };

}
-(void)getData
{

    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    LOADVIEW
    [requestData getData:SCORE_LIST_URL complete:^(NSDictionary *dic) {
        NSLog(@"00000000000000000%@",dic);
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        LOADREMOVE
        _dataArray=[dic objectForKey:@"data"];
        [_tableView reloadData];


        NSArray*nullA=@[];
        if (_dataArray==nullA||_dataArray==nil||_dataArray.count==0) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-160)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-160)/2+60, _width, 20)];
            tishi.text=@"没有积分商品哦！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
            
        }
    }];


//    [requestData getData:ADV_LIST_URL(@"1") complete:^(NSDictionary *dic) {
//        LOADREMOVE
//        NSLog(@"%@",dic);
//        LOADREMOVE
//        [_refesh endRefreshing];
//        [_refeshDown endRefreshing];
//        _advistArray=[dic objectForKey:@"data"];
//        [_tableView reloadData];
//
//
//        
//    }];


    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count%2==0) {

        return (_width*0.6+10)*(_dataArray.count/2)+10;
    }else
    {

         return (_width*0.6+10)*(_dataArray.count/2+1)+10;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2)];
    _smallScrollV.contentSize=CGSizeMake(_width*_advistArray.count, _width/2);
    _smallScrollV.pagingEnabled=YES;
    _smallScrollV.bounces=NO;
    //_smallScrollV.backgroundColor=[UIColor redColor];
   // NSLog(@"jjjjjjj%d",_advistArray.count);


    if (_advistArray.count==0) {
        UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2)];
        imagev.image=[UIImage imageNamed:@"chang"];
        [_smallScrollV addSubview:imagev];
    }else{
        for (int i=0; i<_advistArray.count; i++) {
            NSLog(@"hhhhhh");
            UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
            [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_advistArray objectAtIndex:i] objectForKey:@"advImage"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];
            view.frame=CGRectMake(_width*i, 0, _width, _width/2);

            view.tag=i;
            view.backgroundColor=[UIColor darkGrayColor];
            if (i==2) {
                view.backgroundColor=[UIColor redColor];
            }
            //[view addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
            //view.backgroundColor=[UIColor yellowColor];
            [_smallScrollV addSubview:view];
        }
    }
    _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _width/2-30, _width, 30)];
    _pc.currentPage=0;
    _pc.numberOfPages=_advistArray.count;
    if (_advistArray.count==1) {
        _pc.currentPageIndicatorTintColor=[UIColor clearColor];
    }
    _pc.currentPageIndicatorTintColor=[UIColor whiteColor];
    [_smallScrollV addSubview:_pc];

    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];
    tableView.separatorColor=[UIColor clearColor];


    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    for (int i=0; i<_dataArray.count; i++) {
        NSDictionary*dic=[_dataArray objectAtIndex:i];
        int X=i%2;
        int Y=i/2;
        UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
        view.frame=CGRectMake(_width*0.02+_width*0.49*X, 10+(_width*0.6+10)*Y, _width*0.47, _width*0.6);
        view.layer.borderWidth=1;
        view.tag=i;
        [view addTarget:self action:@selector(scoreDetail:) forControlEvents:UIControlEventTouchUpInside];
        view.layer.borderColor=RGB(234, 234, 234).CGColor;
        [cell.contentView addSubview:view];


        UIImageView*imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width*0.47, _width*0.4)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"productImage"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {


            if (image==nil) {
                return ;
            }

            float  imageW=image.size.width;
            float  imageH=image.size.height;
//            CGRect rect;
            if (imageW>imageH) {
                float  H=(_width*0.47-10)*image.size.height/image.size.width;

                imageV.frame=CGRectMake(5, (_width*0.4-H)/2, _width*0.47-10, H);



//                rect=CGRectMake((imageW-imageH)/2, 0, imageH, imageH);
//                CGImageRef cgimage=CGImageCreateWithImageInRect([image CGImage], rect);
//                imageV.image=[UIImage imageWithCGImage:cgimage];
//                CGImageRelease(cgimage);

            }else
            {
                float  W=_width*0.4*image.size.width/image.size.height;

                imageV.frame=CGRectMake((_width*0.47-W)/2, 0, W, _width*0.4);


//                rect=CGRectMake(0, -(imageW-imageH)/2, imageW, imageW);
            }


        }];
        [view addSubview:imageV];



        UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(10, _width*0.4, _width*0.47-20, _width*0.2/3)];
        name_L.text=[dic objectForKey:@"productName"];
        name_L.font=[UIFont systemFontOfSize:14];
        name_L.textAlignment=NSTextAlignmentLeft;
        name_L.textColor=[UIColor blackColor];
        [view addSubview:name_L];


        UILabel*exchange_L=[[UILabel alloc]initWithFrame:CGRectMake(10, _width*0.4+ _width*0.2/3*2, _width*0.47-20, _width*0.2/3)];
        exchange_L.text=@"立即兑换";
        exchange_L.font=[UIFont systemFontOfSize:15];
        exchange_L.textAlignment=NSTextAlignmentRight;
        exchange_L.textColor=[UIColor redColor];
        [view addSubview:exchange_L];




        UILabel*score_L=[[UILabel alloc]initWithFrame:CGRectMake(10, _width*0.4+ _width*0.2/3, _width*0.47-20, _width*0.2/3)];
        score_L.text=[NSString stringWithFormat:@"%@积分",[dic objectForKey:@"userScore"]];
        score_L.font=[UIFont systemFontOfSize:14];
        score_L.textAlignment=NSTextAlignmentLeft;
        score_L.textColor=[UIColor orangeColor];
        [view addSubview:score_L];


        UILabel*price_l=[[UILabel alloc]initWithFrame:CGRectMake(10, _width*0.4+ _width*0.2/3*1.95, _width*0.25-10, _width*0.2/3)];
        price_l.text=[NSString stringWithFormat:@"原价:￥%.2f",[[dic objectForKey:@"price"] doubleValue]];
        price_l.font=[UIFont systemFontOfSize:12];
        price_l.textAlignment=NSTextAlignmentLeft;
        price_l.textColor=[UIColor grayColor];
        [view addSubview:price_l];

        NSDictionary *attrDict1 = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                     NSFontAttributeName: [UIFont systemFontOfSize:14] };
        price_l.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"￥%.2f",[[dic objectForKey:@"price"] doubleValue]] attributes: attrDict1];


//        UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.2/6, _width*0.25, 1)];
//        hengxian.backgroundColor=[UIColor grayColor];
//        [price_l addSubview:hengxian];
//

    }


    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"jinlai");
}
-(void)scoreDetail:(UIButton*)button
{
    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    PUSH(scoreProductVC)
    vc.productId=[dic objectForKey:@"productId"];

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
//-(void)advistBtn:(UIButton*)button
//{
//    NSDictionary*dic=[_advistArray objectAtIndex:button.tag];
//    NSString*s_url=[dic objectForKey:@"advUrl"];
//    if ([s_url isEqualToString:@"#"]||s_url.length==0) {
//
//    }else
//    {
//        PUSH(webViewVC)
//        vc.url=s_url;
//    }
//
//
//
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer=nil;
}
-(void)backClick
{
  POP
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
