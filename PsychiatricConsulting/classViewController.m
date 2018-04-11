//
//  classViewController.m
//  meishi
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "classViewController.h"

@interface classViewController ()<UITableViewDataSource,UITableViewDelegate,MZTimerLabelDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView             *_tableView;
    NSString *urlString;

    UILabel *timeSting;
    UIButton *buyBtn;
    BOOL isRush;
    BOOL  isConclusion;

    UIButton *mybutton;
    NSTimer *timer;

    MZTimerLabel *timerExample9;
    MZTimerLabel *timerExample8;

    UIButton*rightUpBtn;
    UIButton*rightUpBtnBack;

    NSMutableArray *shijianarr ;

    NSMutableArray *jieshushijianarr ;

    UIButton *topBtn;
    NSMutableArray *_dataArray;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;


}
@end

@implementation classViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    SCREEN
    TOP_VIEW(@"商品列表")

    isRush=NO;
//    shijianarr = [NSMutableArray arrayWithObjects:@"2015-10-16 20:06:10.000",@"2015-10-16 19:31:00.000", nil];
//    jieshushijianarr = [NSMutableArray arrayWithObjects:@"2015-10-16 22:32:10.000",@"2015-10-16 20:04:10.000", nil];


    rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.87, 30,20, 20);
    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"sousuo1"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];
    rightUpBtnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 20,_width*0.8, 30);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightUpBtnBack];


        NSString *namestr= [NSString stringWithFormat:@"%@年商品",self.categoryName];
    NSArray *topArray= [NSArray arrayWithObjects:namestr,@"限时抢购", nil];
//



//    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+44, _width, _height-64-44) style:UITableViewStyleGrouped];
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    [self.view addSubview:_tableView];
//    _tableView.separatorColor =[UIColor clearColor];
        [self initTableView];


    if ([self.whoPush isEqualToString:@"productCenter"]) {
        for (int i =0; i <2; i++) {

            topBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            topBtn.frame=CGRectMake(_width/2*i, 64, _width/2, 44);
            [topBtn setTitle:topArray[i] forState:UIControlStateNormal];
            topBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [topBtn addTarget:self action:@selector(topSelect:) forControlEvents:UIControlEventTouchUpInside];
            topBtn.tag = i;
            if (i==0) {
                mybutton = topBtn;
                [topBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }else{
                [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
         
            [self.view addSubview:topBtn];
        }
        UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/2, 71, 1, 30)];
        shuxian.backgroundColor=RGB(234, 234, 234);
        [self.view addSubview:shuxian];

    }
    else if ([self.whoPush isEqualToString:@"search"]){
        rightUpBtn.hidden=YES;
        rightUpBtnBack.hidden=YES;
        _tableView.frame = CGRectMake(0,64, _width, _height-64);

    }






}
-(void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+44, _width, _height-64-44) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor =[UIColor clearColor];


    _refesh=[SDRefreshHeaderView refreshView];
    __block classViewController*blockSelf=self;
    [_refesh addToScrollView:_tableView];
    if (isRush ==NO) {
        [self getData:@""];

    }else

        [self getRushData:@""];




    _refesh.beginRefreshingOperation=^{
        if (isRush ==NO) {
            [blockSelf getData:@""];

        }else

            [blockSelf getRushData:@""];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        if (isRush ==NO) {
            [blockSelf getData:@""];

        }else
            
            [blockSelf getRushData:@""];
        
    };


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isRush==YES) {
        return _width*0.45+10;
    }else
    return _width*0.3+10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"cellID";



    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }

    for (UIView *view in cell.contentView.subviews) {
//        if ([view isKindOfClass:[UITableView class]]) {
            [view removeFromSuperview];
//        }
    }

    cell.selectionStyle= UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor clearColor];
    UIView *backview = [[UIView alloc]init];
    backview.clipsToBounds=YES;
    backview.layer.cornerRadius=5;
    backview.backgroundColor = [UIColor whiteColor];
    if (isRush ==NO) {
     backview.frame = CGRectMake(5, 5, _width-10, _width*0.3);

    }
    [cell.contentView addSubview:backview];
    NSDictionary *dic =_dataArray[indexPath.row];

    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.25, _width*0.25)];
    [imageview sd_setImageWithURL:[NSURL URLWithString:dic[@"productImage"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {



        if (image==nil) {
            return ;
        }

        float  imageW=image.size.width;
        float  imageH=image.size.height;
        CGRect rect;

        if (isRush ==NO) {
            if (imageW>imageH) {
                rect=CGRectMake((imageW-imageH)/2, 0, imageH, imageH);
                CGImageRef cgimage=CGImageCreateWithImageInRect([image CGImage], rect);
                imageview.image=[UIImage imageWithCGImage:cgimage];
                CGImageRelease(cgimage);

            }else
            {
                imageview.frame=CGRectMake(_width*0.127+4, _width*0.025, _width*0.25/4.5, _width*0.25);
            }




        }else{
            if (imageW>imageH) {
                rect=CGRectMake((imageW-imageH)/2, 0, imageH, imageH);
                CGImageRef cgimage=CGImageCreateWithImageInRect([image CGImage], rect);
                imageview.image=[UIImage imageWithCGImage:cgimage];
                CGImageRelease(cgimage);

                imageview.frame = CGRectMake(4, _width*0.025, _width*0.4, _width*0.4);


            }else
            {
                imageview.frame = CGRectMake(_width*(0.4-0.4/4.5)/2+4, _width*0.025, _width*0.4/4.5, _width*0.4);
            }
        }


    }];
//    imageview.layer.cornerRadius=5;
    imageview.clipsToBounds=YES;
    [backview addSubview:imageview];


    UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03-2, _width*0.025-2, _width*0.3+4, _width*0.25+4)];

    kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
    kuang.layer.borderWidth=1;
    [backview addSubview:kuang];


    if (isRush ==NO) {
        UIImageView *promotion = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03-2, _width*0.025-2, _width*0.13, _width*0.13)];
        if ([dic[@"isPromotion"]integerValue]==1) {
            promotion.image = [UIImage imageNamed:@"cuxiao"];
        }
        if ([dic[@"isRecommend"]integerValue]==1) {
            promotion.image = [UIImage imageNamed:@"tuijian"];
        }

        [backview addSubview:promotion];
        
    }

