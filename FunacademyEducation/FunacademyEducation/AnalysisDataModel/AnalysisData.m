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
            NSDictionary * postdataDic = dicObj[@"postdata"];
            NSString * sid = [postdataDic[@"ID"] description];
            DBShareMessage * dbModel = (DBShareMessage *)[CoreDataManagement updateDataObjectForEntityForName:@"DBShareMessage" key:@"sid" value:sid];
            if (dbModel == nil) {
                dbModel = (DBShareMessage *)[CoreDataManagement insertNewObjectForEntityForName:@"DBShareMessage"];
            }
            dbModel.isclicklike = [dicObj[@"isclicklike"] description];
            dbModel.classID = [postdataDic[@"ClassID"] description];
            dbModel.classNamed = [postdataDic[@"ClassName"] description];
            dbModel.commentsCount = [postdataDic[@"CommentsCount"] description];
            dbModel.creatorTime = [postdataDic[@"CreatorTime"] description];
            dbModel.creatorUser = [postdataDic[@"CreatorUser"] description];
            dbModel.gartenID = [postdataDic[@"GartenID"] description];
            dbModel.imageurl = [postdataDic[@"imageurl"] description];
            dbModel.likeCount = [postdataDic[@"LikeCount"] description];
            dbModel.postTitle = [postdataDic[@"PostTitle"] description];
            dbModel.postContent = [postdataDic[@"PostContent"] description];
            dbModel.shareCount = [postdataDic[@"ShareCount"] description];
            dbModel.sId = sid;
            
            
            //dbModel.postContent = @"新京报讯（记者 刘臻）11月17日，北京人民艺术剧院表演艺术家狄辛因病在北京逝世。11月18日，北京人民艺术剧院官方微博发布";
            
            [dbModel removeHasPostResource:dbModel.hasPostResource];
            //解析图片
            NSArray * postresourceArray = dicObj[@"postresource"];
            if ([postresourceArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary * imageDic in postresourceArray) {
                    DBShareMessage * dbImageModel = (DBShareMessage *)[CoreDataManagement insertNewObjectForEntityForName:@"DBShareMessage"];
                    [dbModel addHasPostResourceObject:dbImageModel];
                }
                
//                for (int i = 0; i < 11; i++) {
//                    DBShareMessage * dbImageModel = (DBShareMessage *)[CoreDataManagement insertNewObjectForEntityForName:@"DBShareMessage"];
//                    dbImageModel.imageurl = @"http://04imgmini.eastday.com/mobile/20181119/20181119093151_947df8c0a915f71c51d80659c478c3d6_3_mwpm_03200403.jpg";
//                    [dbModel addHasPostResourceObject:dbImageModel];
//                }
               
            }
            
            
            
            //获取文本高度
            CGSize textSize = [TJToolsClass getTextSize:dbModel.postContent withFont:[UIFont systemFontOfSize:16] withWidth:kScreen_Width - 16];
            dbModel.contentStringMaxHeight = textSize.height;
            dbModel.contentStringHeight = textSize.height;
            if (textSize.height > 130) {
                dbModel.contentStringHeight = 130;
                dbModel.contentStringIsMore = YES;
            }else if (textSize.height < 20){
                dbModel.contentStringMaxHeight = 20;
                dbModel.contentStringHeight = 20;
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
            CGFloat allButton = dbModel.contentStringIsMore == YES ? 28 : 8;
            CGFloat tupian = dbModel.imageHeight;
            CGFloat dibu = 43;
            CGFloat cellHeight = touxiang + content + allButton + tupian + dibu;
            dbModel.cellHeight = cellHeight;
            dbModel.cellHeightMax = touxiang + dbModel.contentStringMaxHeight + 8 + dbModel.imageHeightMax + dibu;;
            
            [responseArray addObject:dbModel];
        }
    }
    [[AppDelegate getAppDelegate] saveContext];
    return responseArray;
}

@end
