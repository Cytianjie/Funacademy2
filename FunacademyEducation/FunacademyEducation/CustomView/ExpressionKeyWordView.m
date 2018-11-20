//
//  ExpressionKeyWordView.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import "ExpressionKeyWordView.h"
#import "EaseEmoji.h"

@implementation ExpressionKeyWordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)creatLayout{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.dataArray = [[NSMutableArray alloc]init];
    [self.dataArray addObjectsFromArray:[EaseEmoji allEmoji]];
    [self.dataArray addObject:@"!!del!!"];
    [self.collectionView reloadData];
    [self.sendButton setTitle:NSLocalizedString(@"send", nil) forState:UIControlStateNormal];
    
}
#pragma mark 设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}
#pragma mark 设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}
#pragma mark 设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    UIButton * embutton = [cell.contentView viewWithTag:10101];
    
    if (embutton == nil) {
       embutton = [UIButton buttonWithType:UIButtonTypeCustom];
        embutton.frame = CGRectMake(0, 0, kScreen_Width/7, kScreen_Width/7);
        embutton.tag = 10101;
        [cell.contentView addSubview:embutton];
        embutton.userInteractionEnabled = NO;
    }
    
    NSString * emjio = self.dataArray[indexPath.row];
    if ([emjio isEqualToString:@"!!del!!"]) {
        
        [embutton setImage:[UIImage imageNamed:@"icon_keyboard_del"] forState:UIControlStateNormal];
        [embutton setTitle:@"" forState:UIControlStateNormal];
    }else{
        [embutton setTitle:[[EaseEmoji allEmoji] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [embutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return cell;
    
}
#pragma mark 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreen_Width/7,kScreen_Width/7);
    
}
#pragma mark 定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
    
}
#pragma mark 定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}
#pragma mark 定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}
#pragma mark 点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(expressionKeyWord:)]) {
        
        [self.delegate expressionKeyWord:self.dataArray[indexPath.row]];
    }
}


@end
