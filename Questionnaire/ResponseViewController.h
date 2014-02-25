//
//  ResponseViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 01/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "QuestionnaireResponseTableViewController.h"
#import "QuestionnaireResponse.h"

/// Represents the view-controller used to display a single response.
@interface ResponseViewController : UIViewController

/// Gets or sets the response to be displayed.
@property (nonatomic, strong) QuestionnaireResponse* response;

/// Contains a reference to the view-controller presenting the information within the response.
@property (nonatomic, strong) QuestionnaireResponseTableViewController* responsesViewController;

/// Contains a reference to the map view used to display the location of the response
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
