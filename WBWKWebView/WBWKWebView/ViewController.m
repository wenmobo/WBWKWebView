//
//  ViewController.m
//  WBWKWebView
//
//  Created by Mr_Lucky on 2018/8/28.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebView+WBAdditional.h"
#import "WKWebView+WBMetaParser.h"
#import "WKWebView+WBJavaScript.h"

@interface ViewController () <WKNavigationDelegate>
{
    WKWebView *_wkWebView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initWKWebView];
}

- (void)initWKWebView {
    _wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];

    /*  < 设置代理 > */
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    /*  < 开启前进后退滑动手势 > */
    [_wkWebView wb_allowsBackForwardNavigationGestures];
    
    [self.view addSubview:_wkWebView];
    
    NSURL *url = [NSURL URLWithString:@"http://m.jmw.com.cn/zhanhui/zh_active_page.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wkWebView loadRequest:request];
}

// MARK:WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    // !!!:获取网页所有元素
    [webView wb_getMetaData:^(id metaData) {
        NSLog(@"网页元素 = %@",metaData);
    }];
    
    // !!!:获取某个节点个数
    [webView wb_nodeCountOfTag:@"img"
              completedHandler:^(int tagCount) {
                  NSLog(@"节点个数 = %d",tagCount);
              }];
    
    // !!!:获取当前页地址
    [webView wb_getCurrentURL:^(NSString *url) {
        NSLog(@"当前地址 = %@",url);
    }];
    
    // !!!:当前标题
    [webView wb_getCurrentTitle:^(NSString *title) {
        NSLog(@"当前标题 = %@",title);
    }];
    
    // !!!:获取网页中的图片
    [webView wb_getImages:^(NSArray *images) {
        NSLog(@"所有图片 = %@",images);
    }];
    
    [webView wb_chnageFontSize:30];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
