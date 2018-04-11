//
//  productVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-4-1.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "productVC.h"
#import "webViewVC.h"
#import "hospitalVC.h"
#import "sureOrderVC.h"
#import "QuestionVC.h"
#import "commentListVC.h"
#import "logInVC.h"
#import "shopCarVC.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "ProductCell.h"
@interface productVC ()

@end

@implementation productVC


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *titlestring = [[_dataDic objectForKey:@"product"] objectForKey:@"productName"];

    _webHight = _width;
    TOP_VIEW(@"商品详情")


    UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.95-23, 25,25, 25);

    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"zixun"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];

    rightUpBtnBack=[myButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 0,_width*0.8, 64);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    rightUpBtnBack.isClicked=NO;
    [topView addSubview:rightUpBtnBack];

    _dataArray = [[NSMutableArray alloc]initWithCapacity:3];
    _propertyArray = [[NSMutableArray alloc]init];

    self.navigationController.navigationBar.hidden=YES;

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-60) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    [self.view addSubview:_tableView];



    UIImageView*shopcar=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.1, _height-40, 20, 20)];
    shopcar.image=[UIImage imageNamed:@"shopcar1"];
    [self.view addSubview:shopcar];

    _redNumber=[[UILabel alloc]init];
    _redNumber.frame=CGRectMake(_width*0.1+20, _height-50, 16, 16);
    _redNumber.text=@"";
    _redNumber.textColor=[UIColor whiteColor];
    _redNumber.font=[UIFont systemFontOfSize:12];
    _redNumber.layer.cornerRadius=8;
    _redNumber.textAlignment=NSTextAlignmentCenter;
    _redNumber.backgroundColor=APP_ClOUR;
    _redNumber.clipsToBounds=YES;
    _redNumber.hidden=YES;
    [self.view addSubview:_redNumber];
    _count=@"1";


    UIButton*shopBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, _height-60, _width*0.3, 60)];
    [shopBtn addTarget:self action:@selector(shopCarClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:shopBtn];


    UIButton*addshop=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.3, _height-50, _width*0.3, 40)];
    [addshop setTitle:@"加入购物车" forState:UIControlStateNormal];
    addshop.titleLabel.font=[UIFont systemFontOfSize:15];
    addshop.layer.borderColor=RGB(234, 234, 234).CGColor;
    [addshop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addshop addTarget:self action:@selector(addshopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addshop.layer.borderWidth=1;
    addshop.layer.cornerRadius=5;
    [self.view addSubview:addshop];

    UIButton*buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame=CGRectMake(_width*0.65, _height-50, _width*0.3, 40);
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    buyBtn.backgroundColor=APP_ClOUR;
    buyBtn.layer.cornerRadius=5;
    [buyBtn addTarget:self action:@selector(goBuyNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];

   // [self getData];
    //_imageH=_width/2;

    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

    self.producdesc=@"";

    _webH=1;
//     [self getData];


    if ([self.isWhoPush isEqualToString:@"rush"]) {
        addshop.hidden= YES;
        shopBtn.hidden = YES;
        shopcar.hidden = YES;
        _redNumber.hidden = YES;
        buyBtn.frame=CGRectMake(_width*0.1, _height-50, _width*0.8, 40);

    }
}

-(void)getData
{
       LOADVIEW
    [requestData getData:PRODUCT_URL_DETAIL(USERID, self.productId,markId) complete:^(NSDictionary *dic) {
        LOADREMOVE
        NSLog(@"%@",PRODUCT_URL_DETAIL(USERID, self.productId,markId));
        _dataDic=dic;
        _productImageA=[[dic objectForKey:@"product"] objectForKey:@"productImage"];
        id carCount=[[dic objectForKey:@"product"] objectForKey:@"cartCounts"];
        self.shopId=[[dic objectForKey:@"product"] objectForKey:@"shopId"];
        self.producdesc=[[dic objectForKey:@"product"] objectForKey:@"productDesc"];
        self.productP=[NSString stringWithFormat:@"￥%@",[[dic objectForKey:@"product"] objectForKey:@"ratePrice"]];


        if (carCount==[NSNull null]||[carCount intValue]==0||USERID==nil) {

            _redNumber.hidden=YES;
        }else
        {
            _redNumber.hidden=NO;
            _redNumber.text=[NSString stringWithFormat:@"%@",carCount];
        }

        NSArray *arrayy = _dataDic[@"property"];
        for (int i =0; i <arrayy.count; i ++) {
            NSDictionary *dictt = arrayy[i];
            NSString *valueName = [self getTheNoNullStr:dictt[@"valueName"] andRepalceStr:@""];
            if (valueName.length!=0) {
                [_propertyArray addObject:dictt];
            }
        }


//        CGFloat hh = 0.0;
        _webH =0.0;

        for (int i =0; i <_propertyArray.count; i++) {
            NSDictionary *dic = _propertyArray[i];
            CGFloat hh= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"valueName"] WithFont:[UIFont systemFontOfSize:13]].height;
            CGFloat danhangHH= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"propertyName"] WithFont:[UIFont systemFontOfSize:13]].height;
            _webH +=MAX(44, (44-danhangHH+hh));
        }


//        return MAX(44, (44-danhangHH+hh));


        smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, _width,_webH) style:UITableViewStyleGrouped];
        smallTableView.tag =333;
        smallTableView.delegate=self;
        smallTableView.dataSource=self;
        smallTableView.separatorColor = RGB(234, 234, 234);
        smallTableView.bounces=YES;


        web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 45, _width,_webH)];
        //          [cell1.contentView addSubview:web];
        //                NSLog(@"------%@",PRODUCT_URL_SKU(self.productId));
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PRODUCT_URL_SKU(self.productId)]]];
        web.scalesPageToFit=YES;
        web.userInteractionEnabled=NO;
        web.scrollView.scrollEnabled=NO;
        web.hidden = NO;
        web.delegate=self;



        NSString*imagepa=[[dic objectForKey:@"product"] objectForKey:@"imagePath"];
        self.imagepath=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagepa]]];
        [smallTableView reloadData];
        [_tableView reloadData];


    }];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==333) {

        return _propertyArray.count;
    }else{
        if (section==1) {
            return 1;
        }else
        {
            return 2;
        }
    }


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag ==333) {
        return 1;
    }else
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag ==333) {
        return 0.1;
    }else{
        if (section==0) {
            return _width/1.5+30;
        }else
        {
            return 10;
        }
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.tag==333) {
        return 0.1;
    }else
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==333) {

        NSDictionary *dic = _propertyArray[indexPath.row];
        CGFloat hh= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"valueName"] WithFont:[UIFont systemFontOfSize:13]].height;
         CGFloat danhangHH= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"propertyName"] WithFont:[UIFont systemFontOfSize:13]].height;

        return MAX(44, (44-danhangHH+hh));
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 95;
            }else
            {
                //            CGSize  size=[self boundWithSize:CGSizeMake(_width*0.98, 0) WithString:self.producdesc WithFont:[UIFont systemFontOfSize:14]];
                //            return 45+size.height+10;
                return 50;

            }
            //    }else if (indexPath.section==2)
            //    {
            //        return 70;
        }else
        {
            return _webH+45;
            
        }

    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag==333) {
        return nil;
    }else{
        if (section==0) {

            UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/1.5)];
            _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/1.5)];
            _smallScrollV.contentSize=CGSizeMake(_width*_productImageA.count, _width*0.5);
            _smallScrollV.backgroundColor = [UIColor whiteColor];
            _smallScrollV.pagingEnabled=YES;
            _smallScrollV.bounces=NO;

            _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _width/1.5-30, _width, 30)];
            _pc.currentPage=0;
            _pc.numberOfPages=_productImageA.count;
            _pc.currentPageIndicatorTintColor=[UIColor redColor];
            _pc.pageIndicatorTintColor = [UIColor lightGrayColor];

            if (_productImageA.count==1) {
                _pc.currentPageIndicatorTintColor=[UIColor grayColor];
            }
            [_smallScrollV addSubview:_pc];
            [bgView addSubview:_smallScrollV];

            NSDictionary*proDic=[_dataDic objectForKey:@"product"];

            id  productCode=[proDic objectForKey:@"productCode"];
            if (productCode==[NSNull null]) {
                productCode=@"暂无";
            }

            _productCode_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _width/1.5, _width, 30)];
            _productCode_L.textAlignment=NSTextAlignmentLeft;
            _productCode_L.font=[UIFont systemFontOfSize:12];
            _productCode_L.textColor=[UIColor darkGrayColor];
            _productCode_L.text=[NSString stringWithFormat:@"   商品编号: %@",[self getTheNoNullStr:productCode andRepalceStr:@"暂无"]];

            _productCode_L.backgroundColor =RGB(239, 239, 243);
            [bgView addSubview:_productCode_L];


            if (_productImageA.count==0) {
                UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/1.5)];
                imagev.image=[UIImage imageNamed:@"chang"];
                [_smallScrollV addSubview:imagev];
            }else{
                for (int i=0; i<_productImageA.count; i++) {
                    //                NSLog(@"hhhhhh");
                    UIButton*view=[UIButton buttonWithType:UIButtonTypeSystem];
                    view.frame=CGRectMake(_width*(i), 0, _width, _width/1.5);

                    [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_productImageA objectAtIndex:i] objectForKey:@"imagePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                        if (image==nil) {
                            image=[UIImage imageNamed:@"chang"];
                        }
                        //                    float  H=_width*image.size.height/image.size.width;

                        float   w=image.size.width;
                        float   hh=image.size.height;
                        if (hh>w) {
                            //                        float   h=(hh-w)/2;
                            float  W=(_width/1.5)*image.size.width/image.size.height;

                            //                        CGRect rect =  CGRectMake(0, 0, W, _width/1.5);
                            //
                            //                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                            //                        [view setBackgroundImage:[UIImage imageWithCGImage:image.CGImage] forState:UIControlStateNormal];
                            //                         CGImageRelease(cgimg);
                            view.frame=CGRectMake(_width*(i)+(_width-W)/2, 0, W, _width/1.5);


                        }else
                        {
                            float  H=_width*image.size.height/image.size.width;
                            //                        float  ww=(w-hh)/2;
                            //                        CGRect rect =  CGRectMake(ww, 0, hh,hh);
                            //                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                            //                        [view setBackgroundImage:[UIImage imageWithCGImage:cgimg] forState:UIControlStateNormal];
                            //                         CGImageRelease(cgimg);
                            view.frame=CGRectMake(_width*(i), (_width/1.5-H)/2, _width, _width/1.5);
                            
                            
                        }
                        
                        
                        
                    }];
                    
                    
                    //                view.tag=i;
                    view.backgroundColor=[UIColor whiteColor];
                    if (i==2) {
                        view.backgroundColor=[UIColor redColor];
                    }
                    [_smallScrollV addSubview:view];
                    
                    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_width*i, 0, _width, _width/1.5)];
                    button.tag = i;
                    [_smallScrollV addSubview:button];
                    [button addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
                    //view.backgroundColor=[UIColor yellowColor];
                }
                
            }
            
            
            return bgView;
            
        }else
        {
            return nil;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==333) {

    }else{
        //     NSDictionary*proDic=[_dataDic objectForKey:@"product"];
        //     NSString*productId=[proDic objectForKey:@"productId"];
        if (indexPath.section==0) {
            if (indexPath.row==1) {
                id  comment=[_dataDic objectForKey:@"comment"];

                if ([comment integerValue]==0) {

                }else{
                    PUSH(commentListVC)
                    vc.productId=self.productId;

                }
            }
        }

        if (indexPath.section==1) {

            //        PUSH(webViewVC)
            //        vc.url=PRODUCT_URL_SKU(productId);
            //        NSLog(@"------%@",vc.url);
            //        vc.whoPush=@"productDetail";
        }
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        

    }


}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==333) {

        tableView.frame = CGRectMake(0, 45, _width,tableView.contentSize.height);
        [tableView beginUpdates];
        [tableView endUpdates];
    }

    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==333) {

        ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[ProductCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cellID"];
//            cell.textLabel.textColor = [UIColor darkGrayColor];
//            cell.detailTextLabel.numberOfLines = 2;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;

        }



        NSDictionary *dic = _propertyArray[indexPath.row];

        cell.titleLab.text = dic[@"propertyName"];
        cell.contentLab.text = [self getTheNoNullStr: dic[@"valueName"] andRepalceStr:@""];

        CGFloat hh= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"valueName"] WithFont:[UIFont systemFontOfSize:13]].height;
        CGFloat danhangHH= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"propertyName"] WithFont:[UIFont systemFontOfSize:13]].height;

        cell.titleLab.frame = CGRectMake(15, 0, _width*0.4, MAX(44, (44-danhangHH+hh)));

        cell.contentLab.frame = CGRectMake(_width*0.4, 0, _width*0.55, MAX(44, (44-danhangHH+hh)));
        cell.shuXian.frame = CGRectMake(_width*0.4-20, 0, 1, MAX(44, (44-danhangHH+hh)));



              return cell;
    }else{

        UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        UITableViewCell*cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];

        [tableView setSeparatorInset:UIEdgeInsetsZero];

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSDictionary*rushDic=[_dataDic objectForKey:@"rush"];
        NSDictionary*proDic=[_dataDic objectForKey:@"product"];


        id  comment=[_dataDic objectForKey:@"comment"];
        if (comment==[NSNull null]) {
            comment=@"0";
        }


        id  price=[proDic objectForKey:@"price"];
        if (price==[NSNull null]) {
            price=@"0";
        }
        id  productCode=[proDic objectForKey:@"productCode"];
        if (productCode==[NSNull null]||productCode==nil) {
            //productCode=@"0";
        }
        id  ratePrice=[proDic objectForKey:@"ratePrice"];
        if (ratePrice==[NSNull null]) {
            ratePrice=@"";
        }
        id  shopLogo=[proDic objectForKey:@"shopLogo"];
        if (shopLogo==[NSNull null]||shopLogo==nil) {
            shopLogo=@"";
        }

        id  productSubName=[proDic objectForKey:@"productSubName"];
        if (productSubName==[NSNull null]||productSubName==nil) {
            productSubName=@"";
        }
        id  productName=[proDic objectForKey:@"productName"];
        if (productName==[NSNull null]||productName ==nil) {
            productName=@"";
        }
        // NSString*productDesc=[proDic objectForKey:@"productDesc"];
        id  shopName=[proDic objectForKey:@"shopName"];
        if (shopName==[NSNull null]||shopName ==nil) {
            shopName=@"";
        }

        id  shopde=[proDic objectForKey:@"grade"];
        if (shopde==[NSNull null]||shopde==nil) {
            shopde=@"";
        }
        id  postage=[proDic objectForKey:@"postage"];
        if (postage==[NSNull null]||postage==nil) {
            postage=@"";
        }
        id  userScore=[proDic objectForKey:@"productScore"];
        if (userScore==[NSNull null]||userScore==nil) {
            userScore=@"";
        }
        id  SalesQuality=[proDic objectForKey:@"SalesQuality"];
        if (SalesQuality==[NSNull null]||SalesQuality==nil) {
            SalesQuality=@"";
        }
        id  productQuantity=[proDic objectForKey:@"productQuantity"];
        if (productQuantity==[NSNull null]||productQuantity==nil) {
            productQuantity=@"";
        }
        id  showClicks=[proDic objectForKey:@"showClicks"];
        if (showClicks==[NSNull null]||showClicks==nil) {
            showClicks=@"";
        }




        //    if (indexPath.section==0) {
        //        if (indexPath.row==1) {
        //
        //            cell.userInteractionEnabled =NO;
        //        }
        //    }


        if (indexPath.section==0) {
            if (indexPath.row==0) {

                _productName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 0, _width*0.65, 40)];
                _productName_L.textAlignment=NSTextAlignmentLeft;
                if (productSubName==nil||[NSString stringWithFormat:@"%@",productSubName].length==0) {
                    _productName_L.text=[NSString stringWithFormat:@"(包邮)%@",productName];
                }else
                {
                    _productName_L.text=[NSString stringWithFormat:@"(包邮)%@(%@)",productName,productSubName];
                    _productName_L.numberOfLines=2;
                }

                _productName_L.font=[UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_productName_L];




                _price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 40, _width*0.35, 20)];
                _price_L.textAlignment=NSTextAlignmentLeft;
                _price_L.textColor=[UIColor grayColor];

                _price_L.text=[NSString stringWithFormat:@"￥%.2f",[price doubleValue]];
                _price_L.font=[UIFont systemFontOfSize:13];
                [cell.contentView addSubview:_price_L];


                _ratePrice_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 40, _width*0.35, 20)];
                _ratePrice_L.textAlignment=NSTextAlignmentLeft;
                _ratePrice_L.textColor=[UIColor orangeColor];

                if ([self.isWhoPush isEqualToString:@"rush"]) {
                    _price_L.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];

                    ratePrice = rushDic[@"rushPrice"];
                    _ratePrice_L.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];

                }else{
                    _ratePrice_L.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];

                }

                _ratePrice_L.font=[UIFont systemFontOfSize:16];
                [cell.contentView addSubview:_ratePrice_L];


                NSDictionary *attrDict1 = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                             NSFontAttributeName: [UIFont systemFontOfSize:13] };

                _price_L.attributedText = [[NSAttributedString alloc] initWithString: _price_L.text attributes: attrDict1];


                UILabel *_postage = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 60, _width*0.25, 30)];
                _postage.textColor =[UIColor blackColor];
                _postage.font =[UIFont systemFontOfSize:13];
