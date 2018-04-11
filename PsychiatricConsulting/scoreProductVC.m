//
//  productVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-4-1.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "scoreProductVC.h"
#import "webViewVC.h"
#import "logInVC.h"
#import "sureOrderVC.h"

@interface scoreProductVC ()

@end

@implementation scoreProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"积分商品")

    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-45) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;

    [self.view addSubview:_tableView];

    UIButton*exchangeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    exchangeBtn.frame=CGRectMake(_width*0.02, _height-45, _width*0.96, 40) ;
    exchangeBtn.backgroundColor=APP_ClOUR;
    [exchangeBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exchangeBtn addTarget:self action:@selector(exchangeProduct) forControlEvents:UIControlEventTouchUpInside];
    exchangeBtn.layer.cornerRadius=5;
    [self.view addSubview:exchangeBtn];



    [self getData];


    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];


}
-(void)exchangeProduct
{
    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{

        }];
    }else
    {
        NSDictionary*dic=[_dataDic objectForKey:@"product"];

        NSString*shopId=[dic objectForKey:@"shopId"];

        id shopLogo=[dic objectForKey:@"shopLogo"];
        if (shopLogo==[NSNull null]) {
            shopLogo=@"";
        }
        NSString*imagePath=[dic objectForKey:@"imagePath"];
        NSString*productId=[dic objectForKey:@"productId"];
        NSString*productName=[dic objectForKey:@"productName"];
        NSString*productQuantity=[dic objectForKey:@"productQuantity"];
        NSString*ratePrice=[dic objectForKey:@"ratePrice"];
        NSString*userScore=[dic objectForKey:@"userScore"];

        // NSString*shopName=[dic objectForKey:@"shopName"];

        NSMutableDictionary*mudic=[[NSMutableDictionary alloc]init];

        NSMutableArray*goodArry=[[NSMutableArray alloc]init];
        NSMutableDictionary*productDic=[[NSMutableDictionary alloc]init];

        [mudic setObject:shopId forKey:@"shopId"];
        [mudic setObject:shopLogo forKey:@"shopLogo"];
        // [mudic setObject:shopName forKey:@"shopName"];



        [productDic setObject:productId forKey:@"productId"];
        [productDic setObject:imagePath forKey:@"imagePath"];
        [productDic setObject:productName forKey:@"productName"];
        [productDic setObject:ratePrice forKey:@"ratePrice"];
        [productDic setObject:productQuantity forKey:@"productQuantity"];
        [productDic setObject:userScore forKey:@"userScore"];


        [productDic setObject:@"1" forKey:@"count"];

        [goodArry addObject:productDic];

        NSDictionary*postDic=@{@"shop":mudic,@"good":goodArry};
        
        PUSH(sureOrderVC)
        vc.InfoArray=postDic;
        vc.whoPush=@"jifen";

    }
    
}

