//
//  ViewController.h
//  Macys_TestApp
//
//  Created by Admin on 03/02/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

- (IBAction)barcodeScanButtonAction:(id)sender;

@end

#pragma mark - TilesCustomCell Declaration

/**
 Custom Tableviewcell class to hold tiles.
 */
@interface TilesCustomCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton *buttonLeftTile, *buttonMiddleTile, *buttonRightTile;

@end