//                if ([postage integerValue]==0) {
//                    _postage.text =  [NSString stringWithFormat:@"全国包邮"];
//                }else{
                    _postage.text =  [NSString stringWithFormat:@"赠%@积分",userScore];

//                }
//                _postage.attributedText = [self changColor:_postage.text];
                [cell.contentView addSubview:_postage];



                UILabel *_SalesQuality = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, 60, _width*0.25, 30)];
                _SalesQuality.text = [NSString stringWithFormat:@"销量 %@",SalesQuality];
                _SalesQuality.textColor =[UIColor blackColor];
                _SalesQuality.font =[UIFont systemFontOfSize:13];
                _SalesQuality.attributedText = [self changColor:_SalesQuality.text];
                [cell.contentView addSubview:_SalesQuality];

                UILabel *_productQuantity = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.60, 60, _width*0.2, 30)];
                if ([self.isWhoPush isEqualToString:@"rush"]) {
                    productQuantity = rushDic[@"rushQuanlity"];
                    _productQuantity.text = [NSString stringWithFormat:@"库存 %ld",(long)[productQuantity integerValue] ];

                }else{

                    _productQuantity.text = [NSString stringWithFormat:@"库存 %@",productQuantity];

                }

                _productQuantity.textColor =[UIColor blackColor];
                _productQuantity.font =[UIFont systemFontOfSize:13];
                _productQuantity.attributedText = [self changColor:_productQuantity.text];
                [cell.contentView addSubview:_productQuantity];


                UILabel *_showClicks = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.8, 60, _width*0.2, 30)];
                _showClicks.text = [NSString stringWithFormat:@"人气 %@",showClicks];
                _showClicks.textColor =[UIColor blackColor];
                _showClicks.font =[UIFont systemFontOfSize:13];
                _showClicks.attributedText = [self changColor:_showClicks.text];
                [cell.contentView addSubview:_showClicks];


                UIButton *collectbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.75, 13, 20, 20)];
                [collectbtn setImage:[UIImage imageNamed:@"dt3"] forState:UIControlStateNormal] ;
                [cell.contentView addSubview:collectbtn];

                UILabel *lab00 = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.75-2, 33, 25, 25)];
                lab00.text = @"收藏";
                lab00.font=[UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab00];



                UIButton *sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.88, 10, 18, 23)];
                [sharebtn setImage:[UIImage imageNamed:@"dt2"] forState:UIControlStateNormal] ;
                [cell.contentView addSubview:sharebtn];
                UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.88-2, 33, 25, 25)];
                lab11.text = @"分享";
                lab11.font=[UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab11];

                for (int i =0; i <2; i ++) {
                    UIButton *butonCollect = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.7 + i*45, 0, 45, 55)];
                    butonCollect.tag=i;
                    [butonCollect addTarget:self action:@selector(collectAndShareClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview: butonCollect];
                }




            }
            if (indexPath.row==1){
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                //icon=[UIImage imageNamed:@"comment"];
                if ([[NSString stringWithFormat:@"%@",comment] intValue]==0) {
                    cell.textLabel.text=@"暂无评价";
                }else
                {
                    cell.textLabel.text=[NSString stringWithFormat:@"累计评价（%@）",comment];
                }
                cell.imageView.image=[UIImage imageNamed:@"comment"];

                cell.textLabel.font=[UIFont systemFontOfSize:15];
            }
        }
        if (indexPath.section==1) {

            //        if (indexPath.row==1) {
            //           // icon=[UIImage imageNamed:@"productDetail"];
            //            cell.imageView.image=[UIImage imageNamed:@"productDetail"];
            //            cell.textLabel.text=@"商品详情";
            //            cell.textLabel.font=[UIFont systemFontOfSize:15];
            //        }

            if (indexPath.row==0){

                for (int i =0; i <3; i ++) {
                    UIButton*jieshao=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.02+(_width*0.32)*i, 10, _width*0.32-5, 30)];
                    [jieshao  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    jieshao.titleLabel.font=[UIFont systemFontOfSize:15];
                    jieshao.layer.cornerRadius = 3;
                    jieshao.clipsToBounds =YES;
                    jieshao.selected = NO;
                    jieshao.tag = i;
                    jieshao.backgroundColor= RGB(234, 234, 234);
                    [jieshao addTarget:self action:@selector(jieshao:) forControlEvents:UIControlEventTouchUpInside];
                    [cell1.contentView addSubview:jieshao];

                    if (i ==0) {
                        [jieshao setTitle:@"产品参数" forState:UIControlStateNormal];

                        jieshao.backgroundColor=APP_ClOUR;

                        [jieshao  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                        jieshao.selected = YES;
                        oldbutton = jieshao;

                    }
                    if (i ==1) {
                        [jieshao setTitle:@"图文详情" forState:UIControlStateNormal];



                    }
                    if (i ==2) {
                        [jieshao setTitle:@"店铺推荐" forState:UIControlStateNormal];
                    }

                }


                cell1.selectionStyle = UITableViewCellSelectionStyleNone;

                    [cell1.contentView addSubview:smallTableView];
                    UIView *view = [[UIView alloc]initWithFrame:smallTableView.frame];
                    view.tag =111;
                    [cell1.contentView addSubview:view];
                    





                //                        CGSize  size=[self boundWithSize:CGSizeMake(_width*0.98, 0) WithString:self.producdesc WithFont:[UIFont systemFontOfSize:14]];
                ////
                ////
                //
                //                        UILabel*share_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.02, 45, _width*0.96, size.height+10)];
                //                        share_L.textAlignment=NSTextAlignmentLeft;
                //                        share_L.textColor=[UIColor darkGrayColor];
                //                        share_L.numberOfLines=0;
                //                        share_L.text=[NSString stringWithFormat:@"\t%@",_producdesc];
                //                        share_L.font=[UIFont systemFontOfSize:15];
                //                        [cell.contentView addSubview:share_L];


            }


            UIGraphicsEndImageContext();

        }


        //    if (indexPath.section==2) {
        //        UIImageView*imageV=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 15, 40, 40)];
        //        [imageV sd_setImageWithURL:[NSURL URLWithString:shopLogo] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
        //        }];
        //        [cell.contentView addSubview:imageV];
        //
        //
        //
        //        UILabel*shopNmae=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.07+40, 15, _width*0.4, 20)];
        //        shopNmae.textAlignment=NSTextAlignmentLeft;
        //        shopNmae.textColor=[UIColor darkGrayColor];
        //        shopNmae.text=[NSString stringWithFormat:@"%@",shopName];
        //        shopNmae.font=[UIFont systemFontOfSize:11];
        //        [cell.contentView addSubview:shopNmae];
        //
        //
        //        UILabel*shopGrade=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.07+40, 15+20, _width*0.4, 20)];
        //        shopGrade.textAlignment=NSTextAlignmentLeft;
        //        shopGrade.textColor=[UIColor darkGrayColor];
        //        shopGrade.text=@"等级:";
        //
        //        UILabel*grade=[[UILabel alloc]initWithFrame:CGRectMake(28,2.5, 50, 15)];
        //        grade.textAlignment=NSTextAlignmentCenter;
        //        grade.textColor=[UIColor whiteColor];
        //        grade.backgroundColor=APP_ClOUR;
        //        grade.text=[NSString stringWithFormat:@"%@",shopde];
        //        grade.layer.cornerRadius=2;
        //        grade.clipsToBounds=YES;
        //        grade.font=[UIFont systemFontOfSize:11];
        //        [shopGrade addSubview:grade];
        //
        //        shopGrade.font=[UIFont systemFontOfSize:12];
        //        [cell.contentView addSubview:shopGrade];
        //
        //
        //        UIButton*shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //        [shareBtn setTitle:@"进入商家" forState:UIControlStateNormal];
        //
        //        shareBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        //        shareBtn.frame=CGRectMake(_width*0.6, 15,_width*0.35, 40);
        //        [shareBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //        shareBtn.tag=2;
        //        shareBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        //
        //        
        //       // [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,30, 0,0)];
        //        [shareBtn setImage:[UIImage imageNamed:@"shop"] forState:UIControlStateNormal];
        //
        //        [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(10,10,10,_width*0.35-30)];
        //        [shareBtn addTarget:self action:@selector(goshop) forControlEvents:UIControlEventTouchUpInside];
        //
        //        shareBtn.layer.cornerRadius=5;
        //        shareBtn.layer.borderColor=RGB(234, 234, 234).CGColor;
        //        shareBtn.layer.borderWidth=1;
        //
        //
        //
        //        [cell.contentView addSubview:shareBtn];
        //
        //    }
        if (indexPath.section==0) {
            if (indexPath.row==1) {
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else
            {
                return cell;
            }
        }else
        {
            return cell1;
        }
        
        }
}

