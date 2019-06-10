//
//  PSBaseWebController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseWebController.h"
#import <WebKit/WebKit.h>
@interface PSBaseWebController () <WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation PSBaseWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    
    NSString* url1 = @"http://m.51eln.com/html/login.html?coopCode=yunwang";
    NSString* urlString = [NSString stringWithFormat:@"%@?coopCode=%@&frontUserId=%@&accessToken=%@&nickname=%@",url1,self.user.coopCode,self.user.frontUserId,self.user.accessToken,self.user.nickname] ;
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"urlString === %@",urlString);
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
}


- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        configuration.allowsInlineMediaPlayback = YES;
        configuration.mediaTypesRequiringUserActionForPlayback = false;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    }
    return _wkWebView;
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
