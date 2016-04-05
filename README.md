# half-modal-test
A test project to recreate, evaluate, and illustrate a bug where the navigation pop animation has unexpected behavior.

## The Issue ##

I have a custom modal presentation, where my modal uses a `UIPresentationController` to limit its width to a fraction of the screen's width when `horizontalSizeClass == UIUserInterfaceSizeClassRegular`.

My `UIPresentationController` utilizes its `overrideTraitCollection` property to override the presented controller's `horizontalSizeClass` to a `compact` mode, since these views are within a smaller width.

However, overriding the trait collection seems to introduce a bug, where, when popping a controller within the navigation stack on this "half modal" presentation, the animation sometimes jumps off screen left or right when in landscape.

Example: 

![unexpected-nav-pop-animation](/screenshots/half-modal-nav-pop.gif "Unexpected nav pop animation throws view left (also sometimes to the right)")

## The solution ##

I'd thought this bug was being caused by overriding the trait collection, but it turns out, it was due to my root controller's `supportedInterfaceOrientations` return value.

All of my controllers inherited from this `RootViewController` class which implements code for supported interface orientations as so:
```
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular)
    {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}
```

This was the culprit. Since I'd overridden the "half modally" presented controllers' `horizontalSizeClass` to compact, they were assuming a Portrait-only orientation, and the `UINavigationController` did not know how to respond to being in landscape. Setting a breakpoint in the above method shows the previous method call: `-[UINavigationController _shouldPopFromLandscapeToPortraitOrientation]`, which tipped me off.

Ultimately, changing the `supportedInterfaceOrientations` method to rely on `self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPhone` instead of size classes is the proper fix. I realize that should have been the obvious way to implement it in the first place, but, given Apple's discouragement of using device information and instead only relying on size classes, I hadn't originally done it that way.

