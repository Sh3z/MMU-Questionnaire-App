//
//  QuestionnaireTabViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 01/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionnaireTabViewController.h"
#import "QuestionViewController.h"
#import "QuestionnaireResponseBuilder.h"
#import "QuestionnaireApp.h"
#import "CoreDataAssistant.h"
#import "Settings.h"
#import "SettingsTableViewController.h"
#import "ResponsesMapAssistant.h"
#import "ResponseInformation.h"

@interface QuestionnaireTabViewController ()
{
	/// Contains the responses map assistant we will use for this tab's map.
	ResponsesMapAssistant* _mapAssistant;
	
	/// Contains a weak reference to the enter passcode dialog.
	UIAlertView* _passcodeDialog;
	
	/// Contains a weak reference to the begin questionnaire dialog.
	UIAlertView* _beginDialog;
	
	/// Indicates whether the user has already entered their passcode.
	BOOL _didEnterPasscode;
}

@end

@implementation QuestionnaireTabViewController

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Initialize the map assistant.
	_mapAssistant = [[ResponsesMapAssistant alloc] init];
	_mapAssistant.delegate = self;
	_mapAssistant.map = [self map];
	_mapAssistant.responses = [[[[CoreDataAssistant instance] getApplicationStore] responses] allObjects];
	
	_didEnterPasscode = NO;
	
	self.navigationItem.title = @"Questionnaire";
}

- (void)viewWillAppear:(BOOL)animated
{
	NSSet* responses = [[[CoreDataAssistant instance] getApplicationStore] responses];
	[_mapAssistant setResponses:[responses allObjects]];
	[self.totalResponsesLabel setText:[NSString stringWithFormat:@"%i", [responses count]]];
	
	int numAcquiredToday = 0;
	NSDateComponents* today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
	for(QuestionnaireResponse* response in responses)
	{
		NSDateComponents* responseDate = [[NSCalendar currentCalendar] components:NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[response responseDetails] timeCompleted]];
		if([today day] == [responseDate day])
		{
			numAcquiredToday++;
		}
	}
	
	[self.todaysResponsesLabel setText:[NSString stringWithFormat:@"%i", numAcquiredToday]];
	
	// Request the passcode to continue if the settings dictate so.
	Settings* appSettings = [[CoreDataAssistant instance] getSettings];
	if([[appSettings usePasscode] boolValue] == YES && _didEnterPasscode == NO)
	{
		return [self requestPasscodeWithMessage:@"Enter your passcode to continue"];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[_mapAssistant zoomOnUserLocation];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([[segue identifier] isEqualToString:@"beginQuestionnaire"])
	{
		// We take the top view controller as the setup controller is wrapped by the navigation controller
		id vc = (QuestionViewController*)[[segue destinationViewController] topViewController];
		[vc setBuilder:[[QuestionnaireResponseBuilder alloc] init]];
		[vc setQuestionnaireDelegate:self];
	}
	else if([[segue identifier] isEqualToString:@"showSettings"])
	{
		SettingsTableViewController* vc = (SettingsTableViewController*)[[segue destinationViewController] topViewController];
		vc.delegate = self;
	}
	
	[super prepareForSegue:segue sender:sender];
}


#pragma mark - BeginQuestionnaireDelegate Implementation

- (void)didCompleteQuestionnaire
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - QuestionnaireTabViewController Implementation

@synthesize map;

- (IBAction)onBeginQuestionnairePressed:(id)sender
{
	_beginDialog = [[UIAlertView alloc] initWithTitle:@"" message:@"On pressing \"OK\", prepare to hand this iPad to the questionee." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[_beginDialog show];
}


#pragma mark - AppSettingsDelegate Implementation

- (void)didFinishChangingSettings
{
	[self dismissViewControllerAnimated:YES completion:nil];
	[[CoreDataAssistant instance] saveContext];
}


#pragma mark - ResponseMapDelegate Implementation

- (void)didRequestDisplayOfResponse:(QuestionnaireResponse *)response
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectResponseOnMap" object:response];
}


#pragma mark - Additional Methods

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView == _passcodeDialog)
	{
		// Check the passcode is correct.
		Settings* appSettings = [[CoreDataAssistant instance] getSettings];
		if([[[alertView textFieldAtIndex:0] text] isEqualToString:[appSettings passcodeAsString]] == NO)
		{
			[self requestPasscodeWithMessage:@"Incorrect passcode"];
		}
		else
		{
			_didEnterPasscode = YES;
			_passcodeDialog = nil;
		}
	}
	else if(alertView == _beginDialog)
	{
		_beginDialog = nil;
		if(buttonIndex == 1)
		{
			// Set the passcode flag back to NO so on completion, we need the passcode again
			_didEnterPasscode = NO;
			[self performSegueWithIdentifier:@"beginQuestionnaire" sender:self];
		}
	}
}

- (void)requestPasscodeWithMessage:(NSString*)msg
{
	_passcodeDialog = [[UIAlertView alloc] initWithTitle:@"Enter Passcode" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	_passcodeDialog.alertViewStyle = UIAlertViewStyleSecureTextInput;
	[_passcodeDialog show];
}

@end
