//
//  url.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//



#define ShengMengShangmao_url_h

//#define BASE_URLL @"http://192.168.1.188:8080/TianXinManjor/interface/"
//#define BASE_URL @"http://192.168.1.188:8080/TianXinManjor/interface/"

//天心 外网
#define BASE_URL @"http://tianxin.yunshangweiqi.com:8989/TianXinManjor/interface/"
#define BASE_URLL @"http://tianxin.yunshangweiqi.com:8989/TianXinManjor/interface/"


//内网、
//#define BASE_URL @"http://192.168.1.254:8888/TianXinManjor/interface/"
//#define BASE_URLL @"http://192.168.1.254:8888/TianXinManjor/interface/"




#define USERID  [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]

#define CURRENT_CITY [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"]

#define SELECT_CITY [[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"]

#define CURRENT_LAT  [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]
#define CURRENT_LOG  [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]


#define NOTICE_DETAIL(noticeId)   [NSString stringWithFormat:@"%@/notice/get.action?noticeId=%d",BASE_URLL,[noticeId intValue]]

//用户注册

#define REGISTER_URL(userId,password,nickName,email,sex,face,birthday,identityCard,maritalStatus)  [NSString stringWithFormat:@"%@users/regUsers.action?userId=%@&password=%@&nickName=%@&email=%@&sex=%@&face=%@&birthday=%@&identityCard=%@&maritalStatus=%@",BASE_URLL,userId,password,nickName,email,sex,face,birthday,identityCard,maritalStatus]
//用户登录
#define LOGIN_URL(userId,password)  [NSString stringWithFormat:@"%@users/loginUsers.action?userId=%@&password=%@",BASE_URLL,userId,password]
//修改密码
#define ALTER_PASSWORD_URL(userId,password)  [NSString stringWithFormat:@"%@users/updateUsers.action?userId=%@&password=%@&userType=0",BASE_URLL,userId,password]

//发送短信验证码
#define REGCODE_URL(userId) [NSString stringWithFormat:@"%@/code/regCode.action?userId=%@",BASE_URLL,userId]

//#define REGCODE_URL(type) [NSString stringWithFormat:@"%@/code/regCode.action?type=%d&userId=%@",BASE_URLL,[type intValue],_phone_tf.text]
//地区列表
#define AREA_LIST_URL  [NSString stringWithFormat:@"%@area/cityList.action",BASE_URL]

#define APP_URL  [NSString stringWithFormat:@"%@/app/list.action?city=%@",BASE_URL,SELECT_CITY]

#define SHOUYE_URL  [NSString stringWithFormat:@"%@/app/recList.action?city=%@",BASE_URL,SELECT_CITY]

//查询店铺列表
#define ASK_SHOP_LIST_URL  [NSString stringWithFormat:@"%@/shop/list.action?city=%@&lng=%@&lat=%@",BASE_URL,SELECT_CITY,CURRENT_LOG,CURRENT_LAT]


//城市列表
#define GET_CITY   [NSString stringWithFormat:@"%@/area/passList.action?type=2",BASE_URL]

//广告位  0首页广告，1内页广告
#define ADV_LIST_URL(advPos)  [NSString stringWithFormat:@"%@/app/list.action?advPos=%d",BASE_URL,[advPos intValue]]

//我的预约
#define MY_YUYUE  [NSString stringWithFormat:@"%@/activity/list.action",BASE_URL]


//新闻类型列表
#define NEWSCLASS_LIST_URL  [NSString stringWithFormat:@"%@newsType/list.action",BASE_URL]
//新闻列表
#define NEWS_LIST_URL(newsTypeId)  [NSString stringWithFormat:@"%@news/list.action?&newsTypeId=%@",BASE_URL,newsTypeId ]

