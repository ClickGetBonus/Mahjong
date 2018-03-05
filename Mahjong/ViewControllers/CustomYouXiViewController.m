//
//  CustomYouXiViewController.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomYouXiViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Tools.h"
#import "UIScrollView+GQScrollView.h"
#import "STPickerSingle.h"



typedef void(^LexiSuccessBlock)(id respose);

@interface CustomYouXiViewController ()<STPickerSingleDelegate>

@property (nonatomic,strong)AVAudioPlayer  * thePlayer;
// 启动游戏
@property (weak, nonatomic) IBOutlet UIButton *starButton;
//选择类型
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
//跑得快牌型
@property (weak, nonatomic) IBOutlet UIButton *goodsPersentButton;
//跑胡子牌型
@property (weak, nonatomic) IBOutlet UIButton *startCardTypeButton;
//21点
@property (weak, nonatomic) IBOutlet UIButton *Ponit21Button;
//豹子
@property (weak, nonatomic) IBOutlet UIButton *BaoziButton;

//起手牌型
@property (weak, nonatomic) IBOutlet UIButton *QishoupaixingButton;

@property (weak, nonatomic) IBOutlet UIButton *haoPaiJiLvButton;

/// 顶部选择类型
@property (nonatomic, strong) STPickerSingle *pickerCla;
/// 底部选择类型
@property (nonatomic, strong) STPickerSingle *pickerNum;
/// 选择起手牌型
@property (nonatomic, strong) STPickerSingle *pickerGood;

/// 顶部选择类型
@property (nonatomic, strong) STPickerSingle *point21pickerCla;
/// 底部选择类型
@property (nonatomic, strong) STPickerSingle *paixingpickerNum;
/// 选择起手牌型
@property (nonatomic, strong) STPickerSingle *qishoupaixingpickerGood;

@property (nonatomic, strong) STPickerSingle *haopaijilvpickerGood;


@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property(nonatomic,assign)BOOL isSuccess;// 是否授权成功




@end

@implementation CustomYouXiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"success"] isEqualToString:@"成功"]){
    //
    //        self.isSuccess = YES;
    //    }
    //
    NSLog(@"%@",self.myDataDic);
    self.title =  self.myDataDic[@"name"];
    
    [self.typeButton setTitle:[self.myDataDic[@"list"] firstObject] forState:UIControlStateNormal];
    [self configureViews];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playMusic) object:nil];
}


-(void)configureViews{
    
    
    self.starButton.layer.cornerRadius  = 6;
    self.starButton.layer.borderWidth = 2;
    self.starButton.layer.borderColor = UIColorRGB(0x3b6daa).CGColor;
    
    self.typeButton.layer.cornerRadius = 3;
    self.typeButton.layer.borderWidth = 0.5;
    self.typeButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.typeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.goodsPersentButton.layer.cornerRadius = 3;
    self.goodsPersentButton.layer.borderWidth = 0.5;
    self.goodsPersentButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.goodsPersentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.goodsPersentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    self.startCardTypeButton.layer.cornerRadius = 3;
    self.startCardTypeButton.layer.borderWidth = 0.5;
    self.startCardTypeButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.startCardTypeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.startCardTypeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    self.Ponit21Button.layer.cornerRadius = 3;
    self.Ponit21Button.layer.borderWidth = 0.5;
    self.Ponit21Button.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.Ponit21Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.Ponit21Button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.BaoziButton.layer.cornerRadius = 3;
    self.BaoziButton.layer.borderWidth = 0.5;
    self.BaoziButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.BaoziButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.BaoziButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.QishoupaixingButton.layer.cornerRadius = 3;
    self.QishoupaixingButton.layer.borderWidth = 0.5;
    self.QishoupaixingButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.QishoupaixingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.QishoupaixingButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.haoPaiJiLvButton.layer.cornerRadius = 3;
    self.haoPaiJiLvButton.layer.borderWidth = 0.5;
    self.haoPaiJiLvButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.haoPaiJiLvButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.haoPaiJiLvButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白色"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}


// 播放音乐
-(void)playMusic{
    
    NSString *  numberx = [NSString stringWithFormat:@"%d",(arc4random() % 27 + 1)];
    self.thePlayer =  [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:numberx] error:nil];
    [self.thePlayer prepareToPlay];
    
    [self.thePlayer play];
    
    [self performSelector:@selector(playMusic) withObject:nil afterDelay:10];
    
}


