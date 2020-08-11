//
//  NewsAdapter.m
//  TableView
//
//  Created by fpm0259 on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "NewsAdapter.h"
#import "People.h"
@implementation NewsAdapter

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionLab = [UILabel new];
    People *p = [self.tableViewDatas[section] firstObject];
    sectionLab.text = p.name;
    return sectionLab;
}

@end
