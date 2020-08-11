//
//  ExtendViewController.m
//  TableView
//
//  Created by Eden on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "ExtendViewController.h"
#import "NewsAdapter.h"
#import "People.h"
@interface ExtendViewController ()
@property (nonatomic, strong) NewsAdapter *adapter;

@property (nonatomic, strong) NSArray *datas;
@end

@implementation ExtendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    主要针对BaseAdapter里面的功能过于简单，无法满足现有需求，
//    此时可以新创建BaseAdapter的子类，单独完成复杂的功能
//    
    self.adapter.frame(self.view.bounds)
              .parentView(self.view)
    .separatorStyle(UITableViewCellSeparatorStyleSingleLine)
              .rowHeight(80)
    .count(self.datas.count)
    .datas(self.datas);

    
    
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
        
        
        _datas = @[@[p1],@[p2],@[p3]];
        
    }
   return _datas;
}

- (NewsAdapter *)adapter {
    if (_adapter == nil) {
        //三种创建方式 效果一样 喜欢哪一种自己选择 自动支持xib
//        _adapter = [BaseAdapter adapterWithCellClass:[ExtendCell class]];
//        _adapter = BaseAdapter.adapter([CustomCell class]);
       _adapter = (NewsAdapter *)NewsAdapter.adapterWithCellName(@"ExtendCell");
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
