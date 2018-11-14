//
//  ShareMessageTableViewCell.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "ShareMessageTableViewCell.h"

@implementation ShareMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageButton.layer.masksToBounds = YES;
    self.headerImageButton.layer.cornerRadius = self.headerImageButton.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
