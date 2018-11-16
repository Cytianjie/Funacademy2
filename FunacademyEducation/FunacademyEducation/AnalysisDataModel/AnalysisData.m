//
//  AnalysisData.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/16.
//  Copyright © 2018 清. All rights reserved.
//

#import "AnalysisData.h"
#import "AppDelegate.h"

@implementation AnalysisData

//首页每日分享数据
+(NSMutableArray *)getHomeDailyShare:(id)dataSource{
    NSMutableArray * responseArray = [[NSMutableArray alloc]init];
    NSDictionary *dataSourceDic = dataSource;
    NSArray * dataArray = dataSourceDic[@"data"];
    if ([dataArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dicObj in dataArray) {
            NSString * sid = dicObj[@"id"];
            DBShareMessage * dbModel = (DBShareMessage *)[CoreDataManagement updateDataObjectForEntityForName:@"DBShareMessage" key:@"sid" value:sid];
            if (dbModel == nil) {
                dbModel = (DBShareMessage *)[CoreDataManagement insertNewObjectForEntityForName:@"DBShareMessage"];
            }
            dbModel.classID = dicObj[@"classID"];
            dbModel.classNamed = dicObj[@"classNamed"];
            dbModel.commentsCount = dicObj[@"commentsCount"];
            dbModel.creatorTime = dicObj[@"creatorTime"];
            dbModel.creatorUser = dicObj[@"creatorUser"];
            dbModel.gartenID = dicObj[@"gartenID"];
            dbModel.imageurl = dicObj[@"imageurl"];
            dbModel.likeCount = dicObj[@"likeCount"];
            dbModel.postTitle = dicObj[@"postTitle"];
            dbModel.postContent = dicObj[@"postContent"];
            dbModel.shareCount = dicObj[@"shareCount"];
            dbModel.sId = dicObj[@"id"];
            
            [dbModel removeHasPostResource:dbModel.hasPostResource];
            //解析图片
            NSArray * postresourceArray = dicObj[@"postresource"];
            if ([postresourceArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary * imageDic in postresourceArray) {
                    DBShareMessage * dbImageModel = (DBShareMessage *)[CoreDataManagement insertNewObjectForEntityForName:@"DBShareMessage"];
                    
                    [dbModel addHasPostResourceObject:dbImageModel];
                }
               
            }
            
            
            
            //获取文本高度
            CGSize textSize = [TJToolsClass getTextSize:dbModel.postContent withFont:16 withWidth:kScreen_Width - 16];
            dbModel.contentStringMaxHeight = textSize.height;
            dbModel.contentStringHeight = textSize.height;
            if (textSize.height > 115) {
                dbModel.contentStringHeight = 116;
                dbModel.contentStringIsMore = YES;
            }
            
            int imageHangShu = 0;
            if (dbModel.hasPostResource.count == 0) {
                imageHangShu = 0;
            }else if (dbModel.hasPostResource.count % 3 == 0) {
                imageHangShu = (int)dbModel.hasPostResource.count/3;
            }else{
                imageHangShu = (int)dbModel.hasPostResource.count/3 + 1;
            }
            CGFloat imageWidth = (kScreen_Width - 16 - 10)/3;
            CGFloat imageHeight = (imageHangShu * imageWidth) + ((imageHangShu - 1) * 5);
            dbModel.imageHeightMax = imageHeight;//最大高度，无论多少图片都往下排
            if (imageHangShu >= 3) {
                //指定最大高度为3排
                CGFloat imageHeight = (3 * imageWidth) + (2 * 5);
                dbModel.imageHeight = imageHeight;
            }else{
                //不足3排
                dbModel.imageHeight = imageHeight;
            }
            
            //计算cell高度
            CGFloat touxiang = 56;
            CGFloat content = dbModel.contentStringHeight;
            CGFloat allButton = dbModel.contentStringIsMore == YES ? 28 : 0;
            CGFloat tupian = dbModel.imageHeight;
            CGFloat dibu = 40;
            CGFloat cellHeight = touxiang + content + allButton + tupian + dibu;
            dbModel.cellHeight = cellHeight;
            
            
            [responseArray addObject:dbModel];
        }
    }
    [[AppDelegate getAppDelegate] saveContext];
    return responseArray;
}

@end