-(void)getData
{
    LOADVIEW
    [requestData getData:SCORE_LIST_DETAIL_URL(self.productId) complete:^(NSDictionary *dic) {
        NSLog(@"%@",SCORE_LIST_DETAIL_URL(self.productId));
        LOADREMOVE
        _dataDic=dic;
        _productImageA=[[_dataDic objectForKey:@"product"] objectForKey:@"productImage"];
       // NSLog(@"%@==========",_productImageA);
        [_tableView reloadData];

    }];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }else
    {
        return 2;
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return _width+30;
    }else
    {
        return 10;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else
    {

        return 10;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else
        {
            return 50;
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==1) {
            return _webH;
        }else{
            return 50;
        }

    }else
    {
        return 50;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {

        UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _width+30)];
        _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _width)];
        _smallScrollV.contentSize=CGSizeMake(_width*_productImageA.count, _width);
        _smallScrollV.pagingEnabled=YES;
        _smallScrollV.bounces=NO;
        _smallScrollV.backgroundColor=[UIColor whiteColor];
        //NSLog(@"jjjjjjj%d",_advistArray.count);

        //NSLog(@"=====================%d",_productImageA.count);

        if (_productImageA.count==0) {
            UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width)];
            imagev.image=[UIImage imageNamed:@"fang"];
            [_smallScrollV addSubview:imagev];
        }else{
            for (int i=0; i<_productImageA.count; i++) {
                NSLog(@"%@",[[_productImageA objectAtIndex:i] objectForKey:@"imagePath"]);
                UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
                [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_productImageA objectAtIndex:i] objectForKey:@"imagePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                    if (image==nil) {
                        return ;
                    }

                    float  imageW=image.size.width;
                    float  imageH=image.size.height;
//                    CGRect rect;
                    NSLog(@"==%f--%f",imageW,imageH);
//                    if (imageW>_width && imageH>_width) {
//                        if (imageW>imageH) {
//                            rect=CGRectMake((imageW-imageH)/2, 0, imageH, imageH);
//
//                        }else
//                        {
//                            rect=CGRectMake(0, -(imageW-imageH)/2, imageW, imageW);
//
//                        }
//                        CGImageRef cgimage=CGImageCreateWithImageInRect([image CGImage], rect);
//                        [view setBackgroundImage:[UIImage imageWithCGImage:cgimage] forState:UIControlStateNormal];
//                        CGImageRelease(cgimage);
//
//                    }else  {
                        if (imageH>imageW) {
                        float  W=(_width)*image.size.width/image.size.height;
                            NSLog(@"+++++%f",W);
                        view.frame=CGRectMake((_width-W)/2+_width*(i), 0, W, _width);

                    }else
                    {
                        float  H=_width*image.size.height/image.size.width;
                        view.frame=CGRectMake(_width*(i), (_width-H)/2, _width, H);
                        NSLog(@"===%@",view);

                    }

//                    }



                }];
//                view.frame=CGRectMake(_width*i, 0, _width, _width);

//                view.tag=i;
                view.backgroundColor=[UIColor darkGrayColor];
                if (i==2) {
                    view.backgroundColor=[UIColor redColor];
                }
