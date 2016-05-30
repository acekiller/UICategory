//
//  ViewController.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+YMRichText.h"
#import "YMRTPattern.h"
#import "NSString+YMRTPattern.h"
#import "UITextView+YMRichText.h"
#import "YMLabel.h"
#import "YMAtPattern.h"

@interface ViewController ()
<
    YMLabelDelegate
>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testCustomerLabel];
    
    [self testRichTextLabel];
    
//    [self testRichTextView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testCustomerLabel
{
    YMLabel *label = [[YMLabel alloc] initWithFrame:CGRectMake(10.f, 20.f, self.view.frame.size.width - 20.f, self.view.frame.size.height - 40.f)];
    [label addPattern:[[YMAtPattern alloc] init]];
    label.delegate = self;
    [self.view addSubview:label];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.backgroundColor = [UIColor yellowColor];
    label.cornerRadius = 3.f;
    label.lineFragmentPadding = 5.f;
    label.font = [UIFont systemFontOfSize:15.f];
    
    label.text = @"[@百度]很久很久以前[emoji_01]，在一个群里，生活着[@腾讯]这样的居民，后来，一个[emoji_01]叫做[@谷歌]的人入侵了这个村庄，他的同伙[@脸书]让整个群里变得淫荡无比。从此[emoji_01]，迎来了污妖王的时代。污妖王，我当定了！";
    
    label.textContainerInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    [label sizeToFit];
}

- (void) testRichTextLabel
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 20.f, self.view.frame.size.width - 20.f, self.view.frame.size.height - 20.f)];
    [t setUserInteractionEnabled:YES];
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
    t.font = [UIFont systemFontOfSize:15.f];
    [t addPattern:[[YMEmojPattern alloc] init]];
    [t addPattern:[[YMImagePattern alloc] init]];
    [t addPattern:[[YMTelPattern alloc] init]];
    [t addPattern:[[YMURLPattern alloc] init]];
    
    t.text = @"测试[emoji_00],欢迎。[emoji_01],测试内容<image name:emoji_02 width:150 height:150>,哈哈[emoji_03],难啊。你猜猜，我猜猜，大家都不知道，这是怎么回事儿。那该咋办呢？3.2遗留：一个孩子的家长可以相互看到手机号。028-64566560。0817-8347866，0828-84343232。http://baidu.com/ats/user?acc=1iafas&txt=aadf%2E 好吗?";
    t.textContentEdgeInsets = UIEdgeInsetsMake(ediSize, ediSize, ediSize, ediSize);
    [t setUserInteractionEnabled:YES];
    [t sizeToFit];
}

- (void) testRichTextView
{
    UITextView *rt = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 20.f, self.view.frame.size.width - 20.f, self.view.frame.size.height - 40.f)];
    rt.backgroundColor = [UIColor redColor];
    [rt addPattern:[[YMEmojPattern alloc] init]];
    [rt addPattern:[[YMImagePattern alloc] init]];
    [rt addPattern:[[YMTelPattern alloc] init]];
    [rt addPattern:[[YMURLPattern alloc] init]];
//    rt.text = @"学习";
    [self.view addSubview:rt];
    rt.text = @"测试[emoji_00],欢迎。[emoji_01],测试内容<image name:emoji_02 width:200 height:200>,哈哈[emoji_03],难啊。你猜猜，我猜猜，大家都不知道，这是怎么回事儿。那该咋办呢？3.2遗留：一个孩子的家长可以相互看到手机号。028-64566560。0817-8347866，0828-84343232。http://baidu.com/ats/user?acc=1iafas&txt=aadf%2E 好吗?";
    
    [rt addImage:[UIImage imageNamed:@"emoj_s_pressed"]];
    
    [rt sizeToFit];
}

- (void)ymLabel:(YMLabel *)label shouldInteractWithStringAttributes:(NSDictionary *)attributes inRange:(NSRange)characterRange
{
    NSLog(@"%s : %@",__PRETTY_FUNCTION__,attributes);
}

- (void) ymLabel:(YMLabel *)label shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange attributes:(NSDictionary *)attributes
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
