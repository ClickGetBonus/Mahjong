//
//  GeneralDetailVC.m
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "GeneralDetailVC.h"
#import "GeneralCell.h"
#import "MAEnum.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Tools.h"
#import "UIScrollView+GQScrollView.h"
#import "STPickerSingle.h"


typedef void(^LexiSuccessBlock)(id respose);

@interface GeneralDetailVC ()
<
STPickerSingleDelegate
>

@property (nonatomic,strong)AVAudioPlayer *player;
// 启动游戏
@property (nonatomic, strong) UIButton *starButton;
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



// 选择器
@property (nonatomic, strong) STPickerSingle *picker;
@property(nonatomic,assign)BOOL isSuccess;// 是否授权成功

@property(nonatomic, strong) NSArray <NSNumber *> *types;
@property(nonatomic, strong) NSMutableArray <GeneralCell *> *cells;
@property (nonatomic, assign) NSInteger currentEditIndex;



@end

@implementation GeneralDetailVC


- (instancetype)initWithCellTypes:(NSArray *)types {
    if (self = [super initWithNibName:@"GeneralDetailVC" bundle:nil]) {
        self.types = types;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.types = @[@(GeneralCellTypeTextField),
                    @(GeneralCellTypeSinglePicker),
                    @(GeneralCellTypeSwitch),
                    @(GeneralCellTypeSwitchAndPicker)];
    
    [self loadJsonData];
    [self initSubviews];
    [self generalCells];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playMusic) object:nil];
}

- (void)loadJsonData {
    
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
    
}

- (void)initSubviews {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回白色"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//批量生成cell, 不使用tableView的重用机制
- (void)generalCells {
    
    self.cells = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.types.count; i++) {
        GeneralCellType type = self.types[i].integerValue;
        GeneralCell *cell;
        switch (type) {
            case GeneralCellTypeTextField:
                cell = [[GeneralCell alloc] initTextFieldTypeWithTitle:@"11" placeholder:@"请输入"];
                break;
            case GeneralCellTypeSwitch:
                cell = [[GeneralCell alloc] initSwitchWithTitle:@"switch"];
                break;
            case GeneralCellTypeSinglePicker:
                cell = [[GeneralCell alloc] initSinglePickTypeWithTitle:@"single" pickData:self.careTypeArr];
                break;
            default:
                cell = [[GeneralCell alloc] initSwitchAndPickTypeWithTitle:@"switchPick" pickData:self.goodsPercentArr];
                break;
        }
        __weak typeof(self) weakSelf = self;
        __weak GeneralCell *weakCell = cell;
        cell.pickBlock = ^() {
            weakSelf.currentEditIndex = weakCell.index;
            [weakSelf showPickerWithData:weakCell.pickData title:weakCell.title];
        };
        cell.switchBlock = ^(BOOL isOn) {
            isOn ? [self playTurnOnMusic] : [self stopTurnOnMusic];
        };
        [self.cells addObject:cell];
    }
}


#pragma mark - Audio

// 播放音乐
-(void)playTurnOnMusic{
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self getMusicURLWith:@"雀神99.0增强版功能开启成功"] error:nil];
    [self.player prepareToPlay];
    
    [self.player play];
}

- (void)stopTurnOnMusic {
    [self.player stop];
}

-(NSURL *)getMusicURLWith:(NSString * )name{
    
    NSString * musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:AudioType];
    NSURL * musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
    return musicURL;
    
}


#pragma mark - STPickerSingle

- (void)showPickerWithData:(NSArray <NSString *> *)data title:(NSString *)title {
    
    [self.view endEditing:YES];
    
    self.picker = [[STPickerSingle alloc]init];
    [self.picker setArrayData:[data mutableCopy]];
    [self.picker setTitle:title];
    [self.picker setContentMode:STPickerContentModeBottom];
    [self.picker setDelegate:self];
    [self.picker show];
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
    
    GeneralCell *cell = self.cells[self.currentEditIndex];
    [cell setContent:selectedTitle];
}

#pragma mark - BackgroundView Click

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.types.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralCell *cell = self.cells[indexPath.section];
    cell.index = indexPath.section;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark-Action
- (void)clickAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ShuoMingMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
