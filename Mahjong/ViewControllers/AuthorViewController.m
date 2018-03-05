//
//  AuthorViewController.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AuthorViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Tools.h"
#import "UIScrollView+GQScrollView.h"

@interface AuthorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (nonatomic,strong)AVAudioPlayer  * thePlayer;

@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"启动连接";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白色"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

#pragma mark- IBAction

- (IBAction)startAction:(id)sender {
    
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
        
        NSLog(@"---------%@", result);
        NSLog(@"========%@=======%@",error,response);

        if ([result containsString:@"登录成功"]) {
       
            [SVProgressHUD showSuccessWithStatus:@"授权成功"];
            [[NSUserDefaults standardUserDefaults] setObject:@"成功" forKey:@"success"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            weakSelf.thePlayer =   [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版授权成功,渗透数据成功,修改后台数据完成,请切换至游戏!"] error:nil];
            [weakSelf.thePlayer prepareToPlay];
            
            [weakSelf.thePlayer play];

        }else{
            
            [SVProgressHUD showErrorWithStatus:@"授权失败"];

        }
        
        
    }];
    
    
    // 启动任务
    [task0 resume];


}

-(NSURL *)getMusicURLWith:(NSString * )name{
    
    NSString * musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:AudioType];
    NSURL * musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
    return musicURL;
    
}

#pragma mark-Action
-(void)clickAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ShuoMingMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
