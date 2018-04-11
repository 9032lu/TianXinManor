//
//  searchViewController.m
//  meishi
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "searchViewController.h"
#import "classViewController.h"
@interface searchViewController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar         *_searchBar;
    SCREEN_WIDTH_AND_HEIGHT

    UIButton            *_sousuoBtn;

    UITableView         *_tableView;


    NSArray             *_hotStringArray;

    NSMutableArray      *_add_search_string_array;
    NSMutableArray      *_history_string_array;


    NSString            *_keyWords;
    BOOL                _IsClicked;
    int                 _count;
    NSMutableArray *_dataArray;
}

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    _dataArray = [[NSMutableArray alloc]initWithCapacity:3];


//    _sousuoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _sousuoBtn.frame=CGRectMake(0, 0, _width, 50) ;
//    [_sousuoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    _sousuoBtn.backgroundColor=[UIColor redColor];
//    _sousuoBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//    _sousuoBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [_sousuoBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
//    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 49, _width, 1)];
//    line.backgroundColor=RGB(234, 234, 234);
//    [_sousuoBtn addSubview:line];
//    [self.view addSubview:_sousuoBtn];

    TOP_VIEW(@"");
    //    backBtn.hidden=YES;
    //    backTi.hidden=YES;
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.06, 30, 12, 20)];
    img.image = [UIImage imageNamed:@"leftArrow"];
    [topView addSubview:img];

//    backBtn.backgroundColor = [UIColor greenColor];

//
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(_width*0.15, 20, _width*0.85, 44)];
    _searchBar.barTintColor=APP_ClOUR;
    _searchBar.delegate=self;
    _searchBar.showsCancelButton=YES;
    _searchBar.barStyle=UIBarStyleDefault;
    _searchBar.placeholder=@"请输入产品名称";
    _searchBar.keyboardType=UIKeyboardTypeDefault;
    _searchBar.backgroundImage=nil;
    _searchBar.layer.borderWidth=1;
    [_searchBar becomeFirstResponder];
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
//    改汉字
    for (id view in [_searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"搜索"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
        }
    }

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64, _width, _height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor whiteColor];
      _tableView.separatorColor=[UIColor clearColor];


    [self.view addSubview:_tableView];
    [self.view bringSubviewToFront:_sousuoBtn];
    [self.view bringSubviewToFront:topView];
    //[self.view bringSubviewToFront:backBtn];


    _add_search_string_array=[[NSMutableArray alloc]init];

//    _hotStringArray = [NSArray arrayWithObjects:@"干红葡萄酒",@"干白葡萄酒",@"葡萄酒",@"气泡酒",@"红酒", nil];

    [self getData];


}
-(void)getData
{
    [requestData getData:HOT_STRING_URL complete:^(NSDictionary *dic) {
        NSString *string  =[dic objectForKey:@"info"];
        if ([string containsString:@","]) {
            _hotStringArray= [string componentsSeparatedByString:@","];

        }else if([string containsString:@"，"]){
            _hotStringArray= [string componentsSeparatedByString:@"，"];

        }
//        [_tableView reloadData];

    }];
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
        [_tableView reloadData];

    }];



}

#pragma mark 搜索框
//搜索按钮
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

