//
//  CoreDataManagement.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManagement : NSObject
+(NSManagedObject *)insertNewObjectForEntityForName:(NSString *)name;
//读取查询
+(NSManagedObject *)updateDataObjectForEntityForName:(NSString *)name key:(NSString *)key value:(NSString *)value;
- (NSArray *)readDataForEntityForName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
