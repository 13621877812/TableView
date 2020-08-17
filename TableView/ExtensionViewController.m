//
//  ExtensionViewController.m
//  TableView
//
//  Created by Eden on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "ExtensionViewController.h"
#import "BaseAdapter.h"
#import "CustomCell.h"
#import "People.h"
@interface ExtensionViewController ()
@property (nonatomic, strong) BaseAdapter *adapter;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.adapter.frame(self.view.bounds)
           .parentView(self.view)
           .rowHeight(80)
    .separatorStyle(UITableViewCellSeparatorStyleSingleLine)
           .datas(self.datas);
    
    UITableView *tableView = self.adapter.tableView;
    
    //拿到tableView对其进行扩展
    UIView *headView = [UIView new];
    headView.backgroundColor = [UIColor lightGrayColor];
    headView.frame = CGRectMake(0, 0, 414, 100);
    tableView.tableHeaderView = headView;
    
    
    
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
        _adapter = [BaseAdapter adapterWithCellsClass:@[[CustomCell class]] style:UITableViewStyleGrouped] ;
       
//        _adapter = BaseAdapter.adapter(@[[CustomCell class]]);
//        _adapter = BaseAdapter.adapterWithCellsName(@[@"CustomCell"]);
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