//    UILabel*distance_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _width*0.2, _width*0.3, _width*0.05)];
//    distance_L.text=[NSString stringWithFormat:@"约%@km",@"111"];
//    distance_L.font=[UIFont systemFontOfSize:12];
//    distance_L.textAlignment=NSTextAlignmentCenter;
//    distance_L.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
//    distance_L.textColor=[UIColor whiteColor];
//    [imageview addSubview:distance_L];
////    if ([NSString stringWithFormat:@"%@",distance].length==0) {
//        distance_L.hidden=YES;
////    }

    UILabel*shop_name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, 2, _width*0.6, _width*0.1)];
    shop_name.text=dic[@"productName"];
    shop_name.numberOfLines=2;
    shop_name.textAlignment=NSTextAlignmentLeft;
    shop_name.textColor=[UIColor blackColor];
    shop_name.font=[UIFont systemFontOfSize:15];
    [backview addSubview:shop_name];


    UILabel*price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.12, _width*0.65, _width*0.1)];
    price.text=[NSString stringWithFormat:@"￥%.2f",[dic[@"ratePrice"] doubleValue]];
    price.numberOfLines=0;
    price.textAlignment=NSTextAlignmentLeft;
    price.textColor=[UIColor orangeColor];
    price.font=[UIFont systemFontOfSize:16];
    [backview addSubview:price];
      //设置原价Lable
        UILabel *originlable1 = [[UILabel alloc]init];
        originlable1.font = [UIFont systemFontOfSize:11];
        originlable1.textColor = [UIColor lightGrayColor];
        NSString *oldprice = [NSString stringWithFormat:@"￥%.2f",[dic[@"price"]  doubleValue]] ;
        originlable1.text =oldprice;
    
        //计算单行文字的size
        CGSize orgsize = [originlable1.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        originlable1.frame = CGRectMake(_width*0.63, price.frame.origin.y, orgsize.width, price.frame.size.height);
        //给Lable 加删除线
    
        NSUInteger length = [oldprice length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:oldprice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
        [originlable1 setAttributedText:attri];
        [backview addSubview:originlable1];

        UILabel*discount=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, price.frame.origin.y, _width*0.55, _width*0.1)];
    CGFloat rateCount = [dic[@"ratePrice"] doubleValue]/[dic[@"price"] doubleValue]*10;
    if (rateCount==10.0) {
        discount.text=@"";
    }else{
        discount.text=[NSString stringWithFormat:@"%.1f折",rateCount];

    }
        discount.numberOfLines=0;
        discount.textAlignment=NSTextAlignmentRight;
        discount.textColor=[UIColor orangeColor];
        discount.font=[UIFont systemFontOfSize:12];
        [backview addSubview:discount];


    UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.2, _width*0.3, _width*0.08)];
    name_L.text=[NSString stringWithFormat:@"人气：%@",dic[@"showClicks"]];
    name_L.numberOfLines=0;
    name_L.textAlignment=NSTextAlignmentLeft;
    name_L.textColor=[UIColor lightGrayColor];
    name_L.font=[UIFont systemFontOfSize:12];
    [backview addSubview:name_L];


    UILabel*salesQuality_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.6, _width*0.2, _width*0.3, _width*0.08)];
    salesQuality_L.text=[NSString stringWithFormat:@"销量：%@",dic[@"salesQuality"]];
    salesQuality_L.numberOfLines=0;
    salesQuality_L.textAlignment=NSTextAlignmentLeft;
    salesQuality_L.textColor=[UIColor lightGrayColor];
    salesQuality_L.font=[UIFont systemFontOfSize:12];
    [backview addSubview:salesQuality_L];

    UIImageView*shopcar=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.88, _width*0.3-25, 20, 20)];
    shopcar.image=[UIImage imageNamed:@"shopcar3"];
