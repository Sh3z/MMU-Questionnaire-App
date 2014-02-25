//
//  iPadUsabilityQuestionViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionViewController.h"

/**
 * Represents the view-controller providing the controller logic for the
 * iPad usability question.
 */
@interface iPadUsabilityQuestionViewController : QuestionViewController

/// Contains a reference to the difficulty slider. Lower values imply easier use.
@property (weak, nonatomic) IBOutlet UISlider *difficultySlider;

/**
 * Contains a reference to the collection of buttons allowing a quick choice of difficulty rating.
 * These buttons should be tagged between 0 and 4.
 */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *difficultyButtons;

/// Contains a reference to the label displaying the approximate diffculty the user has specified
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;

@end
