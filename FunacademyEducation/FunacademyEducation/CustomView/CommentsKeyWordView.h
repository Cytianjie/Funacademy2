//
//  CommentsKeyWordView.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  键盘
 */
/**
 键盘完成--Delegate
 */
@protocol CommentsKeyWordViewDelegate <NSObject>


/**
 <#Description#>

 @param textView 实时监测输入的高度
 */
-(void)textViewDidChangeTextHeright:(CGFloat)textViewHeight;
/**
 *  键盘回调
 *
 *  @param string 输入的文字
 */
-(void)chatpageKeyboardDelegate:(NSString *)string;
/**
 *  监听键盘动作为抬起
 *
 *  @param indexhight 键盘高度
 */
- (void)keyBoardWillShow:(CGFloat)indexhight;
/**
 *  监听键盘动作为收回
 */
- (void)keyBoardWillHide;

@end

@interface CommentsKeyWordView : UIView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *inPutChangeButton;
@property(nonatomic,assign) id<CommentsKeyWordViewDelegate> keyboardDelegate;
@property(nonatomic,strong) UILabel * textViewLable;
-(void)creatLayout;
//textview复原
-(void)textViewChuShiStype;
@end

NS_ASSUME_NONNULL_END
