//
//  QuestionViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QuestionViewController

#pragma mark - Overridden Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	for(UIButton* button in questionButtons)
	{
		[self customiseButton:button];
		[button addTarget:self action:@selector(responsePressed:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// If we're segue'ing to another question, give it our builder.
	if([[segue destinationViewController] isKindOfClass:[QuestionViewController class]])
	{
		[[segue destinationViewController] setBuilder:[self builder]];
		[[segue destinationViewController] setQuestionnaireDelegate:[self questionnaireDelegate]];
	}
}

#pragma mark - QuestionViewController Implementation

@synthesize questionButtons, builder, questionnaireDelegate;

- (NSString*)question
{
	// This should be overriden by base classes.
	return @"";
}

- (void)customiseButton:(UIButton *)button
{
	[[button layer] setBorderWidth:1.0f];
	[[button layer] setBorderColor:[UIColor grayColor].CGColor];
	button.titleLabel.numberOfLines = 2;
}

- (void)responsePressed:(UIButton*)button
{
	// We do nothing here, but this allows base classes to go ahead and segue.
}

@end
