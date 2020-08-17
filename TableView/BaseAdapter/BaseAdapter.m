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
@property (nonatomic, strong, readwrite) NSArray *cellReuseIdentifiers;

//
@property (nonatomic, copy, readwrite) NSString *cellProps;

//tableView
@property (nonatomic, strong, readwrite) UITableView *tableView;


@end
@implementation BaseAdapter

#pragma mark -- constructor

+ (BaseAdapter *)adapterWithCellsClass:(NSArray<Class> *)cellsClass style:(UITableViewStyle)style {
    
    UITableView *tableView = [self getTableView:style];
    return [self adapterWithTableView:tableView cellsClass:cellsClass];
    
    
}
- (void)registCell:(NSArray<Class> *)cellsClass {
    NSMutableArray *cellIds = [@[] mutableCopy];
    for (Class cellClass in cellsClass) {
         NSAssert([cellClass isSubclassOfClass:[UITableViewCell class]], @"cellClass 必须是UITableViewCell的子类");
          NSString *className = NSStringFromClass(cellClass);
          NSString *cellReuseIdentifier = [NSString stringWithFormat:@"%@_%@", prefix, className];
        [cellIds addObject:cellReuseIdentifier];
          NSString *nibPath = [[NSBundle mainBundle]pathForResource:className ofType:@"nib"];
          if (nibPath) { //当前cell是xib
              [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
          } else { //当前cell不是xib
              [self.tableView registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifier];
          }
    }
    self.cellReuseIdentifiers = [cellIds copy];

}
+ (BaseAdapter *)adapterWithTableView:(UITableView *)tableView cellsClass:(NSArray<Class> *)cellsClass {
   
    NSAssert([tableView isKindOfClass:[UITableView class]], @"tableView 必须是UITableView的子类");

    BaseAdapter *adapter = [self new];
    adapter.sectionCount = 1;

    
    
    
    tableView.delegate = adapter;
    tableView.dataSource = adapter;

    adapter.tableView = tableView;
    
    [adapter registCell:cellsClass];
    

    return adapter;
}
+ (BaseAdapter *_Nonnull(^)(NSArray<NSString *> *cellsClassName))adapterWithCellsName {
    
    
    
   return ^BaseAdapter *(NSArray<NSString *> *cellsClassName) {
       NSMutableArray *classes = [@[] mutableCopy];
       for(int index = 0;index < cellsClassName.count;index++){
           [classes addObject:NSClassFromString(cellsClassName[index])];
        }
       return [self adapterWithCellsClass:[classes copy] style:UITableViewStyleGrouped];
  };
}
+ (BaseAdapter *_Nonnull(^)(NSArray<Class>  * cellsClass))adapter {
    return ^BaseAdapter *(NSArray<Class>  * cellsClass) {
      return [self adapterWithCellsClass:cellsClass style:UITableViewStyleGrouped];
    };
}

+ (BaseAdapter *_Nonnull(^)(UITableView *tableView,NSArray<Class> *cellsClass))adapterWithTableView {
    return ^BaseAdapter *(UITableView *tableView, NSArray<Class> *cellsClass) {
       return [self adapterWithTableView:tableView cellsClass:cellsClass];
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
//分界线是否显示
- (CellSeparatorStyleBlock)separatorStyle {
    
   return ^BaseAdapter *(UITableViewCellSeparatorStyle separatorStyle){
       self.tableView.separatorStyle = separatorStyle;
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
- (SetSelectCellBlock)setSelectCell {
    
   return ^BaseAdapter *(SelectCellBlock selectCell){
        self.selectCellBlock = selectCell;
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
   
    return [[self getSectionDataSource:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = [self getSectionDataSource:indexPath.section][indexPath.row];
   
    NSString *cellReuseIdentifier = self.cellReuseIdentifiers.firstObject;
    if (self.selectCellBlock) {
        NSInteger index = self.selectCellBlock();
        cellReuseIdentifier = self.cellReuseIdentifiers[index];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    NSString *methodName = @"setModel:";
    if (self.cellProps != nil && self.cellProps.length != 0) {
        methodName = [NSString stringWithFormat:@"set%@:",[self.cellProps capitalizedString]];
    }
    if (self.cellForRow == nil && [cell respondsToSelector:NSSelectorFromString(methodName)]) { //查看cell是否有model属性，有则赋予值
        [cell setValue:model forKey:@"model"];
    }
    if (self.cellForRow) {
        self.cellForRow(cell,model,indexPath);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = [self getSectionDataSource:indexPath.section][indexPath.row];
    if (self.didSelectRow) {
        self.didSelectRow(model,indexPath);
    }
}

#pragma mark -- private
- (NSArray *)getSectionDataSource:(NSInteger)section {
    if (self.sectionCount > 1 && self.tableViewDatas.count == self.sectionCount) { //多个区
        NSArray *sectionDatas = self.tableViewDatas[section];
        return sectionDatas;
    }else{
        return self.tableViewDatas;
    }
}



#pragma mark -- getter&setter
+ (UITableView *)getTableView:(UITableViewStyle)style {
  
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //当没有cell时去掉分界线
    tableView.tableFooterView = [UIView new];
    
    //兼容iOS11以后的系统在Grouped tableView上移
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.tableHeaderView = tableHeaderView;
    
    //为了防止iOS11 sectionHead和sectionFooter 回调方法不执行
    tableView.sectionHeaderHeight = 0.01;
    tableView.sectionFooterHeight = 0.01;
    
    return tableView;
}
- (void)setTableViewDatas:(NSArray *)tableViewDatas {
    _tableViewDatas = tableViewDatas;
    [self.tableView reloadData];
}
@end
