//
//  MYNewsModel.h
//  模拟科技头条
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNewsModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *src_img;
@property (copy, nonatomic) NSString *sitename;
@property (copy, nonatomic) NSNumber *addtime;


// 时间转换后的结果
@property (copy, nonatomic) NSString *timeFormatter;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;


// 提供网络数据
+ (void)newsListWithSucess:(void(^)(NSArray *array))succesBlock error:(void(^)())errorBlock;

@end
