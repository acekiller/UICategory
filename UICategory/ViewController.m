//
//  ViewController.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+ContentEdgetInsets.h"
#import "YMRichTextView.h"
#import "YMRTPattern.h"
#import "NSString+YMRTPattern.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testRichTextLabel];
    
//    [self testRichTextView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) testRichTextLabel
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 100.f, 300.f, 10.f)];
    [t addPattern:[[YMEmojPattern alloc] init]];
    
    [self.view addSubview:t];
    t.numberOfLines = 0;
    t.lineBreakMode = NSLineBreakByWordWrapping;
    t.backgroundColor = [UIColor redColor];
    t.preferredMaxLayoutWidth = 300.f;
    CGFloat ediSize = 10.f;
    t.cornerRadius = 5.f;
    t.text = @"测试[emoji_00],欢迎。[emoji_01],测试内容[emoji_02],哈哈[emoji_03],难啊。你猜猜，我猜猜，大家都不知道，这是怎么回事儿。那该咋办呢？3.2遗留：一个孩子的家长可以相互看到手机号。";
    t.textContentEdgeInsets = UIEdgeInsetsMake(ediSize, ediSize, ediSize, ediSize);
    [t sizeToFit];
}

- (void) testRichTextView
{
    YMRichTextView *rt = [[YMRichTextView alloc] initWithFrame:CGRectMake(10.f, 100.f, 300.f, 400.f)];
    rt.backgroundColor = [UIColor redColor];
    rt.text = @"学习";
    [rt addImage:[UIImage imageNamed:@"emoj_s_pressed"]];
    [self.view addSubview:rt];
}

@end
