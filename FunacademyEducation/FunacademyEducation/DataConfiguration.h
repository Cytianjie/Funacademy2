//
//  DataConfiguration.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#ifndef DataConfiguration_h
#define DataConfiguration_h

#import <UIKit/UIKit.h>
#import "NetworkRequestManager.h"
#import "UIKit+AFNetworking.h"
#import "TJLoading.h"
#import "LoadDataSuggest.h"
#import <Hyphenate/Hyphenate.h>
#import "MyAlerView.h"
#import "UIImageView+WebCache.h"
#import "TJToolsClass.h"
#import "FAMJMJRefreshManagement.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kColor_RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:(a)]




#endif /* DataConfiguration_h */
