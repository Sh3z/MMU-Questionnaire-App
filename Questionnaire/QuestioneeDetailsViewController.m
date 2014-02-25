//
//  QuestioneeDetailsViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestioneeDetailsViewController.h"

@implementation QuestioneeDetailsViewController

#pragma mark - Overridden Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)responsePressed:(UIButton *)button
{
	if([self validate])
	{
		[self.builder setIdentifier:[identifierField text]];
		[self.builder setDateOfBirth:[dobPicker date]];
		[self performSegueWithIdentifier:@"goToQ1" sender:self];
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDate* today = [NSDate date];
	NSDateComponents* sixtyFiveYearsAgoComponents = [[NSDateComponents alloc] init];
	[sixtyFiveYearsAgoComponents setYear:-65];
	NSDate* sixtyFiveYearsAgo = [calendar dateByAddingComponents:sixtyFiveYearsAgoComponents toDate:today options:0];
	[dobPicker setMaximumDate:sixtyFiveYearsAgo];
	
	NSDateComponents* hundredYearsAgoComponents = [[NSDateComponents alloc] init];
	[hundredYearsAgoComponents setYear:-100];
	NSDate* hundredYearsAgo = [calendar dateByAddingComponents:hundredYearsAgoComponents toDate:today options:0];
	[dobPicker setMinimumDate:hundredYearsAgo];
}


#pragma mark - QuestioneeDetailsViewController Implementation

@synthesize identifierField, dobPicker;


#pragma mark - Additional Methods

- (BOOL)validate
{
	if([[identifierField text] isEqualToString:@""])
	{
		[self displayError:@"Please provide your first name"];
		return NO;
	}
	
	if([[identifierField text] isEqualToString:@""])
	{
		[self displayError:@"Please provide an identifier"];
		return NO;
	}
	
	return YES;
}

- (void)displayError:(NSString*)error
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Field" message:error delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

@end
