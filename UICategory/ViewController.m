//
//  ViewController.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+ContentEdgetInsets.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testRichTextLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) testRichTextLabel
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 100.f, 300.f, 10.f)];
    [self.view addSubview:t];
    t.numberOfLines = 0;
    t.lineBreakMode = NSLineBreakByWordWrapping;
    t.backgroundColor = [UIColor redColor];
    t.preferredMaxLayoutWidth = 300.f;
    CGFloat ediSize = 10.f;
    t.text = @"debug时打出的backtrace，其中掺杂着被swizzle的方法名，一团糟啊！上面介绍的swizzle方案，使backtrace中打印出的方法名还是很清晰的。但仍然很难去debug，因为很难记住swizzling影响过什么。给你的代码写好文档（即使只有你一个人会看到）。养成一个好习惯，不会比调试多线程问题还难的。";
    t.textContentEdgeInsets = UIEdgeInsetsMake(ediSize, ediSize, ediSize, ediSize);
    [t sizeToFit];
}

@end