//                [view addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
                //view.backgroundColor=[UIColor yellowColor];
                [_smallScrollV addSubview:view];

                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_width*i, 0, _width, _width/1.5)];
                button.tag = i;
                [_smallScrollV addSubview:button];
                [button addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
            }

        }
        _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _width-30, _width, 30)];
        _pc.currentPage=0;
        _pc.numberOfPages=_productImageA.count;
        _pc.currentPageIndicatorTintColor=[UIColor redColor];
        _pc.pageIndicatorTintColor = [UIColor lightGrayColor];
        if (_productImageA.count==1) {
            _pc.currentPageIndicatorTintColor=[UIColor clearColor];
        }

        [bgView addSubview:_smallScrollV];
        [bgView addSubview:_pc];

        NSDictionary*proDic=[_dataDic objectForKey:@"product"];

        id  productCode=[proDic objectForKey:@"productCode"];
        if (productCode==[NSNull null]) {
            productCode=@"暂无";
        }

        _productCode_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _width, _width, 30)];
        _productCode_L.textAlignment=NSTextAlignmentLeft;
        _productCode_L.font=[UIFont systemFontOfSize:12];
        _productCode_L.textColor=[UIColor darkGrayColor];
        _productCode_L.text=[NSString stringWithFormat:@"   商品编号: %@",productCode];
        [bgView addSubview:_productCode_L];

        return bgView;

    }else
    {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    PUSH(webViewVC)
//    vc.url=PRODUCT_URL_SKU(self.productId);
    if (indexPath.section==1) {
        if (indexPath.row==0) {
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];


}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];

    NSDictionary*proDic=[_dataDic objectForKey:@"product"];


    id  SalesQuality=[proDic objectForKey:@"SalesQuality"];
    if (SalesQuality==[NSNull null]) {
      // SalesQuality=@"0";
    }
    id  postage=[proDic objectForKey:@"postage"];
    if (postage==[NSNull null]) {
        postage=@"0";
    }
    id  price=[proDic objectForKey:@"price"];
    if (price==[NSNull null]) {
        price=@"0";
    }

    id  productQuantity=[proDic objectForKey:@"productQuantity"];
    if (productQuantity==[NSNull null]) {
        productQuantity=@"0";
    }
    id  ratePrice=[proDic objectForKey:@"ratePrice"];
    if (ratePrice==[NSNull null]) {
       // ratePrice=@"0";
    }
    id  shopLogo=[proDic objectForKey:@"shopLogo"];
    if (shopLogo==[NSNull null]) {
        shopLogo=nil;
    }
    id  showClicks=[proDic objectForKey:@"showClicks"];
    if (showClicks==[NSNull null]) {
      //  showClicks=@"0";
    }
    id  productSubName=[proDic objectForKey:@"productSubName"];
    if (productSubName==[NSNull null]||productSubName==nil||[NSString stringWithFormat:@"%@",productSubName].length==0) {
        productSubName=nil;
    }
    NSString*userScore=[proDic objectForKey:@"userScore"];
    NSString*unitName=[proDic objectForKey:@"unitName"];




    if (indexPath.section==0) {
        if (indexPath.row==0) {


            _productName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 0, _width*0.7, 40)];
            _productName_L.textAlignment=NSTextAlignmentLeft;
            if (productSubName==nil) {
                _productName_L.text=[NSString stringWithFormat:@"%@",[proDic objectForKey:@"productName"]];
            }else
            {
                _productName_L.text=[NSString stringWithFormat:@"%@(%@)",[proDic objectForKey:@"productName"],productSubName];
                _productName_L.numberOfLines=2;
            }

            _productName_L.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_productName_L];


            _price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, 40, _width*0.35, 20)];
            _price_L.textAlignment=NSTextAlignmentLeft;
            _price_L.textColor=[UIColor grayColor];
            _price_L.text=[NSString stringWithFormat:@"￥%.2f",[price doubleValue]];
            _price_L.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_price_L];


            NSDictionary *attrDict1 = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                         NSFontAttributeName: [UIFont systemFontOfSize:14] };
            _price_L.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"￥%.2f",[price doubleValue]] attributes: attrDict1];


            _ratePrice_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 40, _width*0.35, 20)];
            _ratePrice_L.textAlignment=NSTextAlignmentLeft;
            _ratePrice_L.textColor=[UIColor redColor];
            _ratePrice_L.text=[NSString stringWithFormat:@"%@积分",userScore];
            _ratePrice_L.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_ratePrice_L];



        }
        if (indexPath.row==1) {
            for (int i=0; i<2; i++) {
                UILabel*four_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.5*i, 0, _width*0.25, 50)];
                four_L.textAlignment=NSTextAlignmentRight;
                four_L.textColor=[UIColor grayColor];
                if (i==0) {
                    four_L.text=@"全国";
                }
                if (i==1) {
                    four_L.text=@"库存";
                }
                four_L.font=[UIFont systemFontOfSize:11];
                [cell.contentView addSubview:four_L];

            }

            _post_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.25*1, 0, _width*0.25, 50)];
            _post_L.textAlignment=NSTextAlignmentLeft;
            _post_L.textColor=[UIColor darkGrayColor];
            if ([postage intValue]==0) {
                postage=@"包邮";
            }
            _post_L.text=[NSString stringWithFormat:@"%@",postage];
            _post_L.font=[UIFont systemFontOfSize:11];
            [cell.contentView addSubview:_post_L];


//            _saleQulity_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.125*3, 0, _width*0.125, 40)];
//            _saleQulity_L.textAlignment=NSTextAlignmentLeft;
//            _saleQulity_L.textColor=[UIColor darkGrayColor];
//            _saleQulity_L.text=[NSString stringWithFormat:@"%@%@",SalesQuality,unitName];
//            _saleQulity_L.font=[UIFont systemFontOfSize:11];
//            [cell.contentView addSubview:_saleQulity_L];



            _qulity_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.25*3, 0, _width*0.25, 50)];
            _qulity_L.textAlignment=NSTextAlignmentLeft;
            _qulity_L.textColor=[UIColor darkGrayColor];
            _qulity_L.text=[NSString stringWithFormat:@"%@%@",productQuantity,unitName];
            _qulity_L.font=[UIFont systemFontOfSize:11];
            [cell.contentView addSubview:_qulity_L];