//    [backview addSubview:shopcar];
    UIButton *addShop = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.8, _width*0.3-44, _width*0.15, 44)];
    [addShop addTarget:self action:@selector(addshoptocar:) forControlEvents:UIControlEventTouchUpInside];
//    [backview addSubview:addShop];





    if (isRush==YES) {
//        shopcar.hidden=YES;
//        addShop.hidden = YES;
//        discount.hidden= YES;
//        originlable1.hidden = YES;
        [shopcar removeFromSuperview];
        [addShop removeFromSuperview];
        [discount removeFromSuperview];
        [originlable1 removeFromSuperview];
        [name_L removeFromSuperview];

        backview.frame = CGRectMake(5, 5, _width-10, _width*0.45);
        kuang.frame = CGRectMake(3, _width*0.025-2, _width*0.4+4, _width*0.4+4);
        shop_name.frame =CGRectMake(_width*0.44, 10, _width*0.55, _width*0.15);
        shop_name.font=[UIFont systemFontOfSize:15];
        shop_name.numberOfLines=2;

        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.44, _width*0.17, _width*0.51, _width*0.11)];
        backImg.image = [UIImage imageNamed:@"限时"];
        [backview addSubview:backImg];

        if ([dic[@"rushPrice"] integerValue]==0) {
            price.text=[NSString stringWithFormat:@"特价%@元",dic[@"rushPrice"]];

        }else{
            price.text=[NSString stringWithFormat:@"特价%ld元",(long)[dic[@"rushPrice"] integerValue]];

        }

        price.bounds = CGRectMake(0, 0, _width*0.3, _width*0.11);
        price.center= CGPointMake(_width*0.57, backImg.center.y);
        price.textColor=[UIColor whiteColor];
        price.font=[UIFont systemFontOfSize:12];
        price.textAlignment=NSTextAlignmentCenter;
        price.attributedText = [self changColor:price.text];
        [backview bringSubviewToFront:price];


        UILabel *endTime = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.44, _width*0.35,_width*0.6, _width*0.08)];

        endTime.text = [NSString stringWithFormat:@"结束时间：%@",[dic[@"rushEndTime"] substringToIndex:19]] ;
        endTime.font =[UIFont systemFontOfSize:10];
        endTime.textColor =[UIColor darkGrayColor];
        [backview addSubview:endTime];

        buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.7-5, (_width*0.195), _width*0.22, _width*0.06)];
        buyBtn.layer.cornerRadius = 3;
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [buyBtn addTarget:self action:@selector(buySelect:) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.tag = indexPath.row+55;
        [backview addSubview:buyBtn];

        


//定时器。倒计时。。。



        timeSting = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.44, _width*0.28, _width*0.6, _width*0.08)];
