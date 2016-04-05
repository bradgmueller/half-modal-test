//
//  SecondViewController.m
//  HalfModalTraitTest
//
//  Created by Bradley Mueller on 4/4/16.
//  Copyright © 2016 Cellaflora. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label.text = @"";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:1 alpha:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact)
    {
        self.label.text = @"Horizontal Compact";
    }
    else
    {
        self.label.text = @"Horizontal Regular";
    }
}

@end
