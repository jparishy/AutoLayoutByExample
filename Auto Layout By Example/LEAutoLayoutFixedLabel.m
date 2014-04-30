//
//  LEAutoLayoutFixedLabel.m
//  Auto Layout By Example
//
//  Created by Julius Parishy on 4/30/14.
//  Copyright (c) 2014 jp. All rights reserved.
//

#import "LEAutoLayoutFixedLabel.h"

@implementation LEAutoLayoutFixedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicContentSize = [super intrinsicContentSize];
     
    if(self.numberOfLines == 0)
    {
        intrinsicContentSize.height += 1;
    }
    
    intrinsicContentSize.height = ceilf(intrinsicContentSize.height);
     
    return intrinsicContentSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
}


@end