//        timeSting.text = dic[@"rushBeginTime"];
        timeSting.textColor = [UIColor darkGrayColor];
        timeSting.font =[UIFont systemFontOfSize:10];
        [backview addSubview:timeSting];


        //第三方定时器
        timerExample9 = [[MZTimerLabel alloc] initWithLabel:timeSting andTimerType:MZTimerLabelTypeTimer];

        NSDate *today = [NSDate date];    //得到当前时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        NSDate *dateString = [dateFormatter dateFromString:dic[@"rushBeginTime"]];
        CGFloat kaishi = [dateString timeIntervalSinceDate:today];

        NSDate *jieshudateString = [dateFormatter dateFromString:dic[@"rushEndTime"]];
        CGFloat jieshu = [jieshudateString timeIntervalSinceDate:today];

//        NSLog(@"  ---%d== %d===***%f********%f",indexPath.row,indexPath.section,kaishi,jieshu);
/*活动没开始，或 活动结束，tag ++22

 
 */
       if(kaishi >0.1){
            [timerExample9 setCountDownTime:kaishi];

        }else
        {
            [timerExample9 setCountDownTime:jieshu];
        }

        if (kaishi >0.1 || jieshu < 0.1) {
            timerExample9.tag = indexPath.row +22;

        }else{
            timerExample9.tag = indexPath.row + 3333;

        }

          timerExample9.delegate = self;
        [timerExample9 start];






        if (kaishi<0 && jieshu>0) {
            buyBtn.backgroundColor =[UIColor yellowColor];
            [buyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

            buyBtn.userInteractionEnabled = YES;


        } else{
               buyBtn.backgroundColor = [UIColor lightGrayColor];
            buyBtn.userInteractionEnabled = NO;
            if (jieshu <0) {
                timeSting.text = @"活动已经结束！！!";

            }
        }


    }


    return cell;
}


- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
//    NSLog(@"222222222===%d",timerLabel.tag);

//    NSLog(@"---%f",time);
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int days = time / 3600/24;
    int hours = ((int)(time / 3600))%24;


    if (timerLabel.tag>=3333) {
        if (days ==0) {
            return [NSString stringWithFormat:@"离结束还剩：%02d小时 %02d分 %02d秒",hours,minute,second];
        }else
            return [NSString stringWithFormat:@"离结束还剩：%02d天 %02d小时 %02d分 %02d秒",days,hours,minute,second];
    }else {

        if (days ==0) {
            return [NSString stringWithFormat:@"离开始还剩：%02d小时 %02d分 %02d秒",hours,minute,second];
        }else
            return [NSString stringWithFormat:@"离开始还剩：%02d天 %02d小时 %02d分 %02d秒",days,hours,minute,second];
    }

}

-(void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{



    int tag ;
    if (timerLabel.tag >=3333) {
        //活动结束、、
        isConclusion = YES;
        tag =timerLabel.tag-3333 ;
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:tag inSection:0];

        UITableViewCell *cell = [ _tableView cellForRowAtIndexPath:indexP];

        for (UIView *view in [cell.contentView.subviews[0] subviews]) {

            if ([view isKindOfClass:[UIButton class]]) {

                UIButton *button = (UIButton*)view ;
               button.backgroundColor = [UIColor lightGrayColor];
              button.userInteractionEnabled = NO;
              [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            }

        }

//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:UITableViewRowAnimationNone];
//        NSLog(@"$$$$$$$$$$$$%d++++++%d",timerLabel.tag,[[cell.contentView.subviews[0] subviews] count] );

//
    }else{
        tag =timerLabel.tag-22 ;
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:tag inSection:0];

        UITableViewCell *cell = [ _tableView cellForRowAtIndexPath:indexP];

        for (UIView *view in [cell.contentView.subviews[0] subviews]) {

            if ([view isKindOfClass:[UIButton class]]) {

                UIButton *button = (UIButton*)view ;
                button.backgroundColor = [UIColor yellowColor];
                button.userInteractionEnabled = YES;
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
            }
            
        }
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:UITableViewRowAnimationNone];


    }

