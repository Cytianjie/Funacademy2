//
//  LoginViewController.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : RootViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

NS_ASSUME_NONNULL_END
