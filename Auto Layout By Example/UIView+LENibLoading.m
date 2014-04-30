//
//  UIView+LENibLoading.m
//  Auto Layout By Example
//
//  Created by Julius Parishy on 4/30/14.
//  Copyright (c) 2014 jp. All rights reserved.
//

#import "UIView+LENibLoading.h"

#import <objc/runtime.h>

static void *FTLoadFromNibAlreadyLoadedKey = &FTLoadFromNibAlreadyLoadedKey;

@implementation UIView (LENibLoading)

- (void)ft_setAlreadyLoadedFromNib
{
    objc_setAssociatedObject(self, FTLoadFromNibAlreadyLoadedKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ft_alreadyLoadedFromNib
{
    NSNumber *loaded = objc_getAssociatedObject(self, FTLoadFromNibAlreadyLoadedKey);
    return (loaded != nil);
}

- (void)ft_loadFromNib
{
    [self ft_loadFromNibWithNibName:nil bundle:nil];
}

- (void)ft_loadFromNibWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    if(![self ft_alreadyLoadedFromNib])
    {
        NSString *nibName = name ?: NSStringFromClass([self class]);
        NSBundle *nibBundle = bundle ?: [NSBundle mainBundle];
        
        NSArray *views = [nibBundle loadNibNamed:nibName owner:self options:nil];
        NSAssert(views.count == 1, @"The xib must have a single root view.");
        
        UIView *view = views[0];
        
        if(self.translatesAutoresizingMaskIntoConstraints == NO)
        {
            NSArray *constraints = [view.constraints copy];
            
            [self copySubviewsFromView:view toView:self];
            [self copyLayoutConstraints:constraints fromView:view toView:self];
        }
        else
        {
            [self copySubviewsFromView:view toView:self];
        }
        
        [self ft_setAlreadyLoadedFromNib];
    }
}

- (void)copySubviewsFromView:(UIView *)sourceView toView:(UIView *)destinationView
{
    for(UIView *subview in sourceView.subviews)
    {
        [subview removeFromSuperview];
        [destinationView addSubview:subview];
    }
}

- (void)copyLayoutConstraints:(NSArray *)constraints fromView:(UIView *)originalView toView:(UIView *)destinationView
{
    for(NSLayoutConstraint *originalConstraint in constraints)
    {
        id firstItem = (originalConstraint.firstItem == originalView) ? self : originalConstraint.firstItem;
        id secondItem = (originalConstraint.secondItem == originalView) ? self : originalConstraint.secondItem;
                
        NSLayoutAttribute firstAttribute = originalConstraint.firstAttribute;
        NSLayoutAttribute secondAttribute = originalConstraint.secondAttribute;
        
        NSLayoutRelation relation = originalConstraint.relation;
        
        CGFloat multipler = originalConstraint.multiplier;
        CGFloat constant = originalConstraint.constant;
        
        NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multipler constant:constant];
        [destinationView addConstraint:newConstraint];
    }
}

@end