//
//  PSPhoneController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSPhoneController.h"
#import "PSCodeVController.h"
#import "PSLoginBaseView.h"
#import "PSMessageController.h"
@interface PSPhoneController ()

@end

@implementation PSPhoneController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self configHeaderWith:@"请输入您的手机号"];
    [self configBottomActionBtnWithTitle:@"下一步"];
    
    WeakSelf;
    PSLoginBaseView* phoneView = [[PSLoginBaseView alloc] initWithFrame:CGRectMake(0, [self contentSpace], KScreenWidth, 49.0) andIcon:@"Phone" andPlacehold:@"请输入手机号" andBlock:^(NSString * phoneStr) {
        
        [PSLoginManager manager].mobile = phoneStr;
        
        if ([Utils validateMobile:phoneStr]){
            wkSelf.nextBtn.enabled = YES;
            wkSelf.nextBtn.backgroundColor = UIColor.redColor;
        }else {
            wkSelf.nextBtn.enabled = NO;
            wkSelf.nextBtn.backgroundColor = UIColor.grayColor;
        }
    }];
    [self.view addSubview:phoneView];
  
}


-(void)nextBtnClick{
    [self.view endEditing:YES];
    NSString* md5Str = [NSString stringWithFormat:@"%@%@",[PSLoginManager manager].mobile,MD5_SCRECT_CODE];
    NSDictionary* params = @{@"mobile":[PSLoginManager manager].mobile,
                             @"verifyCode":[Utils md5:md5Str]};
  
    [PSLoginAPI getMessageCodeWith:params Success:^(NSURLSessionDataTask *task, PSRsponse* response) {
     
        if ([response.ret isEqualToString:@"-1"] && [response.err_code isEqualToString:@"9992"]) {
            //未注册并没有邀请码 跳转到邀请码
            [self presentViewController:[PSCodeVController new] animated:YES completion:nil];
        }else {
            //获取验证码
            NSString* coopCode = response.data[@"coopCode"];
            if ([Utils isBlankString:coopCode]) {
                [SVProgressHUD showErrorWithStatus:@"coopCode返回为空"];
            }else {
                [PSLoginManager manager].coopCode = coopCode;
                [self presentViewController:[PSMessageController new] animated:YES completion:nil];
            }
        }
        
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
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
