//
//  BaseAdapter.m
//  TableView
//
//  Created by Eden on 2020/8/10.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "BaseAdapter.h"

static NSString *prefix = @"Eden";
@interface BaseAdapter()

//cell标识符前缀 默认为eden
@property (nonatomic, copy, readwrite) NSString *cellReuseIdentifier;

//
@property (nonatomic, copy, readwrite) NSString *cellProps;

//tableView
@property (nonatomic, strong, readwrite) UITableView *tableView;


@end
@implementation BaseAdapter

#pragma mark -- constructor

+ (BaseAdapter *)adapterWithCellClass:(Class)cellClass {
    
    UITableView *tableView = [self getTableView];
    return [self adapterWithTableView:tableView cellClass:cellClass];
    
    
}
+ (BaseAdapter *)adapterWithTableView:(UITableView *)tableView cellClass:(Class)cellClass {
   
    NSAssert([tableView isKindOfClass:[UITableView class]], @"tableView 必须是UITableView的子类");
 

    NSAssert([cellClass isSubclassOfClass:[UITableViewCell class]], @"cellClass 必须是UITableViewCell的子类");

    BaseAdapter *adapter = [self new];
    adapter.sectionCount = 1;

    NSString *className = NSStringFromClass(cellClass);
    NSString *cellReuseIdentifier = [NSString stringWithFormat:@"%@_%@", prefix, className];

    NSString *nibPath = [[NSBundle mainBundle]pathForResource:className ofType:@"nib"];
    if (nibPath) { //当前cell是xib
        [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
    } else { //当前cell不是xib
        [tableView registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifier];
    }

    tableView.delegate = adapter;
    tableView.dataSource = adapter;

    adapter.tableView = tableView;
    adapter.cellReuseIdentifier = cellReuseIdentifier;

    return adapter;
}
+ (BaseAdapter *_Nonnull(^)(NSString *cellClassName))adapterWithCellName {
    
   return ^BaseAdapter *(NSString *cellClassName) {
     return [self adapterWithCellClass:NSClassFromString(cellClassName)];
  };
}
+ (BaseAdapter *_Nonnull(^)(Class cellClass))adapter {
    return ^BaseAdapter *(Class cellClass) {
      return [self adapterWithCellClass:cellClass];
    };
}

+ (BaseAdapter *_Nonnull(^)(UITableView *tableView,Class cellClass))adapterWithTableView {
    return ^BaseAdapter *(UITableView *tableView, Class cellClass) {
       return [self adapterWithTableView:tableView cellClass:cellClass];
    };
}

#pragma mark --- property
//设置tableView大小
- (FrameBlock)frame {
    
  return ^BaseAdapter *(CGRect frame){
      self.tableView.frame = frame;
      return self;
    };
}

//设置tableView父View
- (ParentViewBlock)parentView {
    
  return ^BaseAdapter *(UIView *parentView){
      [parentView addSubview:self.tableView];
      return self;
    };

}
- (RowHeightBlock)rowHeight {
    
   return ^BaseAdapter *(CGFloat rowHeight){
       self.tableView.rowHeight = rowHeight;
        return self;
    };
}
- (SectionCountBlock)count {
    
   return ^BaseAdapter *(NSInteger sectionCount){
        self.sectionCount = sectionCount;
        return self;
    };
    
}
- (DatasBlock)datas {
    
   return ^BaseAdapter *(NSArray *datas){
        self.tableViewDatas = datas;
        return self;
    };
    
}
- (CellPropertyBlock)cellProperty {
    
   return ^BaseAdapter *(NSString *cellProperty){
       if (cellProperty && cellProperty.length > 0) {
           cellProperty = [cellProperty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       }
        self.cellProps = cellProperty;
        return self;
    };
    
}


- (SetCellForRowBlock)setCellForRow {
    
   return ^BaseAdapter *(CellForRowBlock cellForRow){
        self.cellForRow = cellForRow;
        return self;
    };
}

- (SetDidSelectRowBlock)setDidSelectRow {
   return ^BaseAdapter *(DidSelectRowBlock didSelectRow){
        self.didSelectRow = didSelectRow;
        return self;
    };
}
#pragma mark -- public
- (void)reloadData {
    [self.tableView reloadData];
}
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}
#pragma mark ---UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tableViewDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
    NSString *methodName = @"setModel:";
    if (self.cellProps != nil && self.cellProps.length != 0) {
        methodName = [NSString stringWithFormat:@"set%@:",[self.cellProps capitalizedString]];
    }
    if (self.cellForRow == nil && [cell respondsToSelector:NSSelectorFromString(methodName)]) { //查看cell是否有model属性，有则赋予值
        [cell setValue:self.tableViewDatas[indexPath.row] forKey:@"model"];
    }
    if (self.cellForRow) {
        self.cellForRow(cell,self.tableViewDatas[indexPath.row]);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRow) {
        self.didSelectRow(self.tableViewDatas[indexPath.row]);
    }
}
#pragma mark -- getter&setter
+ (UITableView *)getTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.tableFooterView = [UIView new];
    return tableView;
}
- (void)setTableViewDatas:(NSArray *)tableViewDatas {
    _tableViewDatas = tableViewDatas;
    [self.tableView reloadData];
}
@end
