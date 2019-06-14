//
//  PSMainVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSMainVController.h"
#import "PSHomeModel.h"
#import "PSHomeAPI.h"
#import "PSHomeHeaderView.h"
#import "PSPlayerManger.h"
@interface PSMainVController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)PSHomeHeaderView* headerView;
@end

@implementation PSMainVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:self.tableView];
    
    _headerView = [[PSHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Adapt_scaleV(250))];
    //_headerView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.tableHeaderView = _headerView;
    _headerView.block = ^{
        
    
    };
    
    [self reqData];
}



-(void)reqData{
    
    NSString* url = @"http://audio.xmcdn.com/group55/M02/90/AA/wKgLf1yUdIzDELWBAGIa3y_-DnM545.m4a";
    
    [[PSPlayerManger manger] playWithUrlstr:url isCache:NO];
    
    [PSHomeAPI getHomeDataSuccess:^(NSURLSessionDataTask *task, id response) {
        PSRsponse* res = (PSRsponse*)response;
        PSHomeModel* model = res.data;
        [self.headerView setUpUIwiht:model];
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PSPlayerState state = [PSPlayerManger manger].state;
    if (state == PSPlayerStatePlaying) {
        [[PSPlayerManger manger] pause];
    }else {
        [[PSPlayerManger manger] resume];
    }
}


#pragma mark --- table
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
    }
    return _tableView;
}

#pragma mark --- datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
