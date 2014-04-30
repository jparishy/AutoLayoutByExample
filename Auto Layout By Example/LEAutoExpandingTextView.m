//
//  LEAutoExpandingTextView.m
//  Auto Layout By Example
//
//  Created by Julius Parishy on 4/30/14.
//  Copyright (c) 2014 jp. All rights reserved.
//

#import "LEAutoExpandingTextView.h"

@implementation LEAutoExpandingTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self observeContentSize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self observeContentSize];
}

- (void)dealloc
{
    [self removeContentSizeObserver];
}

- (void)observeContentSize
{
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeContentSizeObserver
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
    [self updateFrameForSize:size];
}

- (void)updateFrameForSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size.height = size.height;
    
    self.frame = frame;
    
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize
{
    return self.contentSize;
}

@end
