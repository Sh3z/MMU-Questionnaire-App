//
//  SettingsTableViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettingsDelegate.h"

/// Represents the view-controller used to manage the settings of the application.
@interface SettingsTableViewController : UITableViewController

/// Contains a reference to the delegate.
@property (nonatomic, strong) NSObject<AppSettingsDelegate>* delegate;


/// Occurs when the user is done changing their settings.
- (IBAction)donePressed:(id)sender;

@end
