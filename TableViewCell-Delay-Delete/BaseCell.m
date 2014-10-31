//
//  BaseCell.m
//  TableViewCell-Delay-Delete
//
//  Created by Daniel_Lee on 14-10-31.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindModel:(BaseModel *)model
{
    self.textLabel.text = model.name;
}

@end