//    NSLog(@"dcfvgbhjk");
    _keyWords=searchBar.text;
    if (_IsClicked) {

    }else
    {
        [self searchAndPush];

    }


}
//键盘的回车键
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"///////////////////////");
    _keyWords=searchBar.text;
    [self searchAndPush];
}
-(void)searchAndPush
{
    //并发事件
#pragma mark关键字搜索，界面跳转


//        [UIView animateWithDuration:0.3 animations:^{
//            _sousuoBtn.frame=CGRectMake(0, 0, _width, 50) ;
//            NSLog(@"1111111");
//        } completion:^(BOOL finished) {
//        }];

    _count++;
    if (_count==1) {
        PUSH(classViewController)
        vc.whoPush=@"search";
        vc.kw=_searchBar.text;
    }

#pragma mark搜索历史处理


    NSArray* historyStringArray=(NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:@"historyStringArray"];

       if (historyStringArray==nil) {

       }else
       {
         _add_search_string_array=[NSMutableArray arrayWithArray:historyStringArray];

       }


        if (_add_search_string_array.count==0) {
            if (_keyWords.length!=0) {
                [_add_search_string_array addObject:_keyWords];

            }
        }
    ////NSLog(@"hhh1%@",_add_search_string_array);


    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self contains[cd] %@",_keyWords];
    NSArray*nullA=[_add_search_string_array filteredArrayUsingPredicate:pred];
    if (nullA==nil||nullA.count==0) {

        if (_keyWords.length!=0) {
            [_add_search_string_array addObject:_keyWords];

        }
    }


         NSMutableArray*nine_array=[[NSMutableArray alloc]init];

        if (_add_search_string_array.count<9) {
            nine_array=_add_search_string_array;

        }else{

            for (int i=0; i<9; i++) {
                [nine_array addObject:[_add_search_string_array lastObject]];
                [_add_search_string_array removeLastObject];
            }


        }

        [[NSUserDefaults standardUserDefaults] setObject:nine_array forKey:@"historyStringArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];


      ////NSLog(@"hhh2%@",_add_search_string_array);
//    });





}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    NSString*string=[NSString stringWithFormat:@"\t搜索产品'%@'",searchText];
//    [_sousuoBtn setTitle:string forState:UIControlStateNormal];
//
//    [UIView animateWithDuration:0.3 animations:^{
//        _sousuoBtn.frame=CGRectMake(0, 64, _width, 50) ;
//    } completion:^(BOOL finished) {
//    }];
//    NSLog(@"确认");
//}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"hehehhe");
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //searchBar.showsCancelButton=YES;
    for (id view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"搜索"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"cancel");

    _keyWords=searchBar.text;
    [self searchAndPush];
    [_searchBar resignFirstResponder];

//    [self searchClick];
    //    POP


}

//-(void)searchClick
//{
//
//    NSLog(@"333333");
////    [_searchBar endEditing:YES];
////
////    [UIView animateWithDuration:0.3 animations:^{
////        _sousuoBtn.frame=CGRectMake(0, 0, _width, 50) ;
////    } completion:^(BOOL finished) {
////    }];
//
//}