-(void)jieshao:(UIButton*)button{

//    NSLog(@"++++%ld",button.tag);
    if (oldbutton !=button) {
        button.selected = YES;
        button.backgroundColor = APP_ClOUR;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        oldbutton.backgroundColor = RGB(234, 234, 234);
        [oldbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oldbutton = button;
    }
    if (button.tag ==1) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIWebView class]]) {
                view.hidden = NO;
//                [_tableView reloadData];
            }
            if ([view isKindOfClass:[UITableView class]]) {
                [view removeFromSuperview];
            }
            if (view.tag ==222) {
                [view removeFromSuperview];
            }
            if (view.tag ==111) {
                [view removeFromSuperview];
            }

        }

        double delay_s=0.2;
        dispatch_time_t poptime=dispatch_time(DISPATCH_TIME_NOW, delay_s*NSEC_PER_SEC);
        dispatch_after(poptime, dispatch_get_main_queue(), ^{
            web.frame=CGRectMake(0, 45, _width, _webHight);
            _webH = _webHight;
            NSLog(@"hh=======%f",_webH);

            [cell.contentView addSubview:web];

            [_tableView beginUpdates];
            [_tableView endUpdates];
        });




    }

    if (button.tag ==0) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIWebView class]]) {
                view.hidden = YES;
            }
            if ([view isKindOfClass:[UITableView class]]) {
                [view removeFromSuperview];
            }
            if (view.tag ==222) {
                [view removeFromSuperview];
            }
            if (view.tag ==111) {
                [view removeFromSuperview];
            }


        }


        _webH =0.0;

        for (int i =0; i <_propertyArray.count; i++) {
            NSDictionary *dic = _propertyArray[i];
            CGFloat hh= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"valueName"] WithFont:[UIFont systemFontOfSize:13]].height;
            CGFloat danhangHH= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"propertyName"] WithFont:[UIFont systemFontOfSize:13]].height;
            _webH +=MAX(44, (44-danhangHH+hh));
        }

        [_tableView beginUpdates];
        [_tableView endUpdates];
        smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, _width,_webH) style:UITableViewStyleGrouped];
        smallTableView.tag =333;
        smallTableView.delegate=self;
        smallTableView.dataSource=self;
        smallTableView.bounces=NO;
        smallTableView.separatorColor = RGB(234, 234, 234);

        [cell.contentView addSubview:smallTableView];
        UIView *view = [[UIView alloc]initWithFrame:smallTableView.frame];
        view.tag =111;
        [cell.contentView addSubview:view];

    }



    if (button.tag ==2) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIWebView class]]) {
                view.hidden = YES;
            }
            if ([view isKindOfClass:[UITableView class]]) {
                [view removeFromSuperview];
            }
            if (view.tag ==222) {
                [view removeFromSuperview];
            }
            if (view.tag ==111) {
                [view removeFromSuperview];
            }

        }

        if (_dataArray.count!=0) {
            [_dataArray removeAllObjects];
        }


    NSString *url = [NSString stringWithFormat:@"%@/product/search.action?ranking=1",BASE_URLL];
    [requestData getData:url complete:^(NSDictionary *dic) {
        NSArray *array  =[dic objectForKey:@"data"];
        NSInteger sum;
        if (array.count>3) {
            sum=3;
        }else if(array.count>0&&array.count<3){
            sum=1;
        }else{
            sum=0;
        }
        for (int i = 0; i <sum; i ++) {
            [_dataArray addObject:array[i]];
        }

        //        NSLog(@"+++++++++%lu",(unsigned long)_dataArray.count);
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, _width, _width/4+100)];
        backView.tag =222;
        [cell.contentView addSubview:backView];

        for (NSInteger i =0; i <_dataArray.count; i ++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i,0, (_width-40)/3-2, _width/4-2)];


            UIView*kuang=[[UIView alloc]init];
            kuang.bounds = CGRectMake(0, 0, (_width-40)/3+1, _width/4+1);
            kuang.center = img.center;

            kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
            kuang.layer.borderWidth=1;
            [backView addSubview:kuang];

            NSDictionary *dic = _dataArray[i];
            [img sd_setImageWithURL:[NSURL URLWithString:dic[@"productImage"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!image) {
                    image = [UIImage imageNamed:@"fang"];
                }else{
                    float  W=(_width/4-2)*image.size.width/image.size.height;
                    img.center = kuang.center;
                    img.bounds = CGRectMake(0, 0, W, _width/4-2);
                }


            }];
            [backView addSubview:img];

            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i, _width/4, (_width-40)/3, 50)];

            titleLab.text = dic[@"productName"];
            titleLab.numberOfLines=2;
            titleLab.textColor =[UIColor darkGrayColor];
            titleLab.font=[UIFont systemFontOfSize:15];
            [backView addSubview:titleLab];

            UILabel *priceLab =[[UILabel alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i, 45+_width/4, (_width-40)/3, 30)];
            priceLab.textColor =[UIColor orangeColor];
            priceLab.numberOfLines=1;
            priceLab.font=[UIFont systemFontOfSize:15];
            priceLab.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"ratePrice"] doubleValue]];
            [backView addSubview:priceLab];

            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(_width/3*i,45, _width/3, _width/4+80)];
            button.tag = [dic[@"productId"] intValue];
            [button addTarget:self action:@selector(youlike:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];
            
        }
    }];

        _webH =_width/4+100;
        [_tableView beginUpdates];
        [_tableView endUpdates];

 }
}

