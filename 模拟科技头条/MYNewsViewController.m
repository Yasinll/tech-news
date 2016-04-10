//
//  ViewController.m
//  模拟科技头条
//
//  Created by 浅爱 on 16/3/2.
//  Copyright © 2016年 my. All rights reserved.
//


// 1.获取网络数据JSON
// 2.JSON反序列化
// 3.简单搭建界面 (去掉自带的vc，使用tableViewController)
// 4.将vc减负(把loadNews功能交给model)
// 5.下拉刷新(在sb中将tvc的refresh功能勾选上,并拖线)
// 6.自定义cell(换行，简介 新闻来源重叠  时间等问题)
// 7.格式化时间
// 8.没有图片的新闻


#import "MYNewsViewController.h"
#import "MYNewsModel.h"
#import "MYNewsCell.h"


@interface MYNewsViewController ()

// 新闻数据集合
@property (strong, nonatomic) NSArray *newsListArray;

@end

@implementation MYNewsViewController


- (void)setNewsListArray:(NSArray *)newsListArray {

    _newsListArray = newsListArray;
    
    // 刷新界面
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.refreshControl setTintColor:[UIColor redColor]];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"加载中..." attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    [self.refreshControl setAttributedTitle:str];
    
    [self loadNews];
    
}


- (IBAction)loadNews {
    
    [MYNewsModel newsListWithSucess:^(NSArray *array) {
        
        self.newsListArray = array;
        
        // 数据刷新结束 禁用刷洗功能
        [self.refreshControl endRefreshing];
        
    } error:^{
        
        NSLog(@"error");
        // 数据刷新结束 禁用刷洗功能
        [self.refreshControl endRefreshing];
        
    }];

}


#pragma mark - delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsListArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // model
    MYNewsModel *model = self.newsListArray[indexPath.row];
    
    MYNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[MYNewsCell getReuse:model] forIndexPath:indexPath];
    
    cell.model = model;

    
    return cell;

}


// 隐藏一下系统状态栏
- (BOOL)prefersStatusBarHidden {

    
    return YES;

}


@end