-(void)backClick
{
    POP
}
#pragma mark选择框 搜索历史(tableView)

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row==0) {
            return 50;

        }else if(indexPath.row==1)
        {

//            return 150;
            if (_hotStringArray.count%3 ==0) {
                return _hotStringArray.count/3*50;
            }else
            {
                return (_hotStringArray.count/3+1)*50;
            }


        }
        else if (indexPath.row==2 ) {
            return 50;
        }
        else if(indexPath.row ==3)
        {
//            NSLog(@"_history_string_array==%lu",(unsigned long)_history_string_array.count/3);


            if (_history_string_array.count%3 !=0) {
                return (_history_string_array.count/3+1)*50;

            }else  {
                return _history_string_array.count/3*50;

            }

        }else if (indexPath.row==4){
            return  55;
        }

        else{


                   return _width/4+80;

        }


}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;


    cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    if (indexPath.row==0) {
        cell.textLabel.text=@"热门搜索";
            }

    if (indexPath.row==1) {
        UIView *separatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        separatorLine.backgroundColor=RGB(234, 234, 234);
        [cell.contentView addSubview:separatorLine];

        for (int i=0; i<_hotStringArray.count; i++) {
            int X=i%4;
            int Y=i/4;
            UIButton*label_hot=[UIButton buttonWithType:UIButtonTypeCustom];
            label_hot.frame=CGRectMake(_width/3*X, 50*Y, _width/3, 50);
            [label_hot setTitle:[_hotStringArray objectAtIndex:i] forState:UIControlStateNormal];
            label_hot.titleLabel.textAlignment=NSTextAlignmentCenter;
            [label_hot setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [label_hot addTarget:self action:@selector(hotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            label_hot.tag=i;
            label_hot.titleLabel.font=[UIFont systemFontOfSize:15];

            UIButton *backbtn = [[UIButton alloc]init];
            backbtn.center = label_hot.center;
            backbtn.bounds =CGRectMake(0, 0,_width/4 , 30);
            backbtn.layer.cornerRadius = 3;
            backbtn.layer.borderWidth=1;
            backbtn.layer.borderColor=RGB(234, 234, 234).CGColor;
            [cell.contentView addSubview:backbtn];
            [cell.contentView addSubview:label_hot];
        }

    }

    if (indexPath.row==2) {
        cell.textLabel.text=@"搜索历史";
        UIImageView *imag = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.72, 17, 15, 16)];
        imag.image =[UIImage imageNamed:@"rubbish1"];
        [cell.contentView addSubview:imag];

        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.75, 0, _width*0.25, 50);
        [button setTitle:@"清空记录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cleanHistoryString) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:15];

        [cell.contentView addSubview:button];

        UIView *separatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        separatorLine.backgroundColor=RGB(234, 234, 234);
        [cell.contentView addSubview:separatorLine];

    }

    if (indexPath.row==3) {
        for (int i=0; i<_history_string_array.count; i++) {
            int X=i%3;
            int Y=i/3;
            UIButton*label_hot=[UIButton buttonWithType:UIButtonTypeCustom];
            label_hot.frame=CGRectMake(_width/3*X, 50*Y, _width/3, 50);
            [label_hot setTitle:[_history_string_array objectAtIndex:i] forState:UIControlStateNormal];
            //label_hot.textAlignment=NSTextAlignmentCenter;
            [label_hot setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [label_hot addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            label_hot.tag=i;
            label_hot.titleLabel.font=[UIFont systemFontOfSize:15];

            UIButton *backbtn = [[UIButton alloc]init];
            backbtn.center = label_hot.center;
            backbtn.bounds =CGRectMake(0, 0,_width/4 , 30);
            backbtn.layer.cornerRadius = 3;
            backbtn.layer.borderWidth=1;
            backbtn.layer.borderColor=RGB(234, 234, 234).CGColor;
            [cell.contentView addSubview:backbtn];

            [cell.contentView addSubview:label_hot];

        }
    }
    if (indexPath.row==4) {
//        cell.backgroundColor =[UIColor greenColor];

        UIView *separatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 5)];
        separatorLine.backgroundColor=RGB(234, 234, 234);
        [cell.contentView addSubview:separatorLine];
        cell.textLabel.text=@"猜你喜欢";
    }
    if (indexPath.row==5) {
        for (NSInteger i =0; i <_dataArray.count; i ++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i,2, (_width-40)/3-2, _width/4-2)];


            UIView*kuang=[[UIView alloc]init];
            kuang.bounds = CGRectMake(0, 0, (_width-40)/3+1, _width/4+1);
            kuang.center = img.center;

            kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
            kuang.layer.borderWidth=1;
            [cell.contentView addSubview:kuang];

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
            [cell.contentView addSubview:img];

            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i, _width/4, (_width-40)/3, 50)];

            titleLab.text = dic[@"productName"];
            titleLab.numberOfLines=2;
            titleLab.textColor =[UIColor darkGrayColor];
            titleLab.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:titleLab];

            UILabel *priceLab =[[UILabel alloc]initWithFrame:CGRectMake(10+((_width-40)/3+10)*i, 45+_width/4, (_width-40)/3, 30)];
            priceLab.textColor =[UIColor orangeColor];
            priceLab.numberOfLines=1;
            priceLab.font=[UIFont systemFontOfSize:15];
            priceLab.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"ratePrice"] doubleValue]];
            [cell.contentView addSubview:priceLab];

            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(_width/3*i,0, _width/3, _width/4+80)];
            button.tag = [dic[@"productId"] intValue];
            [button addTarget:self action:@selector(youlike:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];

        }
    }
    return cell;
}


#pragma mark清空搜索记录
-(void)cleanHistoryString
{
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyStringArray"];
    [_history_string_array removeAllObjects];


   [_tableView reloadData];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}
#pragma mark热门和历史关键字搜索
-(void)hotBtnClick:(UIButton*)button
{
    _IsClicked=YES;
    _keyWords=[_hotStringArray objectAtIndex:button.tag];
    NSLog(@"hot===%@",_keyWords);

    PUSH(classViewController)
    vc.whoPush=@"search";
    vc.kw=_keyWords;

}
-(void)historyBtnClick:(UIButton*)button
{
    _IsClicked=YES;
    _keyWords=[_history_string_array objectAtIndex:button.tag];

    NSLog(@"*******");
    PUSH(classViewController)
    vc.whoPush=@"search";
    vc.kw=_keyWords;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_searchBar resignFirstResponder];


    _count=0;
    self.tabBarController.tabBar.hidden=YES;

    _history_string_array=[[NSMutableArray alloc]init];
    _history_string_array=[NSMutableArray arrayWithArray:(NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:@"historyStringArray"]];
    [_tableView reloadData];
}

-(void)youlike:(UIButton*)sender{
    PUSH(productVC)
    vc.productId = [NSString stringWithFormat:@"%d",sender.tag];
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
