//
//  CustomCell.m
//  TableView
//
//  Created by fpm0259 on 2020/8/11.
//  Copyright © 2020 Eden. All rights reserved.
//

#import "CustomCell.h"
@interface CustomCell()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *ageLabel;

@property (nonatomic, strong) UILabel *hobbyLabel;

@end


@implementation CustomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.nameLabel = [UILabel new];
    self.nameLabel.frame = CGRectMake(15, 0, 100, 30);
    [self.contentView addSubview:self.nameLabel];
    
    self.ageLabel = [UILabel new];
    self.ageLabel.frame = CGRectMake(230, 0, 100, 30);
    [self.contentView addSubview:self.ageLabel];
    
    
    self.hobbyLabel = [UILabel new];
    self.hobbyLabel.frame = CGRectMake(15, 40, 300, 30);
    [self.contentView addSubview:self.hobbyLabel];
    
    
    
    return self;
}
- (void)setModel:(People *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%ld",model.age];
    self.hobbyLabel.text = model.hobby;
}

- (void)setPeople:(People *)people {
    _people = people;
    self.nameLabel.text = people.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%ld",people.age];
    self.hobbyLabel.text = people.hobby;
    
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