-(void)youlike:(UIButton*)sender{
//    PUSH(productVC)
    self.productId = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([self.isWhoPush isEqualToString:@"rush"]) {
self.isWhoPush = @"";
    }
    [self getData];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

//    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];

    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGFloat documentWidht = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];

    documentHeight = documentHeight/documentWidht*_width;
    _webHight=(float)documentHeight+20;

//    double delay_s=0.2;
//    dispatch_time_t poptime=dispatch_time(DISPATCH_TIME_NOW, delay_s*NSEC_PER_SEC);
//    dispatch_after(poptime, dispatch_get_main_queue(), ^{
//        webView.frame=CGRectMake(0, 45, _width, _webH);
//        NSLog(@"hh=======%f",_webH);
//
//        [_tableView beginUpdates];
//        [_tableView endUpdates];
//    });


}
-(void)shopCarClick
{

    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{

        }];
    }else
    {
        PUSH(shopCarVC);
        vc.whoPush=@"xiangqing";
    }


}
-(void)addshopBtnClick
{
    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{

        }];
    }else
    {

    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0,_height, _width, _height)];
    UIView*upview=[[UIView alloc]init];
    if (self.isSKU) {
        upview.frame=CGRectMake(0, 0, _width, _height-180);
    }else
    {
        upview.frame=CGRectMake(0, 0, _width, _height-140);
    }
     upview.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.8];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelBtnClick)];
    [upview addGestureRecognizer:tap];
    [_bgView addSubview:upview];

    [self.view addSubview:_bgView];


    UIView*smallView=[[UIView alloc]init];
    if (self.isSKU) {
        smallView.frame=CGRectMake(0, _height-140-40, _width, 180);
    }else
    {
        smallView.frame=CGRectMake(0, _height-140, _width, 140);
    }
    smallView.backgroundColor=[UIColor whiteColor];
    [_bgView addSubview:smallView];


    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 36, 36)];
    NSString*imagePath=[[_dataDic objectForKey:@"product"] objectForKey:@"imagePath"];
    NSString*productName=[[_dataDic objectForKey:@"product"] objectForKey:@"productName"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"news"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {

            image = [UIImage imageNamed: @"fang"];
        }else{
            
        float  W=(36)*image.size.width/image.size.height;
        imageView.frame = CGRectMake(20, 7, W, 36);
        }
    }];
    [smallView addSubview:imageView];

    UILabel*shopName=[[UILabel alloc]initWithFrame:CGRectMake(50,0, _width*0.7, 50)];
    shopName.textAlignment=NSTextAlignmentLeft;
    shopName.textColor=[UIColor  darkGrayColor];
    shopName.text=productName;
    shopName.font=[UIFont systemFontOfSize:14];
    [smallView addSubview:shopName];

    UIButton*cancelbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelbutton.frame=CGRectMake(_width*0.8, 0, _width*0.2,50);
    //cancelbutton.backgroundColor=[UIColor redColor];
    [cancelbutton addTarget:self action:@selector(CancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutton setTitle:@"X" forState:UIControlStateNormal];
    [cancelbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [smallView addSubview:cancelbutton];


    UILabel*numbel_L=[[UILabel alloc]initWithFrame:CGRectMake(10,50, _width*0.7, 50)];
    numbel_L.textAlignment=NSTextAlignmentLeft;
    numbel_L.textColor=[UIColor darkGrayColor];
    numbel_L.text=@"购买数量";
    numbel_L.font=[UIFont systemFontOfSize:14];
    [smallView addSubview:numbel_L];






    UIView*plusAndMinView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.65, 60, _width*0.3, 30)];
    plusAndMinView.layer.cornerRadius=5;
    plusAndMinView.layer.borderColor=[UIColor redColor].CGColor;
    plusAndMinView.layer.borderWidth=1;
    [smallView addSubview:plusAndMinView];
    for (int i=0; i<2; i++) {
        UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.1*(i+1), 0, 1, 30)];
        shuxian.backgroundColor=[UIColor redColor];
        [plusAndMinView addSubview:shuxian];
    }
    for (int i=0; i<3; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.1*i,0 , _width*0.1, 30);
        button.tag=i;
        [button addTarget:self action:@selector(PlusAndMinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
             [button setTitle:@"-" forState:UIControlStateNormal];
        }
        if (i==1) {
            [button setTitle:@"1" forState:UIControlStateNormal];
        }
        if (i==2) {
            [button setTitle:@"+" forState:UIControlStateNormal];
        }
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [plusAndMinView addSubview:button];
    }

    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, _height-40, _width, 40);
    button.backgroundColor=APP_ClOUR;
    [button addTarget:self action:@selector(OkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bgView addSubview:button];




    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame=CGRectMake(0, 0, _width, _height);
    }];


    }

}
-(void)PlusAndMinBtnClick:(UIButton*)button
{
    if (button.tag==1) {

    }else
    {

        UIView*view=[button superview];
        UIButton*numBtn=(UIButton*)[view viewWithTag:1];
        NSString*minS=[NSString stringWithFormat:@"%d",[numBtn.titleLabel.text intValue]-1];
        NSString*plustr=[NSString stringWithFormat:@"%d",[numBtn.titleLabel.text intValue]+1];
        if (button.tag==0) {
            if ([numBtn.titleLabel.text intValue]==1) {
                return;
            }
            [numBtn setTitle:minS forState:UIControlStateNormal];
        }else
        {
//            int qulity=[[[_dataDic objectForKey:@"product"] objectForKey:@"productQuantity"] intValue];
//            if ([plustr intValue]>qulity) {
//                ALERT(@"库存不足")
//                return;
//            }
            [numBtn setTitle:plustr forState:UIControlStateNormal];

        }
        _count=numBtn.titleLabel.text;
    }
}
-(void)CancelBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame=CGRectMake(0, _height, _width, _height);
    }];
}
-(void)OkBtnClick
{
    NSString*shopid=[[_dataDic objectForKey:@"product"] objectForKey:@"shopId"];
    [requestData getData:ADD_SHOP_CAR_URL(USERID, self.productId, shopid, _count) complete:^(NSDictionary *dic) {
        NSLog(@"----%@",ADD_SHOP_CAR_URL(USERID, self.productId, shopid, _count));
        if ([[dic objectForKey:@"flag"] intValue]==1) {
            //ALERT([dic objectForKey:@"info"])
            _redNumber.hidden=NO;
//            static int i=0;
//            i++;
//            if (i==1) {
//                 _redNumber.text=[NSString stringWithFormat:@"%d",[_redNumber.text intValue]+1];
//            }
            [self getData];

            [self CancelBtnClick];
        }

    }];


}
-(void)goBuyNowBtnClick
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

        if ([self.isWhoPush isEqualToString:@"rush"]) {
            ratePrice = [_dataDic[@"rush"] objectForKey:@"rushPrice"];

        }
        NSString*shopName=[dic objectForKey:@"shopName"];

        NSMutableDictionary*mudic=[[NSMutableDictionary alloc]init];

        NSMutableArray*goodArry=[[NSMutableArray alloc]init];
        NSMutableDictionary*productDic=[[NSMutableDictionary alloc]init];

        [mudic setObject:shopId forKey:@"shopId"];
        [mudic setObject:shopLogo forKey:@"shopLogo"];
        [mudic setObject:shopName forKey:@"shopName"];



        [productDic setObject:productId forKey:@"productId"];
        [productDic setObject:imagePath forKey:@"imagePath"];
        [productDic setObject:productName forKey:@"productName"];
        [productDic setObject:ratePrice forKey:@"ratePrice"];
        [productDic setObject:productQuantity forKey:@"productQuantity"];

        [productDic setObject:@"1" forKey:@"count"];
        
        [goodArry addObject:productDic];
        
        NSDictionary*postDic=@{@"shop":mudic,@"good":goodArry};
        
        PUSH(sureOrderVC)
        vc.InfoArray=postDic;

    }
}
-(void)goshop
{
    PUSH(hospitalVC)
    vc.shopId=self.shopId;

}
-(void)jiaohuxing:(UIButton*)button{
    button.userInteractionEnabled=YES;

}

