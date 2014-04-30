//
//  LETopBottomLeftRightViewController.m
//  Auto Layout By Example
//
//  Created by Julius Parishy on 4/30/14.
//  Copyright (c) 2014 jp. All rights reserved.
//

#import "LETopBottomLeftRightViewController.h"

@interface LETopBottomLeftRightViewController ()

@property (nonatomic, weak) IBOutlet UIView *parentView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *oneViewWidth;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *oneViewHeight;

@end

@implementation LETopBottomLeftRightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateViewConstraintsForInterfaceOrientation:self.interfaceOrientation];
}

- (void)updateViewConstraintsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect bounds = self.parentView.bounds;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        self.oneViewWidth.constant = CGRectGetWidth(bounds);
        self.oneViewHeight.constant = CGRectGetMidY(bounds);
    }
    else
    {
        self.oneViewWidth.constant = CGRectGetMidX(bounds);
        self.oneViewHeight.constant = CGRectGetHeight(bounds);
    }
}

@end
