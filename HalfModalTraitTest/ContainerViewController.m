//
//  ContainerViewController.m
//  HalfModalTraitTest
//
//  Created by Bradley Mueller on 4/4/16.
//  Copyright © 2016 Cellaflora. All rights reserved.
//

#import "ContainerViewController.h"
#import "ViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTranslucent:NO];
}

- (IBAction)presentChild:(id)sender
{
    ViewController *modal = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Child"];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:modal];
    
    [self addChildViewController:controller];
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

@end
