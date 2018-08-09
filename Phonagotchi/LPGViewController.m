//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UIImageView *appleImage;
@property (nonatomic) BOOL grumpy;
@property (nonatomic) CGRect appleInitialLocation;
@property (nonatomic) UIImageView *nextApple;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.petImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.petImageView.layer setBorderWidth: 2.0];
    
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:-100].active = YES;
    
    self.grumpy = NO;
    self.appleInitialLocation = self.appleImage.frame;
    
    
    
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer*)sender {
    if ((sender.state == UIGestureRecognizerStateChanged && [sender velocityInView:self.petImageView].x > 2500) || [sender velocityInView:self.petImageView].y > 2500){
        self.petImageView.image = [UIImage imageNamed:@"grumpy.png"];
        self.grumpy = YES;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        self.petImageView.image = [UIImage imageNamed:@"default.png"];
    }
}

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer*)sender {
    if (CGRectContainsPoint(self.petImageView.frame, self.appleImage.center)) {
        self.appleImage.frame = CGRectOffset(self.appleImage.frame, 0, 500);

    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.nextApple = [[UIImageView alloc] initWithFrame:self.appleInitialLocation];
            self.nextApple.image = [UIImage imageNamed:@"apple.png"];
            [self.nextApple addGestureRecognizer:sender];
            self.nextApple.userInteractionEnabled = YES;
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            self.appleImage.center = [sender locationInView:self.view];
            [self.view addSubview:self.appleImage];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:1 animations:^{
                self.appleImage.frame = CGRectOffset(self.appleImage.frame, 0, 500);
            }];
            [self.view addSubview:self.nextApple];
        }
        default:
            break;
    }
    
    
    
    
}



@end

