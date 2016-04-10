//
//  MYNewsCell.m
//  模拟科技头条
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//

#import "MYNewsCell.h"
#import "UIImageView+WebCache.h"

@implementation MYNewsCell


+ (NSString *)getReuse:(MYNewsModel *)model {

    NSString *identifier = @"newscell";
    
    if (model.src_img.length == 0) {
        
        identifier = @"newscell2";
        
    }
    
    
    return identifier;
    
}

- (void)setModel:(MYNewsModel *)model {

    _model = model;
    
    self.lb_title.text = model.title;
    
    self.lb_summary.text = model.summary;
    
    self.lb_siteName.text = model.sitename;
    
    // 设置格式化时间
    self.lb_addTime.text = model.timeFormatter;
    
    [self.newsImgView sd_setImageWithURL:[NSURL URLWithString:model.src_img]];

}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    // Xcode7中，可能需要手动进行label的自动布局约束
    [self.lb_title layoutIfNeeded];
    
    // 此方法中，已经确定了控件的位置
    // 1.取到文字一行显示的宽度
    CGFloat textWidth = [self.model.title sizeWithAttributes:@{NSAttachmentAttributeName: self.lb_title.font}].width;
    
    // 2.label的宽度
    CGFloat labelWidth = self.lb_title.frame.size.width;
    
    if (textWidth > labelWidth) {
        
        // 文字大于一行副标题隐藏
        self.lb_summary.hidden = YES;
        
    } else {
    
        self.lb_summary.hidden = NO;
    
    }

}


@end
