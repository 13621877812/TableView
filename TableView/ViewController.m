//
//  ViewController.m
//  TableView
//
//  Created by Eden on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "ViewController.h"
#import "BaseAdapter.h"
@interface ViewController ()


@property (nonatomic, strong) BaseAdapter *adapter;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"示例Demo";
    

    self.adapter.frame(self.view.bounds)
    .parentView(self.view).rowHeight(60)
    .separatorStyle(UITableViewCellSeparatorStyleSingleLine)
    .datas(self.datas).setCellForRow(^(UITableViewCell *  _Nonnull cell, NSString *  _Nonnull model, NSIndexPath *indexPath) {
          cell.textLabel.text = model;
    })
    .setDidSelectRow(^(NSString *  _Nonnull model, NSIndexPath *indexPath) {
      
        UIViewController *viewController = [NSClassFromString(self.viewControllers[indexPath.row]) new];
        viewController.title = self.datas[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    });
    

    
}
- (NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@"简单Api链式调用",@"简单扩展",@"继承式扩展"];
    }
   return _datas;
}
- (NSArray *)viewControllers {
    if (_viewControllers == nil) {
        _viewControllers = @[@"CustomViewController",@"ExtensionViewController"
                   ,@"ExtendViewController"];
    }
   return _viewControllers;
}

- (BaseAdapter *)adapter {
    if (_adapter == nil) {
        _adapter = [BaseAdapter adapterWithCellsClass:@[[UITableViewCell class]] style:UITableViewStylePlain];
    }
   return _adapter;
}

@end
