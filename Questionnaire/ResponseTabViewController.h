//
//  ResponseViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import "ResponseViewController.h"
#import "QuestionnaireResponse.h"
#import "ResponsesDelegate.h"

/// Represents the view-controller which provides the capability of choosing and selecting
/// an acquired QuestionnaireResponse.
@interface ResponseTabViewController : UIViewController<ResponsesDelegate, MFMailComposeViewControllerDelegate>

/// Contains the response to be displayed.
@property (nonatomic, strong) QuestionnaireResponse* response;

/// Contains a reference to the view-controller controlling the Response view.
@property (nonatomic, strong) ResponseViewController* responseView;

/**
 * Occurs when the user wants to view the available responses.
 * @param sender the object that requested the display.
 */
- (IBAction)showResponsesTapped:(id)sender;

/**
 * Occurs when the user wants to export the currently displayed response.
 * @param sender the object that requested the action.
 */
- (IBAction)exportResponseTapped:(id)sender;


@end
