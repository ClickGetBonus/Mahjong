//
//  CardSelecter.m
//  Mahjong
//
//  Created by Lan on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CardSelecter.h"
#import "Card.h"
#import "CardSelecterCell.h"
#import "CardSelectButtonCell.h"
#import "CardSelecterHeader.h"
#import <SCLAlertView.h>

static NSString *const cardCellID = @"CardSelecterCell";
static NSString *const buttonCellID = @"CardSelecterButtonCell";
static NSString *const headerID = @"UICollectionViewHeader";

@interface CardSelecter()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger type;      //CardSelectType
@property (nonatomic, assign) NSUInteger cardSum;

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *selections;

@property (nonatomic, strong) UIView *backgroundView;

@end



@implementation CardSelecter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)configureBy:(CardSelectType)type {
    
    self.backgroundColor = [UIColor clearColor];
    self.type = type;
    [self initData];
}

- (void)initData {
    
    self.selections = [NSMutableArray array];
    self.cards = [NSMutableArray array];
    [self.collectionView scrollsToTop];
    
    switch (self.type) {
        case CardSelectTypePoker:
            self.cardSum = 52;
            for (NSInteger i=0; i<=self.cardSum; i++) {
                
                Card *card = [Card new];
                if (i < 13) {
                    card.type = CardTypePokerDiamond;
                } else if (i < 26) {
                    card.type = CardTypePokerClub;
                } else if (i < 39) {
                    card.type = CardTypePokerHeart;
                } else if (i < 52) {
                    card.type = CardTypePokerSpades;
                }
                card.num = i%13+1;
                [self.cards addObject:card];
            }
            break;
        case CardSelectTypeMahjong:
            self.cardSum = 34;
            
            for (NSInteger i=0; i<self.cardSum; i++) {
                Card *card = [Card new];
                if (i < 9) {
                    card.type = CardTypeMahjongTong;
                } else if (i < 18) {
                    card.type = CardTypeMahjongSuo;
                } else if (i < 27) {
                    card.type = CardTypeMahjongWan;
                } else {
                    card.type = CardTypeMahjongZi;
                }
                card.num = i%9+1;
                [self.cards addObject:card];
            }
            break;
        case CardSelectTypeBeard:
            self.cardSum = 20;
            for (NSInteger i=0; i<self.cardSum; i++) {
                Card *card = [Card new];
                if (i < 11) {
                    card.type = CardTypeBeardNum;
                } else {
                    card.type = CardTypeBeardWord;
                }
                card.num = i%10+1;
                [self.cards addObject:card];
            }
            break;
    }
    
    [self.collectionView reloadData];
}

- (void)initSubviews {
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    UIButton *button = [[UIButton alloc] initWithFrame:self.backgroundView.bounds];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(touchBackground) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:button];
    [self addSubview:self.backgroundView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20,
                                                                             80,
                                                                             KScreenWidth-40,
                                                                             KScreenHeight-120)
                                             collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardSelecterCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:cardCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardSelectButtonCell"
                                                    bundle:nil]          forCellWithReuseIdentifier:buttonCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardSelecterHeader" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:headerID];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.cornerRadius = 8.0f;
    self.collectionView.layer.masksToBounds = YES;
    [self addSubview:self.collectionView];
}

- (BOOL)isSelectCard:(Card *)card {
    return NO;
}

- (CGSize)getCardSizeWith:(CardSelectType)type {
    
    switch (type) {
        case CardSelectTypePoker:
            return CGSizeMake(CardSlecterCellPokerRatio*CardSlecterCellPokerHeight,
                              CardSlecterCellPokerHeight);
            break;
        case CardSelectTypeMahjong:
            return CGSizeMake(CardSlecterCellMahjongRatio*CardSlecterCellMahjongHeight,
                              CardSlecterCellMahjongHeight);
            break;
        case CardSelectTypeBeard:
            return CGSizeMake(CardSlecterCellBeardRatio*CardSlecterCellBeardHeight,
                              CardSlecterCellBeardHeight);
            break;
    }
}

#pragma mark - Action
- (void)touchBackground {
    if (self.cancelBlock != nil) {
        self.cancelBlock();
    }
}

#pragma mark - UICollectionView Delegate & DataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        CardSelecterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cardCellID
                                                                           forIndexPath:indexPath];
        
        Card *card = self.cards[indexPath.row];
        [cell setCard:card];
        cell.isSelected = [self.selections containsObject:card];
        return cell;
    } else if (indexPath.section == 1) {
        
        CardSelecterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cardCellID
                                                                           forIndexPath:indexPath];
        
        Card *card = self.selections[indexPath.row];
        [cell setCard:card];
        return cell;
    } else {
        
        CardSelectButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:buttonCellID forIndexPath:indexPath];
        [cell.button addTarget:self
                        action:@selector(touchBackground)
              forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.cardSum;
    } else if (section == 1) {
        return self.selections.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CardSelecterCell *cell = (CardSelecterCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        if (self.selections.count >= self.canSelectNum) {
            
            NSString *info = [NSString stringWithFormat:@"选牌不能超过%ld张", (long)self.canSelectNum];
            SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
            .addButtonWithActionBlock(@"确定", ^{ /*work here*/ });
            SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
            .style(SCLAlertViewStyleError)
            .title(info)
            .duration(0);
            [showBuilder showAlertView:builder.alertView onViewController:self.window.rootViewController];
            // or even
//            showBuilder.show(builder.alertView, self.window.rootViewController);
            
            return;
        }
        
        Card *card = self.cards[indexPath.row];
        if ([self.selections containsObject:card]) {
            NSUInteger index = [self.selections indexOfObject:card];
            [self.selections removeObject:card];
            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index
                                                                            inSection:1]]];
        } else {
            
            [self.selections addObject:card];
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selections.count-1 inSection:1]]];
        }
        [cell flipCard];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section <= 1) {
        return [self getCardSizeWith:self.type];
    } else {
        return CGSizeMake(ButtonCellWidth, ButtonCellHeight);
    }
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        return nil;
    }
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CardSelecterHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        
        
        if (indexPath.section == 0) {
            headerView.label.text = @"可选牌";
        } else if (indexPath.section == 1) {
            headerView.label.text = @"已选牌";
        }
        
        return headerView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 2) {
        return (CGSize){0, 0};
    }
    
    return (CGSize){KScreenWidth,44};
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
@end
