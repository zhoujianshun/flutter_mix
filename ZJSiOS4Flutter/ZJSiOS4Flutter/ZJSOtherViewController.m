//
//  ZJSOtherViewController.m
//  ZJSiOS4Flutter
//
//  Created by 周建顺 on 2019/4/1.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSOtherViewController.h"

@interface ZJSOtherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ZJSOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label.text = [NSString stringWithFormat:@"%@", self.parames];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
