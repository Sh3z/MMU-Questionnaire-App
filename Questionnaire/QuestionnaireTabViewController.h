//
//  QuestionnaireTabViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 01/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "QuestionnaireDelegate.h"
#import "AppSettingsDelegate.h"
#import "ResponseMapDelegate.h"

/**
 * Represents the view-controller for the tab providing an overview of response
 * information and provides the ability to begin new questionnaires.
 */
@interface QuestionnaireTabViewController : UIViewController<QuestionnaireDelegate, AppSettingsDelegate, ResponseMapDelegate>

/// Contains a reference to the map view.
@property (weak, nonatomic) IBOutlet MKMapView *map;

/// Contains a reference to the label displaying the total number of responses
@property (weak, nonatomic) IBOutlet UILabel * totalResponsesLabel;

/// Contains a reference to the label displaying the number of responses obtained today
@property (weak, nonatomic) IBOutlet UILabel *todaysResponsesLabel;

/**
 * Occurs when the user has requested the Questionnaire should begin.
 * @param sender the button that caused this call.
 */
- (IBAction)onBeginQuestionnairePressed:(id)sender;

@end
