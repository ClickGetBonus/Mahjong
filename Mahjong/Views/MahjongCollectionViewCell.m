//
//  MahjongCollectionViewCell.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MahjongCollectionViewCell.h"

@interface MahjongCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MahjongCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.nameLabel.layer.cornerRadius= 15;
    self.nameLabel.layer.borderWidth = 1;
    self.nameLabel.clipsToBounds = YES;
    self.nameLabel.layer.borderColor =  UIColorRGB(0x4689d3).CGColor;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;

    self.headerImageView.layer.cornerRadius = 8;
    self.headerImageView.clipsToBounds = YES;
}

-(void)configureDataWite:(id)data{

    if (data) {
        
        [self.headerImageView setImage:[UIImage imageNamed:data[@"image"]]];
        
        NSString * nameStr = [NSString stringWithFormat:@" %@    ",data[@"name"]];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:nameStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        NSTextAttachment  * attcahMent = [NSTextAttachment new];
        attcahMent.image = [UIImage imageNamed:@"set"];
        attcahMent.bounds =  CGRectMake(0, -3, 15, 15);
        NSAttributedString *text = [NSAttributedString attributedStringWithAttachment:attcahMent];
        [attriStr insertAttributedString:text atIndex:0];
        
        self.nameLabel.attributedText = attriStr;
    }
    
    
}

@end
