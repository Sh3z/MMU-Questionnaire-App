//
//  ResponseViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 01/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "ResponseViewController.h"
#import "ResponsesMapAssistant.h"
#import "QuestionnaireResponse.h"
#import "ResponseInformation.h"

@interface ResponseViewController ()
{
	/// Contains the map assistant used to display the location of the current response.
	ResponsesMapAssistant* _mapAssistant;
}

@end

@implementation ResponseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_mapAssistant = [[ResponsesMapAssistant alloc] init];
	_mapAssistant.map = [self mapView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([[segue identifier] isEqual: @"embeddedTableView"])
	{
		responsesViewController = (QuestionnaireResponseTableViewController*)[segue destinationViewController];
	}
}

#pragma mark - ResponseViewController Implementation

@synthesize response = _response, responsesViewController;

- (void)setResponse:(QuestionnaireResponse *)response
{
	_response = response;
	[responsesViewController setQuestionnaireResponse:response];
	
	if(response)
	{
		[[response responseDetails] setHasSeen:[NSNumber numberWithBool:YES]];
		NSArray* wrapper = [[NSArray alloc] initWithObjects:response, nil];
		[_mapAssistant setResponses:wrapper];
		[_mapAssistant zoomOnLastAddedAnnotation];
	}
}

@end
