//
//  QuestionViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireResponseBuilder.h"
#import "QuestionnaireDelegate.h"

/**
 * Represents the controller managing each question page.
 */
@interface QuestionViewController : UIViewController

#pragma mark - Properties

/// Contains the title of the question displayed by the controller.
@property (nonatomic, strong, readonly) NSString* question;

///Contains the set of buttons providing the responses for the question.
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray* questionButtons;

///Contains the builder in use to construct the response.
@property (nonatomic, strong) QuestionnaireResponseBuilder* builder;

/// Stores a reference to the delegate responsible for showing the Questionnaire.
@property (nonatomic, strong) NSObject<QuestionnaireDelegate>* questionnaireDelegate;


#pragma mark - Methods

/**
 * Alters the appearence of the UIButton to a common look.
 * @param button the button to be customised.
 */
- (void)customiseButton:(UIButton*)button;

/**
 * Occurs when one of the buttons have been pressed.
 * @param button the button pressed by the user.
 */
- (void)responsePressed:(UIButton*)button;

@end
