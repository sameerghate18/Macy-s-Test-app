//
//  SecondViewController.h
//  Macys_TestApp
//
//  Created by Sameer Ghate on 03/02/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, readonly) NSInteger callCount;
@property (nonatomic, weak) IBOutlet UILabel *labelCounter;

+ (instancetype)sharedInstance;
- (IBAction)pop:(id)sender;
@end
