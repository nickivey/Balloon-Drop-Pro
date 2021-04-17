//
//  ViewController.m
//  Ballon Drop
//
//  Created by Nick Ivey on 2/23/14.
//  Copyright (c) 2014 Nick Ivey. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   
       // Configure the view.
    SKView * skView = (SKView *)self.view;

    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    
    
    // Present the scene.
    [skView presentScene:scene];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
