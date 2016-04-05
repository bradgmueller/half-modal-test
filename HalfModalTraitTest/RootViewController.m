//
//  RootViewController.m
//  HalfModalTraitTest
//
//  Created by Bradley Mueller on 4/5/16.
//  Copyright © 2016 Cellaflora. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular)
    {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
