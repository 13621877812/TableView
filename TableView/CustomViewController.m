//
//  CustomViewController.m
//  TableView
//
//  Created by Eden on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "CustomViewController.h"
#import "BaseAdapter.h"
#import "CustomCell.h"
#import "People.h"
@interface CustomViewController ()

@property (nonatomic, strong) BaseAdapter *adapter;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //重点推荐链式调用
    self.adapter.frame(self.view.bounds)
//    .style(UITableViewStylePlain) 不设置默认是Grouped
       .parentView(self.view) //tableView被添加的父view
    .separatorStyle(UITableViewCellSeparatorStyleSingleLine) //分界线类型，默认不显示
       .rowHeight(80) //行高 不设置 默认行高
//       .count(2) //两个区，不设置 默认为1 ,数据源要和区匹配
       .datas(self.datas) //数据源 会自动刷新tableView
//       .setCellForRow(^(CustomCell *  _Nonnull cell, People *  _Nonnull model, NSIndexPath *indexPath) {
////             cell.model = model;
//       }) //cellFor回调，如果设置cellProperty(@"people")不起作用
       .cellProperty(@"people") //默认为model 表示cell有个model属性
       .setDidSelectRow(^(People *  _Nonnull model, NSIndexPath *indexPath) {
           NSLog(@"------%@",model.name);
       });//点击回调
    
    //其他API
    //获取tableView
    UITableView *tableView = self.adapter.tableView;
    
    //获取cell标识符
    NSString *cellReuseIdentifier = self.adapter.cellReuseIdentifier;
    
    //利用非链式回调
//    self.adapter.cellForRow = ^(id  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
//        
//    };
//    self.adapter.didSelectRow = ^(id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
//        
//    };
    
    //更换数据源并刷新tableView
    self.adapter.tableViewDatas = self.datas;
    
    //设置区个数
//    self.adapter.sectionCount = 2;
 
    
}

#pragma mark -- getter
- (NSArray *)datas {
    if (_datas == nil) {
        People *p1 = [People new];
        p1.name = @"张三丰";
        p1.age = 108;
        p1.hobby = @"练武";
        
        People *p2 = [People new];
        p2.name = @"叶志佳";
        p2.age = 48;
        p2.hobby = @"救死扶伤";
        
        People *p3 = [People new];
        p3.name = @"朱元璋";
        p3.age = 53;
        p3.hobby = @"爱江山更爱美人";
        
        
        _datas = @[p1,p2,p3];
        
    }
   return _datas;
}

- (BaseAdapter *)adapter {
    if (_adapter == nil) {
        //三种创建方式 效果一样 喜欢哪一种自己选择 自动支持xib
//        _adapter = [BaseAdapter adapterWithCellClass:[CustomCell class] style:nil];
       _adapter = BaseAdapter.adapter([CustomCell class]);
//        _adapter = BaseAdapter.adapterWithCellName(@"CustomCell");
    }
   return _adapter;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