//            _clicks_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.125*7, 0, _width*0.125, 40)];
//            _clicks_L.textAlignment=NSTextAlignmentLeft;
//            _clicks_L.textColor=[UIColor darkGrayColor];
//            _clicks_L.text=[NSString stringWithFormat:@"%@",showClicks];;
//            _clicks_L.font=[UIFont systemFontOfSize:11];
//            [cell.contentView addSubview:_clicks_L];


        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {

           // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.imageView.image=[UIImage imageNamed:@"productDetail"];
                cell.textLabel.text=@"图文详情";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }

        }
        if (indexPath.row==1) {
            UIWebView*web=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, _width, 100)];
            //NSLog(@"------%@",PRODUCT_URL_SKU(self.productId));
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PRODUCT_URL_SKU(self.productId)]]];
            web.scalesPageToFit=YES;
            web.userInteractionEnabled=NO;
            web.scrollView.scrollEnabled=NO;
            web.delegate=self;
            [cell.contentView addSubview:web];
        }
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"fchwoie");
    int currentPage=_imageScrollView.contentOffset.x/_width+1;
    _page_L.text=[NSString stringWithFormat:@"%d/%d",currentPage,_page_number];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    webView.frame=CGRectMake(0, 0, _width, documentHeight+30);



    NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:1];

    _webH=documentHeight+30;

    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

}
-(void)advistBtn:(UIButton*)button
{
    UIView*view=(UIView*)[button superview];
    NSLog(@"%ld",(long)view.tag);



    NSArray*imageListArray=_productImageA;


    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    BGView=[[UIView alloc]init];
    BGView.center=button.center;
    BGView.bounds=CGRectMake(0, 0, 0, 0);
    BGView.backgroundColor=[UIColor whiteColor];
    [window addSubview:BGView];
    [UIView animateWithDuration:0.02 animations:^{
        BGView.frame=window.frame;
    } completion:^(BOOL finished) {

        _imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
        _imageScrollView.pagingEnabled=YES;
        _imageScrollView.bounces=NO;
        _imageScrollView.delegate=self;
        _imageScrollView.contentSize=CGSizeMake(_width*imageListArray.count,_height) ;

        _imageScrollView.contentOffset=CGPointMake(_width*button.tag, 0);

        _page_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _height-70, _width, 40)];
        _page_L.text=[NSString stringWithFormat:@"%ld/%lu",button.tag+1,(unsigned long)imageListArray.count];
        _page_number=(int)imageListArray.count;
        _page_L.textAlignment=NSTextAlignmentCenter;
        _page_L.textColor=APP_ClOUR;

        //_imageScrollView.backgroundColor=[UIColor grayColor];


        //[BGView addSubview:_page_L];



        [BGView addSubview:_imageScrollView];

        for (int i=0; i<imageListArray.count; i++) {
            //NSDictionary*dic=[imageListArray objectAtIndex:i];
            UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*i,0, _width, _height)];

            NSString*imUrl=[[_productImageA objectAtIndex:i] objectForKey:@"imagePath"];


            [iv sd_setImageWithURL:[NSURL URLWithString:imUrl] placeholderImage:[UIImage imageNamed:@"morentu"]];

            UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imUrl]]];
            //NSLog(@"%f----%f",image.size.width,image.size.height);
