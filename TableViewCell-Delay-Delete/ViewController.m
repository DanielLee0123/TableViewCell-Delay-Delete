//
//  ViewController.m
//  TableViewCell-Delay-Delete
//
//  Created by Daniel_Lee on 14-10-31.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"
#import "BaseCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_tmpArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
}

-(void)initData
{
    _dataArr = [[NSMutableArray alloc]init];
    _tmpArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 50; i++) {
        BaseModel *model = [[BaseModel alloc]init];
        model.name = [NSString stringWithFormat:@"%d",i];
        [_dataArr addObject:model];
    }
    _tableview.delegate = self;
    _tableview.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identi = @"Cell";
    BaseCell *cell = [self.tableview dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    [cell bindModel:[_dataArr objectAtIndex:indexPath.row]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
//延时执行删除cell
void RunblockAfterDelay(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay),
                   dispatch_get_main_queue(), block);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"##################%i", _tmpArr.count);
    //第一次添加
    if (_tmpArr.count == 0) {
        [_tmpArr addObject:[NSNumber numberWithInt:indexPath.row]];
        NSLog(@"_tmpArr before %@",_tmpArr);
        [self deleteRowWithIndexPath:indexPath];
    }else{
        //之后添加
        if (![self hasValue:_tmpArr value:indexPath.row]) {
            [_tmpArr addObject:[NSNumber numberWithInt:indexPath.row]];
            [self deleteRowWithIndexPath:indexPath];
        }
    }
}
//检查数组中是否有重复行数
-(BOOL)hasValue:(NSMutableArray *)arr value:(NSInteger)value
{
    NSInteger num = 0;
    for (NSNumber* rowNum in arr) {
        if (![rowNum isEqualToNumber:[NSNumber numberWithInteger:value]]) {
            num++;
        }
    }
    if (num == _tmpArr.count) {
        return NO;
    }
    return YES;
}

-(void)deleteRowWithIndexPath:(NSIndexPath *)indexPath
{
    RunblockAfterDelay(4, ^{
        NSLog(@"阅后即焚----->❤️❤️❤️❤️❤️");
        for (int i = 0;i < _tmpArr.count;i++) {
            NSLog(@"index --- %ld",(long)indexPath.row);
            if ([[_tmpArr objectAtIndex:0] integerValue] < [[_tmpArr objectAtIndex:i] integerValue]) {
                int tmpNum = [[_tmpArr objectAtIndex:i] integerValue]-1;
                [_tmpArr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:tmpNum]];
            }
            NSLog(@"_tmpArr after%@",_tmpArr);
        }
        NSLog(@"delete -- %ld",(long)[[_tmpArr objectAtIndex:0] integerValue]);
        [_dataArr removeObjectAtIndex:[[_tmpArr objectAtIndex:0] integerValue]];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[[_tmpArr objectAtIndex:0]integerValue ] inSection:indexPath.section];
        [_tmpArr removeObjectAtIndex:0];
        [_tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationBottom];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
