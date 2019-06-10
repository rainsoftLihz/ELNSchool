//
//  PSLoginBaseVC.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSLoginBaseVC.h"

@interface PSLoginBaseVC ()

@end

@implementation PSLoginBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}

-(CGFloat)topSpace
{
    return 527*kHProportion;
}

-(CGFloat)contentSpace
{
    return 527*kHProportion+30+88*kHProportion;
}

-(CGFloat)nextBtnSpace
{
    return 527*kHProportion+30+49+30+88*kHProportion;
}

#pragma mark ---   返回按钮
-(void)configBackItem
{
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(0, 20.0, 100, 44);
    [clearBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"byj_fanhui"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(12.0, 44/2.0-21/2.0, 21, 21);
    backBtn.userInteractionEnabled = NO;
    [clearBtn addSubview:backBtn];
}

-(void)goBack:(UIButton*)senderBtn
{
    [self.view endEditing:YES];
    /* 防止重复点击 */
    senderBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        senderBtn.enabled = YES;
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 大按钮
-(void)configBottomActionBtnWithTitle:(NSString*)title
{
    CGFloat leftSpace = 15;
    CGFloat height = 127/3.0;
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(leftSpace,[self nextBtnSpace], SCREEN_WIDTH-2*leftSpace, height);
    [submitBtn setTitle:title forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    submitBtn.backgroundColor = UIColor.grayColor;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.tag = 1111;
    [submitBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.enabled = NO;
    [self.view addSubview:self.nextBtn = submitBtn];
}

-(void)nextBtnClick
{
    
}

#pragma mark --- title
-(void)configHeaderWith:(NSString*)title
{
    UILabel* titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(0, [self topSpace], SCREEN_WIDTH, 88*kHProportion);
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = UIColor.blackColor;
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
}


-(void)viewWillDisappear:(BOOL)animated{
   [super viewWillDisappear:animated];
   [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
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