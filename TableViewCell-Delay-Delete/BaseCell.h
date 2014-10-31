//
//  BaseCell.h
//  TableViewCell-Delay-Delete
//
//  Created by Daniel_Lee on 14-10-31.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface BaseCell : UITableViewCell
- (void)bindModel:(BaseModel *)model;
@end
