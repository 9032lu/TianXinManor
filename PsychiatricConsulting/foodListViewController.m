//
//  foodListViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "foodListViewController.h"
#import "myButton.h"
#import "productVC.h"
#import "danli.h"
#import "cityViewController.h"
@interface foodListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView             *_tableView;
    UIView                  *_moveView;
    myButton                *_lastBtn;

    UIScrollView            *_downwardView;
    NSMutableArray          *_dataArray;

    NSString                *_current_kw;
    NSString                *_current_districtId;
    NSString                *_current_className;
    NSString                *_current_order;//当前默认排序


    NSArray                 *_district_array;
    NSArray                 *_className_array;
    NSArray                 *_order_array;

    UISearchBar             *_searchBar;
    UIButton                *_sousuoBtn;
    SDRefreshHeaderView     *_refesh;
    SDRefreshFooterView     *_refeshDown;
    NSString                *_currentId;
    int                     _count;

//    NSArray  *myarray;

}

@end

@implementation foodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    SCREEN
    TOP_VIEW(@"商品列表")

//    NSLog(@"........%@",self.categoryId);
    _dataArray=[[NSMutableArray alloc]init];
    _count=0;

    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(_width*0.15, 20, _width*0.85, 44)];
    _searchBar.barTintColor=APP_ClOUR;
    _searchBar.delegate=self;
    _searchBar.showsCancelButton=YES;
    _searchBar.barStyle=UIBarStyleDefault;
    _searchBar.placeholder=@"请输入商品名称";
    _searchBar.keyboardType=UIKeyboardTypeDefault;
    _searchBar.backgroundImage=nil;
    _searchBar.layer.borderWidth=1;
    //[_searchBar becomeFirstResponder];
    _searchBar.layer.borderColor=[UIColor clearColor].CGColor;
    [topView addSubview:_searchBar];
    //去边框
    for (id img in [_searchBar.subviews[0] subviews])
    {
        if ([img isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [img removeFromSuperview];
        }
    }

    //改汉字
    for (id view in [_searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"搜索"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
        }
    }

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, _width, _height-64-50) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];

    if (SELECT_CITY==nil) {
        [[NSUserDefaults standardUserDefaults]setObject:@"重庆市" forKey:@"selectCity"];
    }
    NSString *str= [NSString stringWithFormat:@"%@ v",SELECT_CITY];
    NSString *str1= [NSString stringWithFormat:@"%@ v",self.name];

    if ([str1 isEqualToString:@"(null) v"]) {
        str1 =@"全部餐饮 v";
    }
//    NSLog(@"000000%@",str1);
    NSArray*nameA=@[str,str1,@"默认排序 v",];
    for (int i=0; i<3; i++) {
        myButton*button=[myButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width/3*i, 64, _width/3, 50);
        [button setTitle:[nameA objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_ClOUR forState:UIControlStateSelected];

        button.tag=i;
        if (i==0) {
            button.selected=YES;
            _lastBtn=button;
        }
        button.isClicked=NO;
        [button addTarget:self action:@selector(ThreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.view addSubview:button];
    }
//    [self ThreeBtnClick:self.button];
    _moveView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+48, _width/3, 2)];
    _moveView.backgroundColor=APP_ClOUR;
    [self.view addSubview:_moveView];

    _downwardView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+50, _width, 1)];
    _downwardView.scrollEnabled=YES;
    _downwardView.backgroundColor=RGB(247, 247, 247);
    _downwardView.bounces=NO;

    _refesh=[SDRefreshHeaderView refreshView];
    __block foodListViewController*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData:@"shuaxin"];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData:@"more"];
        
        
    };

}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _current_kw=searchText;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    [self getData:@""];

}
-(void)getData:(NSString*)more
{



    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];



//    NSString*str=[NSString stringWithFormat:@"%@/product/search.action?size=12&districtName=%@" ,BASE_URL,SELECT_CITY];
    NSString*str=[NSString stringWithFormat:@"%@/product/search.action?size=12" ,BASE_URL];
    if ([SELECT_CITY isEqualToString:@"重庆市"]) {
        _current_districtId = nil;
    }


//   NSString *st = districtId;
//    _current_districtId=districtId;


//    if ([SELECT_CITY isEqualToString:@"重庆市"]) {
//        str =[NSString stringWithFormat:@"%@/product/search.action?size=12&districtName=%@" ,BASE_URL,SELECT_CITY];
    
