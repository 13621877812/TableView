//
//  People.h
//  TableView
//
//  Created by fpm0259 on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject

//名字
@property (nonatomic, copy) NSString *name;

//年龄
@property (nonatomic, assign) NSInteger age;

//喜好
@property (nonatomic, copy) NSString *hobby;

@end

NS_ASSUME_NONNULL_END
