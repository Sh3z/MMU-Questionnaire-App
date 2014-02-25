//
//  QuestionnaireResponseTableViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireResponse.h"

/// Represents the view-controller used to present the information from a QuestionnaireResponse.
@interface QuestionnaireResponseTableViewController : UITableViewController

/// Contains the QuestionnaireResponse to be displayed.
@property (nonatomic, strong) QuestionnaireResponse* questionnaireResponse;

@end
