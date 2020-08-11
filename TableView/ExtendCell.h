//
//  ExtendCell.h
//  TableView
//
//  Created by fpm0259 on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExtendCell : UITableViewCell

@property (nonatomic, strong) People *model;
@end

NS_ASSUME_NONNULL_END
