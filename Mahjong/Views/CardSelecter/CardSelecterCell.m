//
//  CardSelecterCell.m
//  Mahjong
//
//  Created by Lan on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CardSelecterCell.h"

@interface CardSelecterCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CardSelecterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.isSelected = NO;
}


- (void)setCard:(Card *)card {
    
    if ([self maxnumBy:card.type] < card.num) {
        return;
    }
    
    _card = card;
    [self.imageView setImage:[self cardImageBy:_card]];
}


- (void)setIsSelected:(BOOL)isSelected {
    if (isSelected == _isSelected) {
        return;
    }
    
    _isSelected = isSelected;
    [self changeFace];
}


- (void)flipCard {
    
    _isSelected = !_isSelected;
    
    // 延时方法 正在翻转的牌翻转一半的时候把它移到视图最上面来
//    [self performSelector:@selector(changeFace) afterDelay:1.2 / 2];
    [self performSelector:@selector(changeFace) withObject:nil afterDelay:FlipCardIntercal/2];
    // 翻转动画
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:self.imageView
                      duration:FlipCardIntercal
                       options:option
                    animations:^ {
                        
                    }
                    completion:^(BOOL finished){
                        
                    }];
}

- (void)changeFace {
    
    
    if (_isSelected) {
        
        [self.imageView setImage:[self selectedImageBy:_card.type]];
    } else {
        [self.imageView setImage:[self cardImageBy:_card]];
    }
}
                     
#pragma mark - Getter
- (NSInteger)maxnumBy:(CardType)type {
    
    switch (type) {
        case CardTypePokerDiamond:
        case CardTypePokerClub:
        case CardTypePokerHeart:
        case CardTypePokerSpades:
            return 13;
        case CardTypePokerJoker:
            return 2;
        case CardTypeMahjongTong:
        case CardTypeMahjongSuo:
        case CardTypeMahjongWan:
            return 9;
        case CardTypeMahjongZi:
            return 7;
        case CardTypeBeardNum:
        case CardTypeBeardWord:
            return 10;
    }
}

- (NSString *)prefixBy:(CardType)type {
    switch (type) {
        case CardTypePokerDiamond:
            return @"a";
        case CardTypePokerClub:
            return @"b";
        case CardTypePokerHeart:
            return @"c";
        case CardTypePokerSpades:
            return @"d";
        case CardTypePokerJoker:
            return @"joker";
        case CardTypeMahjongTong:
            return @"t";
        case CardTypeMahjongSuo:
            return @"s";
        case CardTypeMahjongWan:
            return @"w";
        case CardTypeMahjongZi:
            return @"z";
        case CardTypeBeardNum:
            return @"p";
        case CardTypeBeardWord:
            return @"pb";
    }
}

- (UIImage *)selectedImageBy:(CardType)type {
    
    switch (type) {
        case CardTypePokerDiamond:
        case CardTypePokerClub:
        case CardTypePokerHeart:
        case CardTypePokerSpades:
        case CardTypePokerJoker:
            return [UIImage imageNamed:@"poker_selected"];
        case CardTypeMahjongTong:
        case CardTypeMahjongSuo:
        case CardTypeMahjongWan:
        case CardTypeMahjongZi:
            return [UIImage imageNamed:@"mahjong_selected"];
        case CardTypeBeardNum:
        case CardTypeBeardWord:
            return [UIImage imageNamed:@"beard_selected"];
    }
}

- (UIImage *)cardImageBy:(Card *)card {
    
    NSString *imageName = [NSString stringWithFormat:@"%@%ld", [self prefixBy:card.type], (long)card.num];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}


@end
