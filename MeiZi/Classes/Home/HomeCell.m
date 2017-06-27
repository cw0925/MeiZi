//
//  HomeCell.m
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(HomeModel *)model{
    //NSLog(@"%@",model.imgurl);
    [_img sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"placehold.jpg"]];
}
@end
