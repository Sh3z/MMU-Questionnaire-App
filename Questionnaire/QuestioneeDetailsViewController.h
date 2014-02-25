//
//  QuestioneeDetailsViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionViewController.h"

/**
 * Represents the view-controller used to capture basic information from the user.
 */
@interface QuestioneeDetailsViewController : QuestionViewController

/// Stores a reference to the forename text field.
@property (weak, nonatomic) IBOutlet UITextField *identifierField;

/// Stores a reference to the DOB picker.
@property (weak, nonatomic) IBOutlet UIDatePicker *dobPicker;

@end
