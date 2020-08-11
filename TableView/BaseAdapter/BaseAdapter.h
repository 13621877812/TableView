//
//  BaseAdapter.h
//  TableView
//
//  Created by Eden on 2020/8/10.
//  Copyright © 2020 Eden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>

typedef void(^CellForRowBlock)(id cell, id model, NSIndexPath *indexPath);

typedef void(^DidSelectRowBlock)(id model, NSIndexPath *indexPath);




typedef BaseAdapter *_Nonnull(^FrameBlock)(CGRect frame);

typedef BaseAdapter *_Nonnull(^ParentViewBlock)(UIView *parentView);


typedef BaseAdapter *_Nonnull(^SectionCountBlock)(NSInteger sectionCount);

typedef BaseAdapter *_Nonnull(^RowHeightBlock)(CGFloat rowHeight);

typedef BaseAdapter *_Nonnull(^CellSeparatorStyleBlock)(UITableViewCellSeparatorStyle separatorStyle);

typedef BaseAdapter *_Nonnull(^DatasBlock)(NSArray *datas);

typedef BaseAdapter *_Nonnull(^CellPropertyBlock)(NSString *cellProperty);


typedef BaseAdapter *_Nonnull(^SetCellForRowBlock)(CellForRowBlock cellForRow);

typedef BaseAdapter *_Nonnull(^SetDidSelectRowBlock)(DidSelectRowBlock didSelectRow);





+ (BaseAdapter *)adapterWithCellClass:(Class)cellClass style:(UITableViewStyle)style;


//链式设置属性

//用链式调用创建适配器(用属性的方式，block会联想，方便使用)
+ (BaseAdapter *_Nonnull(^)(Class cellClass))adapter;

+ (BaseAdapter *_Nonnull(^)(NSString *cellClassName))adapterWithCellName;


//不建议使用
+ (BaseAdapter *_Nonnull(^)(UITableView *tableView,Class cellClass))adapterWithTableView;


//设置tableView大小 默认是 CGRectZero
@property (nonatomic, copy, readonly) FrameBlock frame;



//设置tableView父View
@property (nonatomic, copy, readonly) ParentViewBlock parentView;

//设置分界线 默认不显示
@property (nonatomic, assign, readonly) CellSeparatorStyleBlock separatorStyle;

//设置tableView rowHeight
@property (nonatomic, assign, readonly) RowHeightBlock rowHeight;

//设置数据源
@property (nonatomic, copy, readonly) SectionCountBlock count;

//会自动触发刷新tableView
@property (nonatomic, copy, readonly) DatasBlock datas;

//用于自动给cell传值，如果cellForRow设置过 或 调用setCellForRow,则此设置无效
//如果不设置默认为 model
@property (nonatomic, copy, readonly) CellPropertyBlock cellProperty;

//设置cellForRow回调
@property (nonatomic, copy, readonly) SetCellForRowBlock setCellForRow;

//设置点击cell回调
@property (nonatomic, copy, readonly) SetDidSelectRowBlock setDidSelectRow;




//cell标识符为 eden_类名
@property (nonatomic, copy, readonly) NSString *cellReuseIdentifier;

//tableView
@property (nonatomic, strong, readonly) UITableView *tableView;


//数据源 ---- section 个数 默认为1
@property (nonatomic, assign) NSInteger sectionCount;

//会自动触发刷新tableView
@property (nonatomic, strong) NSArray *tableViewDatas;


//cellforrow
@property (nonatomic, copy) CellForRowBlock cellForRow;

//cellforrow
@property (nonatomic, copy) DidSelectRowBlock didSelectRow;


//刷新页面 不建议使用
- (void)reloadData;

//刷新指定列表
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end

NS_ASSUME_NONNULL_END
