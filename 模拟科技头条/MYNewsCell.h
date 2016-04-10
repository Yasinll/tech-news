//
//  MYNewsCell.h
//  模拟科技头条
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYNewsModel.h"

@interface MYNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_title;

@property (weak, nonatomic) IBOutlet UILabel *lb_summary;

@property (weak, nonatomic) IBOutlet UILabel *lb_siteName;

@property (weak, nonatomic) IBOutlet UILabel *lb_addTime;

@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;


@property (strong, nonatomic) MYNewsModel *model;


// 返回一个cell identifier
+ (NSString *)getReuse:(MYNewsModel *)model;


@end
