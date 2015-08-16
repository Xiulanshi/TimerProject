//
//  ViewController.m
//  reactionTimer
//
//  Created by Xiulan Shi on 8/15/15.
//  Copyright (c) 2015 Xiulan Shi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *reactionButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (nonatomic) NSDate *previousDate;
@property (nonatomic) NSTimer *timer;

@property (nonatomic) CGFloat bestTime;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView.layer.cornerRadius = 100;
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Reaction Timer";
    self.timeLabel.text = @" ";
    self.textLabel.hidden = YES;
    self.endButton.hidden = YES;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}
- (IBAction)buttonTapped:(id)sender {
    self.redView.backgroundColor = [UIColor redColor];
    if (self.redView.hidden) {
        self.redView.hidden = NO;
        self.startButton.hidden = YES;
        self.textLabel.hidden = YES;
    
        
#define ARC4RANDOM_MAX 0x100000000
        
        float range = 2 - 0.5;
        float val = ((float)arc4random() / ARC4RANDOM_MAX) * range + 0.5;
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:val target:self selector:@selector(timerChangedColor:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    } else {
        self.redView.hidden = YES;
        self.startButton.hidden = NO;
        self.textLabel.hidden = YES;
    }
    
}

- (void)timerFired:(NSTimer *) timer{
    
    
}

- (void)timerChangedColor:(NSTimer *) timer{
    self.redView.backgroundColor = [UIColor greenColor];
    self.previousDate = [NSDate date];
    self.reactionButton.hidden = NO;
    self.timeLabel.hidden = NO;
    self.timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(timerReaction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

}

- (void)timerReaction:(NSTimer *) timer{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeEllapsed = [currentDate timeIntervalSinceDate:self.previousDate];
    NSLog(@"%f", timeEllapsed);
    NSLog(@"here");
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f", timeEllapsed];

    
}

- (IBAction)button2Tapped:(id)sender {
    if (self.redView.backgroundColor == [UIColor greenColor]) {
    
    [self.timer invalidate];
    if (self.textLabel) {
        self.textLabel.hidden = NO;
        self.redView.hidden = YES;
        self.startButton.hidden = NO;
        self.timeLabel.hidden = NO;
        self.endButton.hidden = NO;
        
    }
    }
    
    CGFloat currentTime = [self.timeLabel.text floatValue];
    if (currentTime < self.bestTime || !self.bestTime) {
        self.bestTime = currentTime;
      //  NSLog(@"%.2f", self.bestTime);
        self.textLabel.text = (@"Your best reaction time is:");

    }
    else if (currentTime > self.bestTime) {
        self.textLabel.text = (@"Your reaction time is:");
                              
    }
    

}
- (IBAction)endButtonTapped:(id)sender {
        self.textLabel.hidden = NO;
        self.redView.hidden = YES;
        self.startButton.hidden = YES;
        self.timeLabel.hidden = NO;
        self.endButton.hidden = YES;
    self.textLabel.text = (@"Your BEST time is:");
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f", self.bestTime];

    

}


@end
