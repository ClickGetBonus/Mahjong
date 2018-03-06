//
//  ViewController.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "MahjongCollectionViewCell.h"
#import "NewDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NewSecondDetailViewController.h"
#import "FishingDetailViewController.h"
#import "AuthorViewController.h"
#import "CHessViewController.h"
#import "SanShuiViewController.h"
#import "ZhaJinHuaViewController.h"
#import "CustomYouXiViewController.h"
#import "YingShanZhangViewController.h"
#import "DouNiuYouXiViewController.h"
#import "DouDiZhuYouXiViewController.h"
#import "WuShiKeiViewController.h"
#import "LaoHuJiViewController.h"
#import "SanGongViewController.h"
#import "DeKeSaSiViewController.h"
#import "PaiJiuShezhiViewController.h"
#import "BaiJiaLeViewController.h"
#import "QiCaiLaoYanCaiViewController.h"
#import "TuiTongziViewController.h"
#import "GeneralDetailVC.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic,strong)NSMutableArray * dataArr;// 数据数组
// 选择牌型
@property(nonatomic,strong)NSArray * careTypeArr;
// 选择好牌几率
@property(nonatomic,strong)NSArray * goodsPercentArr;
// 跑得快
@property(nonatomic,strong)NSArray * runFastArr;
// 跑胡子
@property(nonatomic,strong)NSArray * runBeardArr;

@property(nonatomic,strong)AVAudioPlayer  * thePlayer;

@property(nonatomic,strong)NSArray * twoTypeArr;// 第二种类型数组

@property(nonatomic,strong)NSArray * thirdArr; //第三种类型数组


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"授权" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"start"] error:nil];
    [self.thePlayer prepareToPlay];
    [self.thePlayer play];
    
    NSString * jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    //将JSON数据转为NSArray或NSDictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [self.dataArr addObjectsFromArray:dict[@"allData"]];
    self.careTypeArr = dict[@"cardType"];
    self.runFastArr = dict[@"runFast"];
    self.runBeardArr = dict[@"runBeard"];
    self.goodsPercentArr = dict[@"percentage"];
    
    self.twoTypeArr = @[@"闲来游戏",@"皮皮游戏",@"土豪游戏",@"龙宇游戏",@"丫丫游戏",@"星悦游戏",@"么么哒游戏",@"同城乐游戏",@"优乐游戏"];
    
    self.thirdArr = @[@"棋牌游戏"];
    
    [self configureViews];
}

#pragma mark- ConfigureView