-(void)collectAndShareClick:(UIButton*)button
{


        if (button.tag==0) {
            if (USERID==nil) {
                ALLOC(logInVC)
                [self presentViewController:vc animated:NO completion:^{

                }];
                
            }else{

            button.userInteractionEnabled=NO;
            [self performSelector:@selector(jiaohuxing:) withObject:button afterDelay:2];
            [requestData getData:ADD_COLLECTION_URL(USERID, self.productId, @"0") complete:^(NSDictionary *dic) {

                _missing_label=[[UILabel alloc]initWithFrame:CGRectMake(_width/4, _height/1.5, _width/2, 50)];
                _missing_label.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                _missing_label.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.6 ];
                _missing_label.font=[UIFont systemFontOfSize:15];
                _missing_label.textAlignment=NSTextAlignmentCenter;
                _missing_label.layer.cornerRadius=10;
                _missing_label.clipsToBounds=YES;
                _missing_label.textColor=[UIColor darkGrayColor];
                [[UIApplication sharedApplication].keyWindow addSubview:_missing_label];
                [self performSelector:@selector(missing_l) withObject:nil afterDelay:1];

            }];
            }
        }
        if (button.tag==1) {



            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMAPPKEY
                                              shareText:_productName_L.text
                                             shareImage:self.imagepath
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToSina,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToTencent, nil] delegate:self];

            [UMSocialData defaultData].extConfig.sinaData.shareText=[NSString stringWithFormat:@"%@%@",_productName_L.text,[NSString stringWithFormat:@"http://waptx.yunshangweiqi.com/products_detail.html?productId=%@",self.productId]];

            [UMSocialData defaultData].extConfig.wechatSessionData.title = _productName_L.text;;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://waptx.yunshangweiqi.com/products_detail.html?productId=%@",self.productId];
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = _productName_L.text;;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://waptx.yunshangweiqi.com/products_detail.html?productId=%@",self.productId];


             [UMSocialData defaultData].extConfig.qzoneData.title = _productName_L.text;
             [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://waptx.yunshangweiqi.com/products_detail.html?productId=%@",self.productId];
        }







}
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"成功分享到 %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

