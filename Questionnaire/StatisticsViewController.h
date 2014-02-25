//
//  StatisticsViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticsViewDataSourceDelegate.h"

/// Represents the view-controller displaying the statistics of all responses
@interface StatisticsViewController : UIViewController

/// Contains th object which provides the data displayed within the view.
@property (strong, nonatomic) id<StatisticsViewDataSourceDelegate> dataSource;

/// Contains a reference to the label displaying how many respondants have replied so far.
@property (weak, nonatomic) IBOutlet UILabel *totalRespondantsLabel;

/// Contains a reference to the label detailing the percentage of respondants who ha used an iPad before
@property (weak, nonatomic) IBOutlet UILabel *usedBeforeLabel;

/// Contains a reference to the label detailing the percentage of respondants who would use an iPad again
@property (weak, nonatomic) IBOutlet UILabel *wouldUseAgainLabel;

/// Contains a refence to the label detailing the percentage of respondants who had trouble using the iPad, but would use it again
@property (weak, nonatomic) IBOutlet UILabel *hadDifficultyButWouldUseAgainLabel;

@end