////新闻列表
//#define NEWS_LIST_URL  [NSString stringWithFormat:@"%@news/list.action?",BASE_URL]
//新闻详情
#define NEWS_DETAIL_URL(newsId)  [NSString stringWithFormat:@"%@news/get.action?newsId=%d",BASE_URL,[newsId intValue]]
//供需列表
#define SUPPLY_LIST_URL(supplyType)  [NSString stringWithFormat:@"%@supply/list.action?supplyType=%d",BASE_URL,[supplyType intValue]]
//供需详情
#define  SUPPLY_DETAIL_URL(supplyId)  [NSString stringWithFormat:@"%@supply/get.action?supplyId=%d",BASE_URL,[supplyId intValue]]

#define  SELECT_CITY  [[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"]

#define  CURRENT_CITY   [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"]


//社区分类
#define APP_URLL  [NSString stringWithFormat:@"%@/interactiveType/list.action",BASE_URLL]
//社区模块列表
#define TOP_APP_URL  [NSString stringWithFormat:@"%@/topics/list.action",BASE_URLL]



//首页通知
#define NOTIFICATION_URL(noticeType)  [NSString stringWithFormat:@"%@/notice/list.action?noticeType=%@",BASE_URL,noticeType]
#define NOTIFICATION_DETAIL_URL(noticeId)  [NSString stringWithFormat:@"%@/notice/get.action?noticeId=%@",BASE_URL,noticeId]
//分类
//#define CLASS_URL  [NSString stringWithFormat:@"%@/area/categoryPro.action?city=%@",BASE_URL,SELECT_CITY]
//热门搜索关键字
#define HOT_STRING_URL   [NSString stringWithFormat:@"%@/setUp/hotKeyword.action",BASE_URL]
//产品多级分类接口
#define CLASS_URL [NSString stringWithFormat:@"%@/category/subList.action?parentId=0",BASE_URL]
//产品多级分类接口
#define SUBLIST_URL(string) [NSString stringWithFormat:@"%@/category/subList.action?parentId=%d",BASE_URL,[string intValue]]

//城市选择
#define GET_PROVINCE_URL   [NSString stringWithFormat:@"%@/area/list.action",BASE_URLL]

#define GET_CITY_URL(provinceId)   [NSString stringWithFormat:@"%@/area/list.action?provinceId=%@&type=2",BASE_URLL,provinceId]

#define GET_DISTRUCT_URL(cityId)   [NSString stringWithFormat:@"%@/area/list.action?cityId=%@&type=3",BASE_URLL,cityId]

#define GET_DISTRUCT(city)   [NSString stringWithFormat:@"%@/area/selectDistrict.action?cityName=%@",BASE_URLL,city]
//产品详情
#define PRODUCT_URL_DETAIL(userid,productId,markId) [NSString stringWithFormat:@"%@/product/get.action?userId=%@&productId=%d&isRush=%d",BASE_URL,userid,[productId intValue],markId]
//产品属性
#define PRODUCT_URL_SKU(productId) [NSString stringWithFormat:@"%@/product/property.action?productId=%d&type=0",BASE_URL,[productId intValue]]
//行业分类
#define SUBLIST_URL(string) [NSString stringWithFormat:@"%@/category/subList.action?parentId=%d",BASE_URL,[string intValue]]

//查询购物车商品
#define ASK_SHOP_CAR_URL(userid) [NSString stringWithFormat:@"%@/shop/cartList.action?usersId=%@",BASE_URLL,userid]
//购物车添加商品
#define ADD_SHOP_CAR_URL(userid,pid,shopid,count) [NSString stringWithFormat:@"%@/cart/addCart.action?userId=%@&productId=%d&shopId=%d&count=%d",BASE_URL,userid,[pid intValue],[shopid intValue],[count intValue]]
//购物车添加sku商品
#define ADD_SHOP_SKU_URL(userid,pid,shopid,skuId,count) [NSString stringWithFormat:@"%@/cart/addCart.action?userId=%@&productId=%d&shopId=%d&skuId=%d&count=%d",BASE_URL,userid,[pid intValue],[shopid intValue],[skuId intValue],[count intValue]]


