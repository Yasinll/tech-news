//
//  MYNewsModel.m
//  模拟科技头条
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//

#import "MYNewsModel.h"

@implementation MYNewsModel


- (NSString *)timeFormatter {

    // 把数字转换成时间对象
    NSDate *oldTime = [NSDate dateWithTimeIntervalSince1970:self.addtime.intValue];
    
    // 当前时间
    NSCalendar *calendar = [NSCalendar currentCalendar];

    /**
     *  和现在的时间进行对比
     *
     *  @param components 时间单位
     *  @param fromDate   比较的时间
     *  @param toDate     现在时间
     *  @param options    时间比较选项
     *  @return
     */
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitMinute fromDate:oldTime toDate:[NSDate date] options:0];
    
    // <60分钟
    if (dateComponent.minute < 60) {
        
        return [NSString stringWithFormat:@"%ld分钟之前",dateComponent.minute];
        
    }
    
    dateComponent = [calendar components:NSCalendarUnitHour fromDate: oldTime toDate:[NSDate date] options:0];
    
    if (dateComponent.hour < 24) {
        
        return [NSString stringWithFormat:@"%ld小时之前", dateComponent.hour];
        
    }
    
    // 大于一天前的新闻直接输入日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"MM:dd HH:mm";
    
    return [dateFormatter stringFromDate:oldTime];
    
}



+ (instancetype)modelWithDictionary:(NSDictionary *)dic {

    MYNewsModel *model = [[MYNewsModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    
    return model;

}

// kvc 没有找到key的情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }


- (NSString *)description {

    
    return [NSString stringWithFormat:@"%@ -- {title = %@, summary = %@, src_img = %@, siteName = %@, addtime =  %d}",[super description], self.title, self.summary, self.src_img,self.sitename, self.addtime.intValue];


}


+ (void)newsListWithSucess:(void (^)(NSArray *))succesBlock error:(void (^)())errorBlock {

    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1454222934/type/0?channel=appstore&uuid=8FCC46AD-2B0C-4DC2-89C8-9631855FAB13&net=5&model=iPhone&ver=1.0.5"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        // 连接错误判断
        if (connectionError) {
            
            if (errorBlock) {
                
                errorBlock();
                
            }
            
            return ;
            
        }
        
        // 判断服务器内部错误 状态码
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            
            NSMutableArray *mArray = [NSMutableArray array];
            
            // JSON反序列化到自定义对象
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            // array遍历
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                MYNewsModel *model = [MYNewsModel modelWithDictionary:obj];
                
                [mArray addObject:model];
                
            }];
            
//            self.newsListArray = mArray.copy;
            if (succesBlock) {
                
                succesBlock(mArray.copy);
            }
            
        } else {
            
//            NSLog(@"internal error");
            if (errorBlock) {
                
                errorBlock();
                
            }
            
        }
        
    }];



}


@end
