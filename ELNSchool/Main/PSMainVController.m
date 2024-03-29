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
#import "LHZPlayerManger.h"
#import "LHZDownLoader.h"
#import "LHZDownLoaderManager.h"
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
    url = @"http://audio.xmcdn.com/group57/M07/46/20/wKgLgVyd4_XDkM4XACOEyCgoA9A564.m4a";
    url = @"http://audio.xmcdn.com/group56/M06/62/D0/wKgLdlyfVwSyvtCcAJ4UntDw2vs694.m4a";
    
    [[LHZPlayerManger manger] playWithUrlstr:url isCache:YES];
    
//    LHZDownLoader* downLoader = [[LHZDownLoader alloc] init];
//    [downLoader downLoadWithURL:[NSURL URLWithString:url] downLoadInfo:^(long long fileSize) {
//        NSLog(@"fileSize--->%ld M",fileSize/1024);
//    } success:^(NSString * _Nonnull cacheFilePath) {
//        NSLog(@"cacheFilePath--->%@",cacheFilePath);
//    } failed:^{
//
//    }];
    
    [[LHZDownLoaderManager manger] downLoadWithURL:[NSURL URLWithString:url] downLoadInfo:^(long long fileSize) {
        NSLog(@"fileSize--->%lld M",(fileSize/1024)/2014);
    } success:^(NSString * _Nonnull cacheFilePath) {
        NSLog(@"cacheFilePath--->%@",cacheFilePath);
    } failed:^{
        
    }];
    
    [PSHomeAPI getHomeDataSuccess:^(NSURLSessionDataTask *task, id response) {
        PSRsponse* res = (PSRsponse*)response;
        PSHomeModel* model = res.data;
        [self.headerView setUpUIwiht:model];
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PSPlayerState state = [LHZPlayerManger manger].state;
    if (state == PSPlayerStatePlaying) {
        [[LHZPlayerManger manger] pause];
    }else {
        [[LHZPlayerManger manger] resume];
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
