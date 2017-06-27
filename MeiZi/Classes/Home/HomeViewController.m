//
//  HomeViewController.m
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "GirlInfoViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,copy)NSMutableArray *dataArr;

@end

@implementation HomeViewController
{
    UICollectionView *homeCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self sendRequestHomeData];
    [self customNavigationBar:@"首页" hasLeft:NO];
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((ViewWidth-10)/2, ViewWidth/2);
    homeCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    homeCollection.delegate = self;
    homeCollection.dataSource = self;
    homeCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:homeCollection];
    
    [homeCollection registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
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
            [homeCollection reloadData];
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