//积分商城列表
#define SCORE_LIST_URL [NSString stringWithFormat:@"%@/product/scoreList.action",BASE_URL]
//积分商城商品详细
#define SCORE_LIST_DETAIL_URL(productId) [NSString stringWithFormat:@"%@/product/get.action?productId=%d",BASE_URL,[productId intValue]]

//添加商铺或者收藏
#define ADD_COLLECTION_URL(userid,proShopId,colType) [NSString stringWithFormat:@"%@/collection/addCollection.action?userId=%@&proShopId=%d&colType=%d",BASE_URL,userid,[proShopId intValue],[colType intValue]]


//添加收货地址
#define ADD_ADRESS_URL(userid,lingName,address,phone) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&linkName=%@&address=%@&phone=%@&addressType=1&isDefault=0",BASE_URL,userid,lingName,address,phone]

//修改收货地址
#define ALTER_ADRESS_URL(userid,lingName,address,phone,isDefault,addressId) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&linkName=%@&address=%@&phone=%@&isDefault=%d&addressId=%d&addressType=1",BASE_URL,userid,lingName,address,phone,isDefault,addressId]
//查看用户收货地址
#define ASK_ADRESS_URL(userid) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&addressType=2",BASE_URL,userid]

//删除用户收货地址
#define DELETE_ADRESS_URL(userid,addressId,isDefault) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&addressId=%@&isDefault=%d&addressType=3",BASE_URL,userid,addressId,isDefault]

//查看用户默认地址
#define ASK_DEFAULT_ADRESS_URL(userid) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&addressType=4",BASE_URL,userid]
//设置用户默认地址
#define SET_DEFAULT_ADRESS_URL(userid,addressId) [NSString stringWithFormat:@"%@/address/all.action?userId=%@&addressType=4&%d",BASE_URL,userid,addressId]


//领取优惠劵
#define RECEIVE_COUPONS_URL(userid,couponsId) [NSString stringWithFormat:@"%@/coupons/get.action?userId=%@&couponsId=%d",BASE_URL,userid,couponsId]
//查询优惠劵相关
#define ASK_RELEAT_COUPONS_URL(userid,shopId,setTotal) [NSString stringWithFormat:@"%@/coupons/list.action?userId=%@&shopId=%d&setTotal=%f&type=0",BASE_URL,USERID,shopId,setTotal]
//查询优惠劵
#define ASK_COUPONS_URL [NSString stringWithFormat:@"%@/coupons/list.action?type=1&city=%@&ranking=0",BASE_URL,SELECT_CITY]
#define ASK_USER_COUPONS_URL(userId) [NSString stringWithFormat:@"%@/coupons/list.action?userId=%@&type=1&ranking=1",BASE_URL,userId]

//积分明细
#define  USER_scoreList(userId) [NSString stringWithFormat:@"%@/score/list.action?userId=%@",BASE_URL,userId]

//积分规则
#define  USER_LEVEL [NSString stringWithFormat:@"%@/users/userLevel.action",BASE_URL]
//帮助中心
#define  USER_HELPCENTER [NSString stringWithFormat:@"%@/users/help.action",BASE_URL]

//关于我们
#define ABOUT_WENWAN_URL  [NSString stringWithFormat:@"%@/setUp/get.action",BASE_URL]


//查询商品收藏
#define ASK_PRODUCT_C_URL(userId) [NSString stringWithFormat:@"%@/collection/proList.action?userId=%@&size=100",BASE_URL,userId]
//查询商铺收藏
#define ASK_SHOP_C_URL(userId) [NSString stringWithFormat:@"%@/collection/shopList.action?userId=%@",BASE_URL,userId]

//删除收藏
#define DELETE_COLLECT(colId) [NSString stringWithFormat:@"%@/collection/delCollection.action?colId=%d",BASE_URL,[colId intValue]]