//    }
//    NSLog(@"首页_districtname====%@",SELECT_CITY);


        if ([self .whoPush isEqualToString:@"ishot"]) {
            str=[NSString stringWithFormat:@"%@&type=0",str];
        }

        if (_current_districtId!=nil) {
            str=[NSString stringWithFormat:@"%@&districtId=%d",str,[_current_districtId intValue]];
        }
        if (_current_className!=nil) {
            str=[NSString stringWithFormat:@"%@&categoryId=%d",str,[_current_className intValue]];
        }
        if (_current_order!=nil) {
            str=[NSString stringWithFormat:@"%@&ranking=%d",str,[_current_order intValue]];
        }
        if (_current_kw!=nil||_current_kw.length!=0) {
            str=[NSString stringWithFormat:@"%@&kw=%@",str,_current_kw];
        }


    LOADVIEW
    if ([more isEqualToString:@"more"]) {
        str=[NSString stringWithFormat:@"%@&id=%@&tag=2",str,_currentId];
    }
//    if ([CURRENT_CITY isEqualToString:SELECT_CITY]) {
//        danli*myapp=[danli shareClient];
////        str=[NSString stringWithFormat:@"%@&lat=%@&lng=%@",str,myapp.lat,myapp.log];
//
//    }
//    NSLog(@"--------2---%@",str);

    [requestData getData:str complete:^(NSDictionary *dic) {
        NSLog(@"=======%@",str);
        LOADREMOVE
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        NSArray*baseA=[dic objectForKey:@"data"];

//
        if ([more isEqualToString:@"more"]) {
            for (int i=0; i<baseA.count; i++) {
                [_dataArray addObject:[baseA objectAtIndex:i]];
            }
        }else
        {
           _dataArray=[NSMutableArray arrayWithArray:baseA];
//
        }



        _currentId=[[_dataArray lastObject] objectForKey:@"productId"];

        [_tableView reloadData];

        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有找到符合条件的结果！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];
}
-(void)ThreeBtnClick:(myButton*)button
{
    [_searchBar resignFirstResponder];
    for (UIView*view in _downwardView.subviews) {
        [view removeFromSuperview];
    }
    _downwardView.frame=CGRectMake(0, 64+50, _width, 1);

    if (button.isClicked) {
        button.isClicked=NO;
        return;
    }else
    {
        button.isClicked=YES;
    }


    _lastBtn.selected=NO;
    if (button==_lastBtn) {

    }else
    {
        _lastBtn.isClicked=NO;

    }

    button.selected=YES;
    _lastBtn=button;


    [UIView animateWithDuration:0.4 animations:^{
        _moveView.frame=CGRectMake(_width/3*(float)button.tag, 64+48, _width/3, 2);
    } completion:^(BOOL finished) {

    }];


    if (button.tag==0) {
        LOADVIEW
//        NSLog(@"\\\\\\\\\%@",GET_DISTRUCT(SELECT_CITY));
        NSString *city = @"重庆市";

        [requestData getData:GET_DISTRUCT(city) complete:^(NSDictionary *dic) {
            LOADREMOVE
//            NSLog(@"%@",dic);
            _district_array=[dic objectForKey:@"data"];
            [self downwaListView];
            
        }];

//        NSLog(@"_district_array===%@",_district_array);

    }

    if (button.tag==1) {
        LOADVIEW

        [requestData getData:CLASS_URL complete:^(NSDictionary *dic) {
//             NSLog(@"sssssssssss%@",dic);
            LOADREMOVE
            _className_array=[dic objectForKey:@"data"];
            [self downwaListView];

        }];



    }

    if (button.tag==2) {

        if ([CURRENT_CITY isEqualToString:SELECT_CITY]) {
             _order_array=@[@"按价格从高到低排序",@"按价格从低到高排序",@"按销量排序",@"按人气排序",@"按上架时间排序",@"按离我最近排序"];
        }else
        {
             _order_array=@[@"按价格从高到低排序",@"按价格从低到高排序",@"按销量排序",@"按人气排序",@"按上架时间排序"];
        }

        [self downwaListView];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    [self getData:@""];
}
#pragma mark下拉框
-(void)downwaListView
{

    NSMutableArray*array=[[NSMutableArray alloc]init];
    if (_lastBtn.tag==0) {
        for (int i=0; i<_district_array.count; i++) {
            NSDictionary*dic=[_district_array objectAtIndex:i];
            NSString*districtName=[dic objectForKey:@"districtName"];
            [array addObject:districtName];
        }
    }
    if (_lastBtn.tag==1) {
        for (int i=0; i<_className_array.count; i++) {
            NSDictionary*dic=[_className_array objectAtIndex:i];
            NSString*categoryName=[dic objectForKey:@"categoryName"];
            [array addObject:categoryName];
        }
    }
    if (_lastBtn.tag==2) {
        for (int i=0; i<_order_array.count; i++) {
            NSString*districtName=[_order_array objectAtIndex:i];
            [array addObject:districtName];
        }
    }

    [UIView animateWithDuration:0.3 animations:^{

//        if (array.count*40>_height-114) {
//             _downwardView.frame=CGRectMake(0, 64+50, _width,_height-114);
//            _downwardView.contentSize=CGSizeMake(_width, array.count*40);
//        }else
//        {
            _downwardView.frame=CGRectMake(0, 64+50, _width,_height-64-50);
//        }

    } completion:^(BOOL finished) {

    }];

    UIButton*all_BTn=[UIButton buttonWithType:UIButtonTypeCustom];
    all_BTn.frame=CGRectMake(0, 0, _width, 50);
    [all_BTn  setTitle:@"\t全部" forState:UIControlStateNormal];
    [all_BTn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [all_BTn addTarget:self action:@selector(all_BtnClick) forControlEvents:UIControlEventTouchUpInside];
    all_BTn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_downwardView addSubview:all_BTn];

    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 49, _width, 1)];
    line.backgroundColor=RGB(210, 210, 210);
    [all_BTn addSubview:line];

    for (int i=0; i<array.count; i++) {
        int  X=i%3;
        int  Y=i/3;
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        if (_lastBtn.tag==0) {
            button.frame=CGRectMake(_width/3*X, 50+45*Y, _width/3, 45);

        }else
        {
            button.frame=CGRectMake(0, 50+45*i, _width, 45);
            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 44, _width, 1)];
            line.backgroundColor=RGB(230, 230, 230);
            [button addSubview:line];
        }

        [button  setTitle:[NSString stringWithFormat:@"\t%@",[array objectAtIndex:i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_ClOUR forState:UIControlStateSelected];
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        //button.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.6];
//        button.backgroundColor=RGB(244, 244, 244);

        [_downwardView addSubview:button];
        button.tag=i;
        button.titleLabel.font=[UIFont systemFontOfSize:15];

        [button addTarget:self action:@selector(xialaBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }

    [[UIApplication sharedApplication].keyWindow addSubview:_downwardView];



}
-(void)all_BtnClick
{
    [UIView animateWithDuration:0.2 animations:^{
        _downwardView.frame=CGRectMake(0, 64+50, _width, 1);
    }];
    if (_lastBtn.tag==0) {
        _current_districtId=nil;
        [[NSUserDefaults standardUserDefaults]setObject:@"重庆市" forKey:@"selectCity"];

        NSString *mcity = [NSString stringWithFormat:@"%@ v",SELECT_CITY];

        [_lastBtn setTitle:mcity forState:UIControlStateNormal];
    }
    if (_lastBtn.tag==1) {
        _current_className=nil;
         [_lastBtn setTitle:@"全部餐饮 v" forState:UIControlStateNormal];
    }
    if (_lastBtn.tag==2) {
        _current_order=nil;
         [_lastBtn setTitle:@"默认排序 v" forState:UIControlStateNormal];
    }


    [self getData:@""];
}
-(void)xialaBtnClick:(UIButton*)button
{
    for (UIView*Btn in [button superview].subviews) {
        if ([Btn isKindOfClass:[UIButton class]]) {
            UIButton*allBtn=(UIButton*)Btn;
            allBtn.selected=NO;
        }
    }
    button.selected=YES;

    _lastBtn.isClicked=NO;

    [_searchBar resignFirstResponder];
    for (UIView*view in _downwardView.subviews) {
        [view removeFromSuperview];
    }
    [UIView animateWithDuration:0.2 animations:^{
        _downwardView.frame=CGRectMake(0, 64+50, _width, 1);
    }];

    if (_lastBtn.tag==0) {

        _current_districtId=[[_district_array objectAtIndex:button.tag] objectForKey:@"districtId"];

        NSString *str =[[_district_array objectAtIndex:button.tag] objectForKey:@"districtId"];

        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"districtId"];
        [[NSUserDefaults standardUserDefaults]synchronize];

//        NSLog(@"===666==%@",[[_district_array objectAtIndex:button.tag] objectForKey:@"districtId"]);

        NSString*string1=[[_district_array objectAtIndex:button.tag] objectForKey:@"districtName"];


        [_lastBtn setTitle:string1 forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]setObject:string1 forKey:@"selectCity"];
        [[NSUserDefaults standardUserDefaults]synchronize];


    }
    if (_lastBtn.tag==1) {
        _current_className=[[_className_array objectAtIndex:button.tag] objectForKey:@"categoryId"];
//        NSLog(@"======%@",[[_className_array objectAtIndex:button.tag] objectForKey:@"categoryName"]);

        NSString*string1=[[_className_array objectAtIndex:button.tag] objectForKey:@"categoryName"];
//        NSLog(@"444444%@",string1);
        [_lastBtn setTitle:string1 forState:UIControlStateNormal];
    }
    if (_lastBtn.tag==2) {
        if (button.tag==0) {
            _current_order=@"3";
        }
        if (button.tag==1) {
            _current_order=@"4";
        }
        if (button.tag==2) {
            _current_order=@"1";
        }
        if (button.tag==3) {
            _current_order=@"2";
        }
        if (button.tag==4) {
            _current_order=@"5";
        }
        if (button.tag==5) {
            _current_order=@"7";
        }
       // NSLog(@"====%@",[_order_array objectAtIndex:button.tag]);

        NSString*string1=[_order_array objectAtIndex:button.tag];
        [_lastBtn setTitle:string1 forState:UIControlStateNormal];

    }

    [self getData:@""];
}
#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else
    {
        return 0.1;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _width*0.3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

//    UIImageView*rightA=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
//    rightA.image=[UIImage imageNamed:@"arrow_right"];
//    cell.accessoryView=rightA;

    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSString*ratePrice=[dic objectForKey:@"price"];
    NSString*productName=[dic objectForKey:@"productName"];
    NSString*districtName=[dic objectForKey:@"districtName"];
    NSString*shopName=[dic objectForKey:@"shopName"];
    id distance=[dic objectForKey:@"distance"];
    if (distance==[NSNull null]) {
        distance=@"";
    }
    id clicks=[dic objectForKey:@"salesQuality"];
    if (clicks==[NSNull null]) {
        clicks=@"0";
    }
    NSString*productImage=[dic objectForKey:@"productImage"];

    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.3, _width*0.25)];
    [imageview sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    imageview.layer.cornerRadius=5;
    imageview.clipsToBounds=YES;
    [cell.contentView addSubview:imageview];

    UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03-2, _width*0.025-2, _width*0.3+4, _width*0.25+4)];

    kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
    kuang.layer.borderWidth=1;
    [cell.contentView addSubview:kuang];

    UILabel*distance_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _width*0.2, _width*0.3, _width*0.05)];
    distance_L.text=[NSString stringWithFormat:@"约%@km",distance];
    distance_L.font=[UIFont systemFontOfSize:12];
    distance_L.textAlignment=NSTextAlignmentCenter;
    distance_L.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    distance_L.textColor=[UIColor whiteColor];
    [imageview addSubview:distance_L];
    if ([NSString stringWithFormat:@"%@",distance].length==0) {
        distance_L.hidden=YES;
    }

    UILabel*shop_name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.025, _width*0.65, _width*0.06)];
    shop_name.text=[NSString stringWithFormat:@"[%@]%@",districtName,shopName];
    shop_name.numberOfLines=0;
    shop_name.textAlignment=NSTextAlignmentLeft;
    shop_name.textColor=[UIColor grayColor];
    shop_name.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:shop_name];


    UILabel*product_name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.09, _width*0.65, _width*0.1)];
    product_name.text=productName;
    product_name.numberOfLines=0;
    product_name.textAlignment=NSTextAlignmentLeft;
    product_name.textColor=[UIColor blackColor];
    product_name.font=[UIFont systemFontOfSize:15];
    [cell.contentView addSubview:product_name];


    UILabel*price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.19, _width*0.3, _width*0.08)];
    price.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];
    price.numberOfLines=0;
    price.textAlignment=NSTextAlignmentLeft;
    price.textColor=APP_ClOUR;
    price.font=[UIFont systemFontOfSize:17];
    [cell.contentView addSubview:price];

    UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, _width*0.19, _width*0.2, _width*0.08)];
    name_L.text=[NSString stringWithFormat:@"销量（%@）",clicks];
    name_L.numberOfLines=0;
    name_L.textAlignment=NSTextAlignmentRight;
    name_L.textColor=[UIColor darkGrayColor];
    name_L.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:name_L];

    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, _width*0.3-1, _width, 1)];
    line.backgroundColor=RGB(234, 234, 234);
    [cell.contentView addSubview:line];
    

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSString*productId=[dic objectForKey:@"productId"];


    PUSH(productVC)
    vc.productId=productId;

}
-(void)backClick
{
    POP
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;

    if ([self.whoPush isEqualToString:@"class"] || [self.whoPush isEqualToString:@"ishot"]) {
        _current_className=self.categoryId;
        _current_districtId = districtId;
    }
    if ([self.whoPush isEqualToString:@"search"]) {
        _current_kw=self.kw;
    }
    if ([self.whoPush isEqualToString:@"fenlei"]) {
        _current_className=self.categoryId;

    }
    [self getData:@""];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_downwardView removeFromSuperview];

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