//            float  H=_width*image.size.height/image.size.width;
//            //NSLog(@"%f",H);
//
//
//            iv.tag=1;
//            iv.center=CGPointMake(_width*i+_width/2, _height/2);
//            if (image==nil) {
//                iv.bounds=CGRectMake(0, 0, _width, 200);
//
//            }else
//            {
//                iv.bounds=CGRectMake(0, 0, _width, H);
//            }

    float  W=(_height-70)*image.size.width/image.size.height;
            //NSLog(@"%f",H);



            iv.tag=1;
            iv.center=CGPointMake(_width*i+_width/2, _height/2);
            if (image==nil) {
                iv.bounds=CGRectMake(0, 0, _width, 200);

            }else
            {
                iv.center=CGPointMake(_width*i+_width/2, _height/2);
                iv.bounds=CGRectMake(0, 0, W, _height-70);

                _imageScrollView.contentSize=CGSizeMake(_width*imageListArray.count,_height) ;
                
            }


            iv.image=image;
            [_imageScrollView addSubview:iv];
            iv.userInteractionEnabled=YES;

            UITapGestureRecognizer*doubleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
            doubleTap.numberOfTapsRequired=2;
            [iv addGestureRecognizer:doubleTap];


            UITapGestureRecognizer*backTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
            [backTap setNumberOfTapsRequired:1];
            [iv addGestureRecognizer:backTap];


            [backTap requireGestureRecognizerToFail:doubleTap];


        }
        [BGView addSubview:_page_L];


       // UIWindow *win=[UIApplication sharedApplication].keyWindow;

        UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 64)];
        topView.backgroundColor=APP_ClOUR;
        [BGView addSubview:topView];

        UILabel*storySign=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, _width, 44)];
        storySign.text=[NSString stringWithFormat:@"商品图片"];
        storySign.textAlignment=NSTextAlignmentCenter;
        storySign.textColor=[UIColor whiteColor];
        [BGView addSubview:storySign];


        UIImageView*backBtn=[[UIImageView alloc]init];
        backBtn.frame=CGRectMake(_width*0.06, 30, 12, 20);
        backBtn.image=[UIImage imageNamed:@"left.png"];
        [BGView addSubview:backBtn];

        UIButton*butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(0, 20, _width*0.2, 44);
        [butt addTarget:self action:@selector(imageBack:) forControlEvents:UIControlEventTouchUpInside];
        //butt.backgroundColor=[UIColor whiteColor];
        [BGView addSubview:butt];

    }];
}
-(void)single:(UITapGestureRecognizer*)gest
{
    UIScrollView*scrollView=(UIScrollView*)gest.view;

    [scrollView removeFromSuperview];


}

-(void)backTap:(UITapGestureRecognizer*)gest
{
    [UIView animateWithDuration:0.02 animations:^{
        BGView.bounds=CGRectMake(0, 0, 0, 0);
        for (UIView*view in BGView.subviews) {
            [view removeFromSuperview];
        }
    } completion:^(BOOL finished) {

    }];
}
-(void)imageBack:(UIButton*)btn
{
    NSLog(@"drfgvbhjk");
    [BGView removeFromSuperview];
    [_bigImageSvrollView removeFromSuperview];
    [btn removeFromSuperview];
}
-(void)doubleTap:(UITapGestureRecognizer*)gest
{
    NSLog(@"fybn");
    UIImageView*view=(UIImageView*)gest.view;

    [_bigImageSvrollView removeFromSuperview];

    //    if (view.tag==1) {
    //        view.tag=2;

    _bigImageSvrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height)];
    
    _bigImageSvrollView.contentSize=CGSizeMake(view.frame.size.width*2, view.frame.size.height*2);
    _bigImageSvrollView.bounces=NO;
    
    _bigImageSvrollView.scrollEnabled=YES;
    UIImageView*imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width*2, view.frame.size.height*2)];
    imageV.image=view.image;
    
    [_bigImageSvrollView addSubview:imageV];
    
    
    UITapGestureRecognizer*single=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(single:)];
    [_bigImageSvrollView addGestureRecognizer:single];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_bigImageSvrollView];
    
    
    
}


-(void)timeAction
{
    if (_productImageA.count==0) {
        return;
    }
    static int i=0;
    i++;
    if (i==_productImageA.count) {
        i=0;
    }
    _pc.currentPage=i;
    [UIView animateWithDuration:0.5 animations:^{
        _smallScrollV.contentOffset=CGPointMake(_width*i, 0);
    }];
    

}

-(void)backClick
{
    self.tabBarController.tabBar.hidden=YES;
    POP
}
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
