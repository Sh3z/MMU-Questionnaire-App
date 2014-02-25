//
//  iPadUsagePieChartDataSource.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "iPadUsagePieChartDataSource.h"
#import "CoreDataAssistant.h"
#import "QuestionnaireApp.h"

@interface iPadUsagePieChartDataSource ()
{
	/// Contains the colours to use for each segment of the pie chart.
	NSArray* _colours;
	
	/// Contains the possible iPad uses for reference.
	NSArray* _usages;
}

@end

@implementation iPadUsagePieChartDataSource

- (id)init
{
	if(self = [super init])
	{
		_usages = [NSArray arrayWithObjects:@"Work", @"Games", @"Internet", @"Social", @"Other", nil];
		
		NSMutableArray* coloursArray = [[NSMutableArray alloc] initWithCapacity:5];
		[coloursArray addObject:[UIColor colorWithRed:30.0f/255.0f green:189.0f/255.0f blue:55.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:0 green:168.0f/255.0f blue:19.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:0.266 green:0.266 blue:0.266 alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:99.0f/255.0f green:212.0f/255.0f blue:131.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:94.0f/255.0f green:93.0f/255.0f blue:100.0f/255.0f alpha:1]];
		_colours = coloursArray;
	}
	
	return self;
}


#pragma mark - XYPieChartDataSource Implementation

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
	return 5;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
	CGFloat value = 0;
	NSString* usageString = [_usages objectAtIndex:index];
	QuestionnaireApp* app = [[CoreDataAssistant instance] getApplicationStore];
	
	// Count the number of responses containing the usage substring.
	for(QuestionnaireResponse* response in app.responses)
	{
		if([self didPickUsage:usageString inResponse:response])
		{
			value++;
		}
	}
	
	return value;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
	return [_colours objectAtIndex:index];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
	return [_usages objectAtIndex:index];
}


#pragma mark - Additional Methods

/**
 * Checks to see if the user specified a particular usage within their response
 * @param usageAsString to usage to check was chosen
 * @param response the QuestionnaireResponse to check
 * @return YES if the user specified the usage in the string
 */
- (BOOL)didPickUsage:(NSString*)usageAsString inResponse:(QuestionnaireResponse*)response
{
	QuestionResponse* usageResponse;
	for(QuestionResponse* qResponse in response.questionResponses)
	{
		if([qResponse.questionNum isEqualToNumber:[NSNumber numberWithInt:1]])
		{
			usageResponse = qResponse;
			break;
		}
	}
	
	return [[usageResponse response] rangeOfString:usageAsString].location != NSNotFound;
}

@end