//    [_tableView reloadData];

}


-(void)getData:(NSString *)more
{

    UIImageView*iv=(UIImageView*)[self.view viewWithTag:22222];
    UILabel*la=(UILabel*)[self.view viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    urlString=[NSString stringWithFormat:@"%@/product/search.action?" ,BASE_URL];


    NSLog(@"categoryId ====%@",self.view.subviews);

    if (self.categoryId!=nil) {
        urlString=[NSString stringWithFormat:@"%@/product/search.action?categoryId=%@" ,BASE_URL,self.categoryId];

        NSLog(@"url ====%@",urlString);
    }

     if (self.kw!=nil||self.kw.length!=0) {
            urlString=[NSString stringWithFormat:@"%@&kw=%@",urlString,self.kw];
    }



        LOADVIEW

    [requestData getData:urlString complete:^(NSDictionary *dic) {
        LOADREMOVE
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
       _dataArray=[dic objectForKey:@"data"];


        [_tableView reloadData];
        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-150)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            tanhao.tag =22222;
            [self.view addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-150)/2+60, _width, 20)];
            tishi.text=@"暂无相关商品！";
            tishi.tag=222222;
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [self.view addSubview:tishi];
            
            
        }


          }];
}

-(void)getRushData:(NSString *)more
{

    UIImageView*iv=(UIImageView*)[self.view viewWithTag:22222];
    UILabel*la=(UILabel*)[self.view viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

//    NSLog(@"+++%@",iv);

    urlString=[NSString stringWithFormat:@"%@/product/rushProList.action" ,BASE_URL];
        NSLog(@"+++%@",urlString);


    LOADVIEW

    [requestData getData:urlString complete:^(NSDictionary *dic) {
        LOADREMOVE
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        _dataArray=[dic objectForKey:@"data"];


        [_tableView reloadData];
        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-150)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            tanhao.tag = 22222;
            [self.view addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-150)/2+60, _width, 20)];
            tishi.text=@"暂无相关商品！";
            tishi.tag =222222;
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [self.view addSubview:tishi];
            
            
        }
        
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{




    if (isRush) {


        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        for (UIView *view in [cell.contentView.subviews[0] subviews]) {

            if ([view isKindOfClass:[UIButton class]]) {

                UIButton *button = (UIButton*)view ;

                if (button.userInteractionEnabled) {

                    PUSH(productVC)
                    vc.productId = [_dataArray[indexPath.row] objectForKey:@"productId"];
                    vc.isWhoPush = @"rush";

                }else{
                    return;
                    
                    
                }
                
            }
            
        }


    }else{
        PUSH(productVC)
        vc.productId = [_dataArray[indexPath.row] objectForKey:@"productId"];
    }

}
-(void)addshoptocar:(UIButton*)sender{
    NSLog(@"加入购物车");
    PUSH(shopCarVC)
}
-(void)buySelect:(UIButton*)sender{

    NSLog(@"买买买");

    PUSH(productVC)
    vc.productId = [_dataArray[buyBtn.tag-55] objectForKey:@"productId"];
    vc.isWhoPush = @"rush";

}
-(void)topSelect:(UIButton *)button{

//    [_tableView removeFromSuperview];
//    for (UIView *view in self.view.subviews) {
//        if ([view isKindOfClass:[UITableView class]]) {
//            [view removeFromSuperview];
//        }
//    }
//[self tableView:_tableView cellForRowAtIndexPath:i]
//    [self initTableView];
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];


    if (mybutton==button) {

    }else
    {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [mybutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    mybutton=button;

    if (button.tag==0) {
        [self getData:@""];
        isRush = NO;


    }

   if(button.tag ==1){
        [self getRushData:@""];

       isRush = YES;
    }

//    [bigScrol setContentOffset:CGPointMake(_width*button.tag, 0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick
{
//    NSLog(@"back");
POP
}

-(void)rightUpBtnClick{
    PUSH(searchViewController)
//    NSLog(@"sssssssssss");
}
-(NSMutableAttributedString*)changColor:(NSString*)string{

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    //设置：在2-个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(2, string.length-3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(2, string.length-3)];



    return str;
}


-(void)viewDidDisappear:(BOOL)animated{
//    [timer invalidate];

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
