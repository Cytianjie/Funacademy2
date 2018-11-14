//
//  CoreDataManagement.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "CoreDataManagement.h"
#import "AppDelegate.h"

@implementation CoreDataManagement
+(NSManagedObject *)insertNewObjectForEntityForName:(NSString *)name{
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    NSManagedObject * object = [NSEntityDescription  insertNewObjectForEntityForName:name  inManagedObjectContext:[AppDelegate getAppDelegate].persistentContainer.viewContext];
    return object;
}
+(void)removeObject:(NSManagedObject *)object{
    [[AppDelegate getAppDelegate].persistentContainer.viewContext deleteObject:object];
}
+(NSManagedObject *)updateDataObjectForEntityForName:(NSString *)name key:(NSString *)key value:(NSString *)value{
    
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"%@ = %@", key,value];
    request.predicate = pre;
    //发送请求
    NSArray *resArray = [[AppDelegate getAppDelegate].persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    if (resArray.count > 0) {
        return resArray.firstObject;
    }
    return nil;
   
}
//读取查询
- (NSArray *)readDataForEntityForName:(NSString *)name{
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    // 从第几页开始显示
    request.fetchOffset = 0;
    // 每页显示多少条数据
    request.fetchLimit = NSIntegerMax;
    //发送查询请求
    NSArray *resArray = [[AppDelegate getAppDelegate].persistentContainer.viewContext executeFetchRequest:request error:nil];
    return resArray;
    
}
@end
