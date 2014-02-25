//
//  DifficultyPieChartDataSource.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "DifficultyPieChartDataSource.h"
#import "CoreDataAssistant.h"
#import "QuestionnaireApp.h"
#import "QuestionResponse+QuestionResponseDifficulty.h"

@interface DifficultyPieChartDataSource ()
{
	/// Contains the names of the difficulties to be presented.
	NSArray* _difficulties;
	
	/// Contains the set of colours used in the display of the pie chart.
	NSArray* _colours;
}

@end

@implementation DifficultyPieChartDataSource

- (id)init
{
	if(self = [super init])
	{
		_difficulties = [NSArray arrayWithObjects:@"Very Easy", @"Easy", @"Medium", @"Difficult", @"Very Difficult", nil];
		NSMutableArray* coloursArray = [[NSMutableArray alloc] initWithCapacity:5];
		[coloursArray addObject:[UIColor colorWithRed:82.0f/255.0f green:221.0f/255.0f blue:255.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:38.0f/255.0f green:199.0f/255.0f blue:241.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:38.0f/255.0f green:180.0f/255.0f blue:203.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:38.0f/255.0f green:176.0f/255.0f blue:224.0f/255.0f alpha:1]];
		[coloursArray addObject:[UIColor colorWithRed:38.0f/255.0f green:100.0f/255.0f blue:152.0f/255.0f alpha:1]];
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
	int upperLimit = (int)(20 * (index + 1));
	int lowerLimit = upperLimit - 20;
	QuestionnaireApp* app = [[CoreDataAssistant instance] getApplicationStore];
	
	// Count the number of responses containing the usage substring.
	for(QuestionnaireResponse* response in app.responses)
	{
		if([self didUserSpecifyDifficultyBetweenLower:lowerLimit andUpper:upperLimit forResponse:response])
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
	return [_difficulties objectAtIndex:index];
}


#pragma mark - Additional Methods

/**
 * Checks to see if the user specified a difficulty within a specified range
 * @param lower the lower range of the difficulty to test
 * @param upper the upper range of the difficulty to test
 * @param response the response recieved by the user
 * @return YES if the user chose a difficulty that lies inside the range (inclusive)
 */
- (BOOL)didUserSpecifyDifficultyBetweenLower:(int)lower andUpper:(int)upper forResponse:(QuestionnaireResponse*)response
{
	QuestionResponse* difficultyResponse;
	for(QuestionResponse* qResponse in response.questionResponses)
	{
		if([qResponse.questionNum isEqualToNumber:[NSNumber numberWithInt:1]])
		{
			difficultyResponse = qResponse;
			break;
		}
	}
	
	// Convert the response percentage into a string.
	NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
	NSNumber* parsedDifficulty = [formatter numberFromString:[[difficultyResponse response] stringByReplacingOccurrencesOfString:@"%" withString:@""]];
	if(parsedDifficulty)
	{
		float difficulty = 100 - [parsedDifficulty floatValue];
		return difficulty <= upper && difficulty >= lower;
	}
	else
	{
		return NO;
	}
}

@end