-(void)missing_l
{
    [UIView animateWithDuration:1 animations:^{
        _missing_label.alpha=0;
    } completion:^(BOOL finished) {
        [_missing_label removeFromSuperview];
    }];
}
-(void)timeAction
{
    if (_productImageA.count==0) {
        return;
    }

    number++;
    if (number==_productImageA.count) {
        number=0;
    }
    _pc.currentPage=number;
   // NSLog(@"%d",number);
    [UIView animateWithDuration:0.5 animations:^{
        _smallScrollV.contentOffset=CGPointMake(_width*number, 0);
    }];

    
}

-(void)backClick
{
 POP
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
    [UIView animateWithDuration:0.01 animations:^{
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
            UIImageView*iv=[[UIImageView alloc]init];

            NSString*imUrl=[[_productImageA objectAtIndex:i] objectForKey:@"imagePath"];


            [iv sd_setImageWithURL:[NSURL URLWithString:imUrl] placeholderImage:[UIImage imageNamed:@"morentu.jpg"]];

            UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imUrl]]];
//            NSLog(@"%f----%f",image.size.width,image.size.height);
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


        //UIWindow *win=[UIApplication sharedApplication].keyWindow;

        UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 64)];
        topView.backgroundColor=APP_ClOUR;
        [BGView addSubview:topView];

        UILabel*storySign=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, _width, 44)];
        storySign.text=[NSString stringWithFormat:@"图片"];
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"fchwoie===%f",_tableView.contentOffset.y);
    if (_tableView.contentOffset.y<=0) {

        _webH =0.0;

        for (int i =0; i <_propertyArray.count; i++) {
            NSDictionary *dic = _propertyArray[i];
            CGFloat hh= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"valueName"] WithFont:[UIFont systemFontOfSize:13]].height;
            CGFloat danhangHH= [self boundWithSize:CGSizeMake(_width*0.55, MAXFLOAT) WithString:dic[@"propertyName"] WithFont:[UIFont systemFontOfSize:13]].height;
            _webH +=MAX(44, (44-danhangHH+hh));
        }

        [_tableView beginUpdates];
        [_tableView endUpdates];

    }

    int currentPage=_imageScrollView.contentOffset.x/_width+1;
    _page_L.text=[NSString stringWithFormat:@"%d/%d",currentPage,_page_number];

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

-(void)rightUpBtnClick{
    PUSH(QuestionVC)
    vc.productId = self.productId;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    number=0;
    if ([self.isWhoPush isEqualToString:@"rush"]) {
        markId=YES;
    }else{
        markId=NO;
    }
    [self getData];
//    NSString *titlestring = [[_dataDic objectForKey:@"product"] objectForKey:@"productName"];
    NSLog(@"-----9999999");

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    number=0;
    [_timer invalidate];
    _timer=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableAttributedString*)changColor:(NSString*)string{

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    //设置：在0-2个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 2)];
    return str;
}
-(NSString *)getTheNoNullStr:(id)str andRepalceStr:(NSString*)replace{
    NSString *string=nil;
    if (![str isKindOfClass:[NSNull class]]) {
        string =  [NSString stringWithFormat:@"%@",str];

        if (string.length ==0||(NSNull*)string == [NSNull null]||[string isEqualToString:@"(null)"]) {
            string =replace;
        }
    }else{
        string =replace;
    }
    return string;
}

//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}
@end
