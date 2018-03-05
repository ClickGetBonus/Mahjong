//
//  QiCaiLaoYanCaiViewController.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/9/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "QiCaiLaoYanCaiViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Tools.h"
#import "STPickerSingle.h"

@interface QiCaiLaoYanCaiViewController ()

    typedef void(^LexiSuccessBlock)(id respose);
    
    @property (weak, nonatomic) IBOutlet UIButton *goodsPersentButton;
    
    @property (nonatomic,strong)AVAudioPlayer  * thePlayer;
    @property (nonatomic, strong) STPickerSingle *pickerGood;
    
    @property (weak, nonatomic) IBOutlet UIButton *starButton;
    @property (weak, nonatomic) IBOutlet UITextField *codeTextField;
    @property(nonatomic,assign)BOOL isSuccess;// 是否授权成功
    
    
    
@end

@implementation QiCaiLaoYanCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"success"] isEqualToString:@"成功"]){
    //
    //        self.isSuccess = YES;
    //    }
    //
    NSLog(@"%@",self.myDataDic);
    self.title =  self.myDataDic[@"name"];
    
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
    
    self.goodsPersentButton.layer.cornerRadius = 3;
    self.goodsPersentButton.layer.borderWidth = 0.5;
    self.goodsPersentButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.goodsPersentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.goodsPersentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
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
    
#pragma mark -STPickerSingleDelegate
    
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
    
    if (pickerSingle == self.pickerGood) {
        
        [self.goodsPersentButton setTitle:selectedTitle forState:UIControlStateNormal];
        
        return;
    }
    
}
    
    // 好牌概率
- (IBAction)goodsPersent:(id)sender {
    
    self.pickerGood = [[STPickerSingle alloc]init];
    [self.pickerGood setArrayData:[NSMutableArray arrayWithArray:self.goodsPercentArr]];
    [self.pickerGood setTitle:@"好牌机率"];
    [self.pickerGood setContentMode:STPickerContentModeBottom];
    [self.pickerGood setDelegate:self];
    [self.pickerGood show];
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
    
    
    
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
    
    
    
    
#pragma mark- IBAction
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
