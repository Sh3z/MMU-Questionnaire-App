//
//  iPadUsabilityQuestionViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "iPadUsabilityQuestionViewController.h"
#import "QuestionResponse+QuestionResponseDifficulty.h"

@implementation iPadUsabilityQuestionViewController

#pragma mark - Overridden Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	for(UIButton* button in difficultyButtons)
	{
		[self customiseButton:button];
		[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	[[self difficultySlider] addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - QuestionViewController Overrides

- (NSString*)question
{
	return @"After using the iPad today, how would you rate its usability?";
}

- (void)responsePressed:(UIButton *)button
{
	[self.builder appendResponse:[NSString stringWithFormat:@"%i%%", (int)( 100 - [difficultySlider value])] forQuestion:[self question]];
	[self performSegueWithIdentifier:@"goToQ3From2b" sender:self];
}


#pragma mark - iPadUsabilityQuestionViewController Implementation

@synthesize difficultySlider, difficultyButtons;

#pragma mark - Additional Methods

/**
 * Handles the press of any button within the collection of difficulty buttons.
 * @param button the button pressed by the user.
 */
- (void)buttonPressed:(UIButton*)button
{
	int tag = button.tag;
	if(tag >=0 && tag <=4)
	{
		float newVal = (float)(tag + 0.5) * 20;
		[difficultySlider setValue:newVal animated:YES];
		[self updateDifficultyLabel:newVal];
	}
}

- (void)sliderValueChanged:(id)sender
{
	UISlider* slider = (UISlider*)sender;
	[self updateDifficultyLabel:slider.value];
}

- (void)updateDifficultyLabel:(float)value
{
	[[self difficultyLabel] setText:[QuestionResponse percentageDifficultyToString:value]];
}

@end