//意见反馈
#define  USER_ADVICE_URL(userId,content) [NSString stringWithFormat:@"%@/suggestion/addSuggestion.action?userId=%@&content=%@",BASE_URL,userId,content]

//查看用户信息
#define  USER_INFO [NSString stringWithFormat:@"%@/users/selectUser.action?userId=%@",BASE_URL,USERID]

//买家个人中心订单数量（红色显示）
#define  USER_CENTER_GETCOUNT(userId) [NSString stringWithFormat:@"%@/order/getCount.action?userId=%@",BASE_URL,userId]
//删除购物车商品
#define DELETE_SHOP_CAR_URL(cartid) [NSString stringWithFormat:@"%@/cart/delCart.action?cartid=%@",BASE_URLL,cartid]
//商铺详情
#define SHOP_URL(string) [NSString stringWithFormat:@"%@/shop/get.action?shopId=%d",BASE_URLL,[string intValue]]
//查找相关店铺下所有商品

#define LBS_SHOP_PRODUCT_URL(shopId) [NSString stringWithFormat:@"%@/product/search.action?shopId=%d",BASE_URL,[shopId intValue]]


#define LBS_SHOP_PRODUCT_NEW_URL(string) [NSString stringWithFormat:@"%@/product/search.action?shopId=%d&ranking=5",BASE_URL,[string intValue]]

#define LBS_SHOP_PRODUCT_HOT_URL(string) [NSString stringWithFormat:@"%@/product/search.action?shopId=%d&ranking=1",BASE_URL,[string intValue]]

#define LBS_SHOP_PRODUCT_ADVICE_URL(string) [NSString stringWithFormat:@"%@/product/search.action?shopId=%d&isRecommend=1",BASE_URL,[string intValue]]
//添加评论或回复
#define ADD_COMMENT_URL(data) [NSString stringWithFormat:@"%@/comment/addComment.action?data=%@",BASE_URL,data]
//评论列表
#define  COMMENT_LIST_DETAIL_URL(productId) [NSString stringWithFormat:@"%@/comment/list.action?productId=%@",BASE_URL,productId]
#define  COMMENT_LIST_URL(productId,rating) [NSString stringWithFormat:@"%@/comment/list.action?productId=%@&rating=%d",BASE_URL,productId,rating]

//订单详情
#define ORDER_DETAIL_URL(orderNo) [NSString stringWithFormat:@"%@/order/get.action?orderNo=%@",BASE_URL,orderNo]
//订单列表
#define ORDER_LIST_URL(userId) [NSString stringWithFormat:@"%@/order/list.action?userId=%@",BASE_URLL,userId]

#define ORDER_LIST_SORT_URL(userId,orderState) [NSString stringWithFormat:@"%@/order/list.action?userId=%@&orderState=%@",BASE_URL,userId,orderState]
#define PAYTYPR_URL(userId) [NSString stringWithFormat:@"%@/payType/list.action?shopId=%@",BASE_URL,[shopId intValue]]

//取消订单
#define ORDER_DELETE_URL(orderNo) [NSString stringWithFormat:@"%@/order/remove.action?type=0&orderNo=%@",BASE_URLL,orderNo]

//发布话题

#define STORY_CONTENT_URL(userId,interactiveId,topicsTitle,topicsContent) [NSString stringWithFormat:@"%@/topics/add.action?userId=%@&interactiveId=%@&topicsTitle=%@&topicsContent=%@",BASE_URLL,userId,interactiveId,topicsTitle,topicsContent]

#define STORY_IMAGE_URL(storyId,imageSize,storyPath) [NSString stringWithFormat:@"%@/topics/add.action?topicsId=%d&imgSize=%d&linkImagePath=%@",URL_,[topicsId intValue],imgSize,linkImagePath]


