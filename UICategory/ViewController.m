//
//  ViewController.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+ContentEdgetInsets.h"
#import "YMRTPattern.h"
#import "NSString+YMRTPattern.h"
#import "UITextView+RichText.h"

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
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 20.f, self.view.frame.size.width - 20.f, self.view.frame.size.height - 20.f)];
    [self.view addSubview:t];
//    t.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [t addConstraint:[NSLayoutConstraint constraintWithItem:t attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100]];
//    [t addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100]];
    
//    NSLayoutConstraint *layout = [NSLayoutConstraint constraintWithItem:t
//                                                              attribute:NSLayoutAttributeTop
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                              attribute:NSLayoutAttributeTop
//                                                             multiplier:1.f
//                                                               constant:64.f];
//    
//    NSLayoutConstraint *layout1 = [NSLayoutConstraint constraintWithItem:t
//                                                              attribute:NSLayoutAttributeLeading
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                               attribute:NSLayoutAttributeLeading
//                                                             multiplier:1.f
//                                                               constant:10.f];
//    
//    NSLayoutConstraint *layout2 = [NSLayoutConstraint constraintWithItem:t
//                                                              attribute:NSLayoutAttributeTrailing
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                               attribute:NSLayoutAttributeTrailing
//                                                             multiplier:1.f
//                                                               constant:-10.f];
//    
//    NSLayoutConstraint *layout3 = [NSLayoutConstraint constraintWithItem:t
//                                                               attribute:NSLayoutAttributeBottom
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:self.view
//                                                               attribute:NSLayoutAttributeBottom
//                                                              multiplier:1.f
//                                                                constant:-10.f];
    
//    NSLayoutConstraint *layout3 = [NSLayoutConstraint constraintWithItem:t
//                                                               attribute:NSLayoutAttributeHeight
//                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
//                                                                  toItem:nil attribute:NSLayoutAttributeNotAnAttribute
//                                                              multiplier:1.f constant:10.f];
    
//    [self.view addConstraint:layout];
//    [self.view addConstraint:layout1];
//    [self.view addConstraint:layout2];
//    [t addConstraint:layout3];
    
    t.numberOfLines = 0;
    t.lineBreakMode = NSLineBreakByWordWrapping;
    t.backgroundColor = [UIColor redColor];
    CGFloat ediSize = 10.f;
    t.cornerRadius = 5.f;
    
    [t addPattern:[[YMEmojPattern alloc] initWithFont:t.font]];
    [t addPattern:[[YMImagePattern alloc] init]];
    [t addPattern:[[YMTelPattern alloc] init]];
    [t addPattern:[[YMURLPattern alloc] init]];
    
    t.text = @"测试[emoji_00],欢迎。[emoji_01],测试内容<image emoji_02>,哈哈[emoji_03],难啊。你猜猜，我猜猜，大家都不知道，这是怎么回事儿。那该咋办呢？3.2遗留：一个孩子的家长可以相互看到手机号。028-64566560。0817-8347866，0828-84343232。http://baidu.com/ats/user?acc=1iafas&txt=aadf%2E 好吗?";
    t.textContentEdgeInsets = UIEdgeInsetsMake(ediSize, ediSize, ediSize, ediSize);
    [t sizeToFit];
}

- (void) testRichTextView
{
    UITextView *rt = [[UITextView alloc] initWithFrame:CGRectZero];
    rt.backgroundColor = [UIColor redColor];
    rt.text = @"学习";
    [rt addImage:[UIImage imageNamed:@"emoj_s_pressed"]];
    [self.view addSubview:rt];
}

@end
