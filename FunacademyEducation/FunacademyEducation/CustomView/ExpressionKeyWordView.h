//
//  ExpressionKeyWordView.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpressionKeyWordViewDelegate <NSObject>

-(void)expressionKeyWord:(NSString *)string;
@end

@interface ExpressionKeyWordView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property(nonatomic,assign) id<ExpressionKeyWordViewDelegate> delegate;

@property(nonatomic,strong)NSMutableArray * dataArray;
-(void)creatLayout;
@end

NS_ASSUME_NONNULL_END
