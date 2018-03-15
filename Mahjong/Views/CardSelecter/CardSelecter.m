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


static NSString *const cellID = @"CardSelecterCell";
@interface CardSelecter()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSUInteger cardSum;

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *selections;

@end



@implementation CardSelecter

- (void)configureBy:(CardSelectType)type {
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.type = type;
    [self initSubviews];
}

- (void)initSubviews {
    self.selections = [NSMutableArray array];
    self.cards = [NSMutableArray array];
    switch (self.type) {
        case CardSelectTypePoker:
            self.cardSum = 52;
            for (NSInteger i=0; i<self.cardSum; i++) {
                
                Card *card = [Card new];
                if (i < 14) {
                    card.type = CardTypePokerDiamond;
                } else if (i < 27) {
                    card.type = CardTypePokerClub;
                } else if (i < 40) {
                    card.type = CardTypePokerHeart;
                } else if (i < 53) {
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
                if (i < 10) {
                    card.type = CardTypeMahjongTong;
                } else if (i < 19) {
                    card.type = CardTypeMahjongSuo;
                } else if (i < 28) {
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
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = CardSlecterCellRatio*CardSlecterCellHeight;
    layout.itemSize = CGSizeMake(width, CardSlecterCellHeight);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame
                                             collectionViewLayout:layout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardSelecterCell" bundle:nil]
          forCellWithReuseIdentifier:cellID];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
}

- (BOOL)isSelectCard:(Card *)card {
    return NO;
}

#pragma mark - UICollectionView Delegate & DataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CardSelecterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        Card *card = self.cards[indexPath.row];
        [cell setCard:card];
    } else if (indexPath.section == 1) {
        
        Card *card = self.selections[indexPath.row];
        [cell setCard:card];
    } else {
        
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.cardSum - self.selections.count;
    }
    return self.selections.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

@end
