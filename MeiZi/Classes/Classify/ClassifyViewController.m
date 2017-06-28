//
//  ClassifyViewController.m
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ClassifyViewController.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "GirlInfoViewController.h"

#define ItemWidth 60

@interface ClassifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,copy)NSMutableArray *dataArr;

@end

@implementation ClassifyViewController
{
    UIScrollView *scroll;
    UICollectionView *classifyCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar:@"分类" hasLeft:NO];
    [self initTopUI];
    [self initUI];
    [self sendRequestHomeData];
}
- (void)initTopUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *arr = @[@"性感",@"浴室",@"私房",@"美腿",@"清纯",@"甜美",@"治愈系",@"萌妹子",@"小清新",@"女神",@"气质美女",@"嫩模",@"车模",@"比基尼",@"足球宝贝",@"萝莉",@"90后",@"日韩美女"];
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 64, ViewWidth-10, 50)];
    //scroll.backgroundColor = [UIColor greenColor];
    scroll.contentSize = CGSizeMake(ItemWidth*arr.count, 0);
    scroll.pagingEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    for (NSInteger i = 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ItemWidth*i, 0, ItemWidth, 50);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i+1;
        if (btn.tag == 1) {
            [btn setTitleColor:RGBColor(0, 178, 247) forState:UIControlStateNormal];
        }
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(senderClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:btn];
    }
    [self.view addSubview:scroll];
}
- (void)senderClick:(UIButton *)sender{
    for (UIView *view in scroll.subviews) {
        UIButton *btn = (UIButton *)view;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (view.tag == sender.tag) {
            [sender setTitleColor:RGBColor(0, 178, 247) forState:UIControlStateNormal];
        }
    }
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((ViewWidth-10)/2, ViewWidth/2);
    classifyCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+50, ViewWidth, ViewHeight-64-50-49) collectionViewLayout:layout];
    classifyCollection.delegate = self;
    classifyCollection.dataSource = self;
    classifyCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:classifyCollection];
    
    [classifyCollection registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    HomeModel *model = self.dataArr[indexPath.item];
    [cell configCell:model];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GirlInfoViewController *info = [[GirlInfoViewController alloc]init];
    HomeModel *model = self.dataArr[indexPath.item];
    info.navcTitle = model.title;
    info.url = model.url;
    info.hidesBottomBarWhenPushed = YES;
    PushController(info)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestHomeData{
    [LSProgressHUD showToView:self.view message:@"正在加载..."];
    [AFNetHelper GET:HomeURL parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        //NSLog(@"%@",dic);
        if ([dic[@"msg"] isEqualToString:@"ok"]) {
            for (NSDictionary *item in dic[@"data"]) {
                HomeModel *model = [[HomeModel alloc]init];
                [model setValuesForKeysWithDictionary:item];
                //NSLog(@"%@",model.imgurl);
                [self.dataArr addObject:model];
            }
            [LSProgressHUD hideForView:self.view];
            [classifyCollection reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