-(NSURL *)getMusicURLWith:(NSString * )name{
    
    NSString * musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:AudioType];
    NSURL * musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
    return musicURL;
    
}


#pragma mark - login Http

// 用户根据注册码 登录

-(void)userLoginWithRegistrationCodeSuccessBlock:(LexiSuccessBlock)successBlock{
    
    
    if (self.codeTextField.text != nil && self.codeTextField.text.length == 0) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入注册码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    
    [SVProgressHUD showWithStatus:@"正在开启..."];
    
    // 快捷方式获得session对象
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString * requestUrl =  [NSString stringWithFormat:@"%@?flag=注册码登录&机器码=%@&注册码=%@&项目名称=雀神",baseUrl,[NSString deviceUUID],self.codeTextField.text];
    NSString *encodedValue = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedValue];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    urlRequest.timeoutInterval = 120;
    
    // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
    __weak typeof (self)weakSelf = self;
    NSURLSessionTask * task0 = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        
        self.isSuccess = YES;
        NSLog(@"---------%@", result);
        NSLog(@"========%@=======%@",error,response);
        
        successBlock(result);
    }];
    
    
    // 启动任务
    [task0 resume];
    
}


#pragma mark-IBAction

//透视下一家牌
- (IBAction)firstAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        
        [self.thePlayer play];
        
        
    }else{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playMusic) object:nil];
        [self.thePlayer stop];
    }
    
}
//起手暗杠
- (IBAction)secondAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
//快速自摸
- (IBAction)thirdAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
//透视三家牌
- (IBAction)fourAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
//防点炮
- (IBAction)fiveAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
// 防杠
- (IBAction)sixAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
//防检测防封号
- (IBAction)sevenAction:(id)sender {
    
    UISwitch * openYuWangSilder = (UISwitch *)sender;
    BOOL setting = openYuWangSilder.isOn;
    
    self.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.thePlayer prepareToPlay];
    
    if (setting) {
        
        [self.thePlayer play];
        
    }else{
        
        [self.thePlayer stop];
    }
    
}
- (IBAction)startAction:(id)sender {
    
    
    if (self.starButton.isSelected) {
        
        return;
    }
    
    __weak typeof (self) weakSelf = self;
    
    [self userLoginWithRegistrationCodeSuccessBlock:^(id respose) {
        
        __strong typeof (weakSelf)strongify = weakSelf;
        
        if ([respose containsString:@"登录成功"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                [strongify.starButton setSelected:YES];
                [strongify.starButton setTitle:@"启动成功" forState:UIControlStateNormal];
                
                strongify.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版授权成功,渗透数据成功,修改后台数据完成,请切换至游戏!"] error:nil];
                [strongify.thePlayer prepareToPlay];
                
                [strongify.thePlayer play];
                
                
                
            });
        }else{
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:respose];
                
            });
            
        }
        
        
    }];
    
    
}

