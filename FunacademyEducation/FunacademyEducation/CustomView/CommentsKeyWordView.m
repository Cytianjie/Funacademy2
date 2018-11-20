//
//  CommentsKeyWordView.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import "CommentsKeyWordView.h"

@implementation CommentsKeyWordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)creatLayout{
    self.textView.editable = YES;
    self.textView.textColor = [UIColor blackColor];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;//标有Done的蓝色按钮
    self.textViewLable = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, self.textView.bounds.size.width, 35)];
    self.textViewLable.textColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont systemFontOfSize:17];
    [self.textView addSubview:self.textViewLable];
    
    
    [self.inPutChangeButton setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
    [self.inPutChangeButton setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateSelected];
    //注册键盘
    [self registerForKeyboardNotifications];
    
}
#pragma  mark - 键盘弹出的通知和返回高度的方法
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWasShownASD:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillBeHiddenASD:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShownASD:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    if ([_keyboardDelegate respondsToSelector:@selector(keyBoardWillShow:)]) {
        [_keyboardDelegate keyBoardWillShow:kbSize.height];
    }
    
    
}
//当键盘隐藏的时候
- (void)keyboardWillBeHiddenASD:(NSNotification*)aNotification{
    if ([_keyboardDelegate respondsToSelector:@selector(keyBoardWillHide)]) {
        [_keyboardDelegate keyBoardWillHide];
    }
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
    CGSize size = [textView.text sizeWithFont:[textView font]];
    int length = size.height;
    int colomNumber = textView.contentSize.height/length;
    if (colomNumber < 3) {
       
        if ([_keyboardDelegate respondsToSelector:@selector(textViewDidChangeTextHeright:)]) {
            [_keyboardDelegate textViewDidChangeTextHeright:colomNumber*34 + 16];
        }
        
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![text isEqualToString:@""])
    {
        self.textViewLable.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.textViewLable.hidden = NO;
    }
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        [self clickOkButtonToCompleteTheOperation];
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
//textview复原
-(void)textViewChuShiStype{
    self.textView.text = @"";
    self.textViewLable.hidden = NO;
    [self.textView resignFirstResponder];
    if ([_keyboardDelegate respondsToSelector:@selector(textViewDidChangeTextHeright:)]) {
        [_keyboardDelegate textViewDidChangeTextHeright:1*34 + 16];
    }
}
-(void)clickOkButtonToCompleteTheOperation{
    if ([_keyboardDelegate respondsToSelector:@selector(chatpageKeyboardDelegate:)]) {
        [_keyboardDelegate chatpageKeyboardDelegate:self.textView.text];
    }
    
}

@end
