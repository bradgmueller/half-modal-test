//
//  ViewController.m
//  HalfModalTraitTest
//
//  Created by Bradley Mueller on 4/4/16.
//  Copyright © 2016 Cellaflora. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "PresentationController.h"

@interface ViewController ()
<
UIViewControllerTransitioningDelegate
>

@end

@implementation ViewController

- (IBAction)presentModal:(id)sender
{
    ModalViewController *modal = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModalViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:modal];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    PresentationController *controller = [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    controller.overrideTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    
    return controller;
}

@end
