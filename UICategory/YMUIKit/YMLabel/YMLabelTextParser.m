//
//  YMLabelTextParser.m
//  TestDemo
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMLabelTextParser.h"
#import <CoreText/CoreText.h>

void RunDelegateDeallocCallback(void * refCon)
{
}

CGFloat RunDelegateGetAscentCallback(void * refCon)
{
    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return attachement.image.size.height;
}
CGFloat RunDelegateGetDescentCallback(void * refCon)
{
    //    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return 0;
}
CGFloat RunDelegateGetWidthCallback(void * refCon)
{
    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return attachement.image.size.width;
}

@interface YMLabelTextParser ()
@property (nonatomic, strong) NSMutableDictionary *textTouchMapper;
@end

@implementation YMLabelTextParser
{
    NSMutableArray *defaultPatterns;
}

- (instancetype) initWithParsers:(YMLabelTextParserDefaultPatternType)type
{
    self = [super init];
    if (self) {
        defaultPatterns = [[NSMutableArray alloc] init];
        self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [self loadDefaultParsers:type];
        _textTouchMapper = [[NSMutableDictionary alloc] init];
        self.textColor = [UIColor blackColor];
    }
    return self;
}

- (instancetype) init
{
    return [self initWithParsers:YMLabelTextParserNone];
}

- (void) loadDefaultParsers:(YMLabelTextParserDefaultPatternType)type
{
}

- (void) addParserPattern:(id)pattern
{
    if (pattern == nil) {
        return;
    }
    [defaultPatterns addObject:pattern];
}

- (void) removeParserPattern:(id)pattern
{
    if (pattern == nil) {
        return;
    }
    [defaultPatterns removeObject:pattern];
}

- (void) removeAllParserPattern
{
    [defaultPatterns removeAllObjects];
}

- (NSAttributedString *)parserText:(NSString *)text
{
    return [self parserText:text withParserPatterns:defaultPatterns];
}

- (NSAttributedString *)parserText:(NSString *)text withParserPatterns:(NSArray *)patterns
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName : self.textColor,
                                 NSFontAttributeName : self.font,
                                 NSParagraphStyleAttributeName : self.paragraphStyle
                                 };
    
    NSMutableAttributedString * content = [[NSMutableAttributedString alloc] initWithString:text
                                                                                 attributes:attributes];
    
    for (NSString * emojiText in self.emojiTextMapper) {
        NSRange range = [content.string rangeOfString: emojiText];
        while (range.location != NSNotFound) {
            [content replaceCharactersInRange:range withAttributedString:[self attachementAttributeString:self.emojiTextMapper[emojiText]]];
            
            range = [content.string rangeOfString: emojiText];
        }
    }
    
    for (NSString *hyperlinkText in self.hyperlinkMapper) {
        NSRange range = [content.string rangeOfString:hyperlinkText];
        [self.textTouchMapper setValue: self.hyperlinkMapper[hyperlinkText] forKey: NSStringFromRange(range)];
        [content replaceCharactersInRange:range withAttributedString:[self linkString:hyperlinkText]];
    }
    
    return content;
}

- (NSAttributedString *)linkString:(NSString *)string
{
    NSAttributedString *link = [[NSAttributedString alloc] initWithString:string
                                                               attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                                                            NSForegroundColorAttributeName : [UIColor blueColor],
                                                                            NSParagraphStyleAttributeName : self.paragraphStyle,
                                                                            }];
    return link;
}

- (NSAttributedString *)attachementAttributeString:(NSString *)imageName
{
    NSTextAttachment *attachement = [[NSTextAttachment alloc] init];
    attachement.image = [UIImage imageNamed:imageName];
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)attachement);
    //插入空白表情占位符
    NSDictionary *attributes = @{(NSString *)kCTRunDelegateAttributeName : (__bridge id)runDelegate,
                                 @"NSAttachement" : attachement,
                                 NSParagraphStyleAttributeName : self.paragraphStyle,
                                 };
    
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString: @" " attributes:attributes];
    
    CFRelease(runDelegate);
    
    return attrString;
}

@end