-(void)configureViews{

    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MahjongCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MahjongCollectionViewCell"];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.dataArr.count;

}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MahjongCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MahjongCollectionViewCell" forIndexPath:indexPath];
    [cell configureDataWite:self.dataArr[indexPath.row]];
    
    return cell;
}
#pragma mark- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = self.dataArr[indexPath.row];
    NSString * str  = dic[@"name"];
    
    if ([self.twoTypeArr containsObject:str]) {
        
        GeneralDetailVC *detailVC = [[GeneralDetailVC alloc] initWithNibName:@"GeneralDetailVC"
                                                                      bundle: nil];
        [self.navigationController pushViewController:detailVC animated:YES];
        
//        NewSecondDetailViewController * detailTowVC = [[NewSecondDetailViewController alloc]initWithNibName:@"NewSecondDetailViewController" bundle:nil];
//        detailTowVC.runFastArr = self.runFastArr;
//        detailTowVC.runBeardArr = self.runBeardArr;
//        detailTowVC.careTypeArr = self.careTypeArr;
//        detailTowVC.goodsPercentArr = self.goodsPercentArr;
//        detailTowVC.myDataDic = self.dataArr[indexPath.row];
//        [self.navigationController pushViewController:detailTowVC animated:YES];
 
    }else if([str isEqualToString:@"捕鱼游戏"]){
    
        
        FishingDetailViewController * fishingVC = [[FishingDetailViewController alloc]initWithNibName:@"FishingDetailViewController" bundle:nil];
        fishingVC.runFastArr = self.runFastArr;
        fishingVC.runBeardArr = self.runBeardArr;
        fishingVC.careTypeArr = self.careTypeArr;
        fishingVC.goodsPercentArr = self.goodsPercentArr;
        fishingVC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:fishingVC animated:YES];
        
    }else if([self.thirdArr containsObject:str]){
    
        CHessViewController * chessVC = [[CHessViewController alloc]initWithNibName:@"CHessViewController" bundle:nil];
        chessVC.runFastArr = self.runFastArr;
        chessVC.runBeardArr = self.runBeardArr;
        chessVC.careTypeArr = self.careTypeArr;
        chessVC.goodsPercentArr = self.goodsPercentArr;
        chessVC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:chessVC animated:YES];
        
        
    }else if([str isEqualToString:@"十三水游戏"]){
    
        SanShuiViewController * VC = [[SanShuiViewController alloc]initWithNibName:@"SanShuiViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];

    }else if ([str isEqualToString:@"炸金花游戏"]){
        
        ZhaJinHuaViewController * VC = [[ZhaJinHuaViewController alloc]initWithNibName:@"ZhaJinHuaViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ([str isEqualToString:@"自动识别平台"])
    {
        CustomYouXiViewController * VC = [[CustomYouXiViewController alloc]initWithNibName:@"CustomYouXiViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([str isEqualToString:@"五十K"])
    {
        WuShiKeiViewController * VC = [[WuShiKeiViewController alloc]initWithNibName:@"WuShiKeiViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;

        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    else if ([str isEqualToString:@"老虎机"])
    {
        LaoHuJiViewController * VC = [[LaoHuJiViewController alloc]initWithNibName:@"LaoHuJiViewController" bundle:nil];

        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([str isEqualToString:@"三公"])
    {
        SanGongViewController * VC = [[SanGongViewController alloc]initWithNibName:@"SanGongViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;

        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([str isEqualToString:@"德克萨斯扑克"])
    {
        DeKeSaSiViewController * VC = [[DeKeSaSiViewController alloc]initWithNibName:@"DeKeSaSiViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;

        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if([str isEqualToString:@"斗地主游戏"]){
    
        DouDiZhuYouXiViewController * VC = [[DouDiZhuYouXiViewController alloc]initWithNibName:@"DouDiZhuYouXiViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if([str isEqualToString:@"斗牛游戏"]){
    
        DouNiuYouXiViewController * VC = [[DouNiuYouXiViewController alloc]initWithNibName:@"DouNiuYouXiViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([str isEqualToString:@"赢三张游戏"]){
        
        YingShanZhangViewController * VC = [[YingShanZhangViewController alloc]initWithNibName:@"YingShanZhangViewController" bundle:nil];
        VC.runFastArr = self.runFastArr;
        VC.runBeardArr = self.runBeardArr;
        VC.careTypeArr = self.careTypeArr;
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ([str isEqualToString:@"牌九设置"]){
        
        PaiJiuShezhiViewController * VC = [[PaiJiuShezhiViewController alloc]initWithNibName:@"PaiJiuShezhiViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ([str isEqualToString:@"百家乐"]){
        
        BaiJiaLeViewController * VC = [[BaiJiaLeViewController alloc]initWithNibName:@"BaiJiaLeViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        VC.careTypeArr = self.careTypeArr;

        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ([str isEqualToString:@"七彩捞腌菜"]){
        
        QiCaiLaoYanCaiViewController * VC = [[QiCaiLaoYanCaiViewController alloc]initWithNibName:@"QiCaiLaoYanCaiViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ([str isEqualToString:@"推筒子"]){
        
        TuiTongziViewController * VC = [[TuiTongziViewController alloc]initWithNibName:@"TuiTongziViewController" bundle:nil];
        VC.goodsPercentArr = self.goodsPercentArr;
        VC.myDataDic = self.dataArr[indexPath.row];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
    
        NewDetailViewController * detailVC = [[NewDetailViewController alloc]initWithNibName:@"NewDetailViewController" bundle:nil];
        detailVC.runFastArr = self.runFastArr;
        detailVC.runBeardArr = self.runBeardArr;
        detailVC.careTypeArr = self.careTypeArr;
        detailVC.goodsPercentArr = self.goodsPercentArr;
        detailVC.myDataDic = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];

        
    }
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (Iphone5s) {
        
        return CGSizeMake((KScreenWidth - 75)/3, (KScreenWidth - 75)/3 + 40);
  
    }
    if (Iphone6){
    
        return CGSizeMake((KScreenWidth - 75)/4, (KScreenWidth - 75)/4 + 40);
 
    }
    return CGSizeMake((KScreenWidth - 90)/4, (KScreenWidth - 90)/4 + 40);
}

-(NSURL *)getMusicURLWith:(NSString * )name{
    
    NSString * musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:AudioType];
    NSURL * musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
    return musicURL;
    
}


#pragma mark- Action

-(void)clickAction{
    
    AuthorViewController * authorVC = [[AuthorViewController alloc]initWithNibName:@"AuthorViewController" bundle:nil];
    [self.navigationController pushViewController:authorVC animated:YES];
    
}

#pragma mark- Setter/Getter
-(NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
