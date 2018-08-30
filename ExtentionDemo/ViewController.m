//
//  ViewController.m
//  ExtentionDemo
//
//  Created by Dawn Wang on 2017/7/4.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Position.h"

@interface ViewController ()
{
    ButtonImagePosition _currentPosition;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonDisplay;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.buttonDisplay setTitle:@"titlaa title" forState:UIControlStateNormal];
    [self.buttonDisplay setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.buttonDisplay setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    
    
    self.buttonDisplay.layer.borderColor = [[UIColor greenColor] CGColor];
    self.buttonDisplay.layer.borderWidth = 1;
    
    self.buttonDisplay.imageView.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.buttonDisplay.imageView.layer.borderWidth = 1;
    
    self.buttonDisplay.titleLabel.layer.borderColor = [[UIColor blueColor] CGColor];
    self.buttonDisplay.titleLabel.layer.borderWidth = 1;
    [self.buttonDisplay setImagePosition:_currentPosition];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)VModel:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger selectIndex = segment.selectedSegmentIndex;
    self.buttonDisplay.contentVerticalAlignment = selectIndex;
    [self.buttonDisplay setImagePosition:_currentPosition];

}

- (IBAction)HModel:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger selectIndex = segment.selectedSegmentIndex;
    self.buttonDisplay.contentHorizontalAlignment = selectIndex;
    [self.buttonDisplay setImagePosition:_currentPosition];

}
- (IBAction)imagePositionModel:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger selectIndex = segment.selectedSegmentIndex;
    _currentPosition = (ButtonImagePosition)selectIndex;
    [self.buttonDisplay setImagePosition:(ButtonImagePosition)selectIndex];

}

@end
