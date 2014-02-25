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
@interface QuestioneeDetailsViewController : QuestionViewController<UITextFieldDelegate>

/// Stores a reference to the forename text field.
@property (weak, nonatomic) IBOutlet UITextField *forenameField;

/// Stores a reference to the surname text field.
@property (weak, nonatomic) IBOutlet UITextField *surnameField;

/// Stores a reference to the DOB picker.
@property (weak, nonatomic) IBOutlet UIDatePicker *dobPicker;

@end
