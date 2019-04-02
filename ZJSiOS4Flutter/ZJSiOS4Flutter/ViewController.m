//
//  ViewController.m
//  ZJSiOS4Flutter
//
//  Created by 周建顺 on 2019/4/1.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ViewController.h"

#import "ZJSFlutterViewController.h"

#import "ZJSOtherViewController.h"




@interface ViewController ()<FlutterStreamHandler>

@property (nonatomic, strong) FlutterEventSink  eventSink;;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)showFlutterAction:(id)sender {
    ZJSFlutterViewController* flutterViewController = [[ZJSFlutterViewController alloc] init];
    [flutterViewController setInitialRoute:@"main"];
    
    [self flutter_setupMethodChannelWithController:flutterViewController];
    [self flutter_setupEventChannelWithController:flutterViewController];
    [self.navigationController pushViewController:flutterViewController animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.eventSink(@"我是新标题FlutterStreamHandler");
    });
}
- (IBAction)showOtherPageAction:(id)sender {
    
    ZJSFlutterViewController* flutterViewController = [[ZJSFlutterViewController alloc] init];
    [flutterViewController setInitialRoute:@"other"];
    
    [self flutter_setupMethodChannelWithController:flutterViewController];
    
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

// flutter 主动调用 native
-(void)flutter_setupMethodChannelWithController:(FlutterViewController*)flutterViewController{
    
    __weak typeof(self) weakSelf = self;
    // 要与main.dart中一致
    NSString* channelName = @"com.flutter.sample/home";
    FlutterMethodChannel* messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    [messageChannel setMethodCallHandler:^(FlutterMethodCall* _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@",call.method,call.arguments);
        if([call.method isEqualToString:@"flutter_toNativeSomething"]) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"flutter回调"message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
            [alertView show];
            // 回调给flutter
            if(result) {
                result(@1000);
            }
        } else if([call.method isEqualToString:@"flutter_toNativePush"]) {
            ZJSOtherViewController *testVC = [[ZJSOtherViewController alloc] init];
            testVC.parames = call.arguments;
            [weakSelf.navigationController pushViewController:testVC animated:YES];
        } else if([call.method isEqualToString:@"flutter_toNativePop"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            result(@(YES));
        }else if([call.method isEqualToString:@"flutter_toNativeDismiss"]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            result(@(YES));
        }
    }];
}


// native主动
-(void)flutter_setupEventChannelWithController:(FlutterViewController*)flutterViewController{
    
    // 要与main.dart中一致
    NSString *channelName = @"com.flutter.sample/native_post";
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterViewController];
    // 代理
    [evenChannal setStreamHandler:self];
}


#pragma mark - <FlutterStreamHandler>
// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    NSLog(@"arguments:%@", arguments);
    self.eventSink = events;
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"我是标题FlutterStreamHandler");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    return nil;
}

@end