#pragma mark-Action
-(void)clickAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ShuoMingMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
}


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -STPickerSingleDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
    
    if (pickerSingle == self.pickerCla) {
        
        [self.typeButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    if (pickerSingle == self.pickerNum) {
        
        [self.startCardTypeButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    if (pickerSingle == self.pickerGood) {
        
        [self.goodsPersentButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    if (pickerSingle == self.point21pickerCla) {
        
        [self.Ponit21Button setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    if (pickerSingle == self.paixingpickerNum) {
        
        [self.BaoziButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    if (pickerSingle == self.qishoupaixingpickerGood) {
        
        [self.QishoupaixingButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    if (pickerSingle == self.haopaijilvpickerGood) {
        
        [self.haoPaiJiLvButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}




#pragma mark- IBAction
//顶部
- (IBAction)top:(id)sender {
    
    
    self.pickerCla = [[STPickerSingle alloc]init];
    [self.pickerCla setArrayData:[NSMutableArray arrayWithArray:self.myDataDic[@"list"]]];
    [self.pickerCla setTitle:@"选择"];
    [self.pickerCla setContentMode:STPickerContentModeBottom];
    [self.pickerCla setDelegate:self];
    [self.pickerCla show];
    
    
    
}
// 好牌概率
- (IBAction)goodsPersent:(id)sender {
    
    
    self.pickerGood = [[STPickerSingle alloc]init];
    [self.pickerGood setArrayData:[NSMutableArray arrayWithArray:@[@"同花顺",@"炸弹",@"顺子",@"三同张",@"飞机带翅膀"]]];
    
    [self.pickerGood setTitle:@"选择"];
    [self.pickerGood setContentMode:STPickerContentModeBottom];
    [self.pickerGood setDelegate:self];
    [self.pickerGood show];
    
    
}
// 起手牌型
- (IBAction)start:(id)sender {
    
    self.pickerNum = [[STPickerSingle alloc]init];
    [self.pickerNum setArrayData:[NSMutableArray arrayWithArray:@[@"对对胡",@"天胡",@"自摸",@"乌胡",@"红胡",@"大",@"小",@"海底胡",@"真点胡",@"假点胡"]]];
    [self.pickerNum setTitle:@"选择"];
    [self.pickerNum setContentMode:STPickerContentModeBottom];
    [self.pickerNum setDelegate:self];
    [self.pickerNum show];
    
    
    
    
}


// 21点
- (IBAction)point21:(id)sender {
    
    
    self.point21pickerCla = [[STPickerSingle alloc]init];
    [self.point21pickerCla setArrayData:[NSMutableArray arrayWithArray:@[@"双A",@"花A",@"5小张",@"21点",@"20点",@"19点"]]];
    [self.point21pickerCla setTitle:@"选择"];
    [self.point21pickerCla setContentMode:STPickerContentModeBottom];
    [self.point21pickerCla setDelegate:self];
    [self.point21pickerCla show];
    
    
}
// 起手牌型
- (IBAction)paixing:(id)sender {
    
    self.paixingpickerNum = [[STPickerSingle alloc]init];
    [self.paixingpickerNum setArrayData:[NSMutableArray arrayWithArray:@[@"豹子",@"顺金",@"金花",@"顺子",@"对子",@"单张"]]];
    [self.paixingpickerNum setTitle:@"选择"];
    [self.paixingpickerNum setContentMode:STPickerContentModeBottom];
    [self.paixingpickerNum setDelegate:self];
    [self.paixingpickerNum show];
    
    
}

- (IBAction)qishoupaixing:(id)sender {
    
    
    self.qishoupaixingpickerGood = [[STPickerSingle alloc]init];
    [self.qishoupaixingpickerGood setArrayData:[NSMutableArray arrayWithArray:self.careTypeArr]];
    [self.qishoupaixingpickerGood setTitle:@"选择"];
    [self.qishoupaixingpickerGood setContentMode:STPickerContentModeBottom];
    [self.qishoupaixingpickerGood setDelegate:self];
    [self.qishoupaixingpickerGood show];
    
    
}
- (IBAction)haoPaijilvPersent:(id)sender {
    
    self.haopaijilvpickerGood = [[STPickerSingle alloc]init];
    [self.haopaijilvpickerGood setArrayData:[NSMutableArray arrayWithArray:self.goodsPercentArr]];
    [self.haopaijilvpickerGood setTitle:@"选择"];
    [self.haopaijilvpickerGood setContentMode:STPickerContentModeBottom];
    [self.haopaijilvpickerGood setDelegate:self];
    [self.haopaijilvpickerGood show];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