//删除故事
#define STORY_DELETE_URL(topicsId) [NSString stringWithFormat:@"%@/topics/all.action?topicsId=%@",BASE_URLL,topicsId]


//故事
#define STORY_LIST_URL(tag) [NSString stringWithFormat:@"%@/story/all.action?tag=%d&type=0",BASE_URL,[tag intValue]]

//我的故事广告
//#define STORY_AD_URL  [NSString stringWithFormat:@"%@/adver/list.action?advPos=1&city=%@",BASE_URL,SELECT_CITY]
#define STORY_AD_URL  [NSString stringWithFormat:@"%@/adver/list.action?advPos=1&city=重庆市",BASE_URL]

//我的故事
#define STORY_MYSELF_URL(userId) [NSString stringWithFormat:@"%@/topics/list.action?userId=%@",BASE_URLL,userId]
//发布评论
#define STORY_LIST_PINGLUN_URL(userId,topicsId,commentContent) [NSString stringWithFormat:@"%@/topicComment/add.action?userId=%@&topicsId=%@&commentContent=%@",BASE_URLL,userId,topicsId,commentContent]

//举报
#define STORY_LIST_JUBAO_URL(userId,topicsId,reportContent) [NSString stringWithFormat:@"%@/topics/report.action?userId=%@&topicsId=%@&reportContent=%@",BASE_URLL,userId,topicsId,reportContent]
//故事点赞
#define STORY_LIST_ZAN_URL(userId,topicsId) [NSString stringWithFormat:@"%@/topics/praise.action?userId=%@&topicsId=%@",BASE_URLL,userId,topicsId]


//查询物流
#define ASK_POST_URL(orderNo) [NSString stringWithFormat:@"%@/order/getExpress.action?orderNo=%@",BASE_URL,orderNo]

//确认收货
#define ORDER_RECEIVE_URL(orderNo) [NSString stringWithFormat:@"%@/order/remove.action?type=1&orderNo=%@",BASE_URL,orderNo]
//退货申请
#define ORDER_BACK_URL(userId,productId,returnOrderNo,returnType,reason) [NSString stringWithFormat:@"%@/order/orderback.action?userId=%@&productId=%@&returnOrderNo=%@&returnType=%@&reason=%@",BASE_URL,userId,productId,returnOrderNo,returnType,reason]


//支付方式
#define PAY_TYPE_URL(shopId) [NSString stringWithFormat:@"%@/payType/list.action?shopId=%@",BASE_URL,shopId]

//模糊查询
#define SHOP_PRODUCT_ALL_URL(string) [NSString stringWithFormat:@"%@/product/search.action?ranking=%d",URL_,[string intValue]]

//添加人气
#define ADD_CLICKS_URL(shopId) [NSString stringWithFormat:@"%@/product/addClicks.action?shopId=%d",URL_,[shopId intValue]]







//加入订单

#define ADD_ORDER_URL(data) [NSString stringWithFormat:@"%@/order/addOrder.action?data=%@",URL_,data]











//商家秀
#define STORY_XIU_URL(manageId) [NSString stringWithFormat:@"%@/story/list.action?manageId=%@",URL_,manageId]



//#define STORY_IMAGE_URL(storyId,imageSize,storyPath) [NSString stringWithFormat:@"%@/story/all.action?storyId=%d&imageSize=%d&storyPath=%@&type=4",BASE_URLL,[storyId intValue],imageSize,storyPath]






//[NSString stringWithFormat:@"%@/score/get.action?productId=%@",URL_,productId]

//[NSString stringWithFormat:@"%@/product/get.action?userId=%@&productId=%d",URL_,userid,[productId intValue]]#

//评论回复
#define REPLAY(replayContent,topicCommentId) [NSString stringWithFormat:@"%@/topicComment/replay.action?replayContent=%@&topicCommentId=%@",BASE_URL,replayContent,topicCommentId]


#define districtId [[NSUserDefaults standardUserDefaults] objectForKey:@"districtId"]





