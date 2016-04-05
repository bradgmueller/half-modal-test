//
//  PresentationController.m
//  HalfModalTraitTest
//
//  Created by Bradley Mueller on 4/4/16.
//  Copyright © 2016 Cellaflora. All rights reserved.
//

#import "PresentationController.h"

@implementation PresentationController

#pragma mark - Layout

- (CGRect)frameOfPresentedViewInContainerView
{
    if (self.presentedViewController.presentingViewController.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact)
    {
        return self.containerView.bounds;
    }
    else
    {
        CGRect bounds = self.containerView.bounds;
        CGFloat width = bounds.size.width / 2.0;
        CGFloat originX = bounds.size.width / 2.0;
        return CGRectMake(originX, 0, width, bounds.size.height);
    }
}

#pragma mark - Presentations

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
    
    [self.containerView addSubview:self.backgroundView];
    self.backgroundView.frame = self.containerView.bounds;
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        self.backgroundView.alpha = 0.3;
        
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    [super presentationTransitionDidEnd:completed];
    
    if (completed == NO)
    {
        [self.backgroundView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        self.backgroundView.alpha = 0;
        
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        [self.backgroundView removeFromSuperview];
    }
    else
    {
        self.backgroundView.alpha = 0.3;
    }
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    CGRect frame = [self frameOfPresentedViewInContainerView];
    if (CGRectEqualToRect(self.presentedViewController.view.frame, frame) == NO)
    {
        self.presentedViewController.view.frame = frame;
    }
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _backgroundView.userInteractionEnabled = YES;
        
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)]];
    }
    return _backgroundView;
}

- (void)backgroundTapped:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
