//
//  ShareMessageTableViewCell.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "ShareMessageTableViewCell.h"

@interface ShareMessageTableViewCell ()
@property(nonatomic,strong)NSIndexPath * indexPath;
@end

@implementation ShareMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageButton.layer.masksToBounds = YES;
    self.headerImageButton.layer.cornerRadius = self.headerImageButton.frame.size.width/2;
    [self.shareButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.commetnsButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.giveLikeButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLayoutData:(DBShareMessage *)model withIndePath:(NSIndexPath *)indexPath withViewSource:(NSInteger)source{
    self.indexPath = indexPath;
    self.titleNameLabel.text = model.creatorUser;
    self.timeLabel.text = model.creatorTime;
    self.classNameLabel.text = model.classNamed;
    self.contentLabel.text = model.postContent;
    
    if (source == 1) {
        if (model.contentStringIsMore == YES) {
            self.allButton.hidden = NO;
            self.imageBackViewTopValue.constant = 8;
        }else{
            self.allButton.hidden = YES;
            self.imageBackViewTopValue.constant = -20;
        }
    }else{
        self.allButton.hidden = YES;
        self.imageBackViewTopValue.constant = -20;
    }
    
    
    [self.imageBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger xCount = model.hasPostResource.count;//最大循环次数
    if (source == 1 && model.hasPostResource.count > 9) {
        xCount = 9;
    }
    
    
    CGFloat viewWidthHeight = (kScreen_Width - 16 - 10)/3;
    for (int i = 0; i < xCount; i++) {
        int lieShu = i%3;
        int hangShu = i/3;
        DBShareMessage * imageModel = model.hasPostResource[i];
        UIButton * imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageViewButton.frame = CGRectMake(lieShu*viewWidthHeight+lieShu*5, hangShu*viewWidthHeight+hangShu*5, viewWidthHeight, viewWidthHeight);
        imageViewButton.backgroundColor = [UIColor clearColor];
        imageViewButton.tag = i;
        [imageViewButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imageModel.imageurl] forState:UIControlStateNormal placeholderImage:[TJToolsClass getPlaceholderImage]];
        [self.imageBackView addSubview:imageViewButton];
        
    }
    
}

-(void)imageButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(imageButtonClick: withIndexPath:)]) {
        [self.delegate imageButtonClick:button.tag withIndexPath:self.indexPath];
    }
}
-(void)bottomButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(bottomViewButtonClick: withIndexPath:)]) {
        [self.delegate bottomViewButtonClick:button.tag withIndexPath:self.indexPath];
    }
}
@end
