//
//  ExtendCell.m
//  TableView
//
//  Created by fpm0259 on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "ExtendCell.h"
@interface ExtendCell()
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hobbyLabel;

@end


@implementation ExtendCell
- (void)setModel:(People *)model {
    _model = model;
    self.ageLabel.text = [NSString stringWithFormat:@"年龄:%ld",model.age];
    self.hobbyLabel.text = [NSString stringWithFormat:@"喜好:%@",model.hobby];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
