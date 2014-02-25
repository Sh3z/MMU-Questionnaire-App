//
//  StatisticsViewDataSource.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "StatisticsViewDataSource.h"
#import "QuestionnaireResponse.h"
#import "QuestionResponse.h"

@implementation StatisticsViewDataSource

@synthesize numberOfResponses = _numberOfResponses, usediPadBeforePercentage = _usediPadBeforePercentage,numberUsediPadBefore = _numberUsediPadBefore, wouldUseiPadAgainPercentage = _wouldUseiPadAgainPercentage,
numberWouldUseiPadAgain = _numberWouldUseiPadAgain, hadDifficultyButWouldUseiPadAgainPercentage = _hadDifficultyButWouldUseiPadAgainPercentage, numberHadDifficultyButWouldUseiPadAgain = _numberHadDifficultyButWouldUseiPadAgain;

- (id)init
{
	if(self = [super init])
	{
		_numberOfResponses = 0;
		_usediPadBeforePercentage = 0;
		_numberUsediPadBefore = 0;
		_wouldUseiPadAgainPercentage = 0;
		_numberWouldUseiPadAgain = 0;
		_hadDifficultyButWouldUseiPadAgainPercentage = 0;
		_numberHadDifficultyButWouldUseiPadAgain = 0;
	}
	
	return self;
}

- (void)updateStatistics:(QuestionnaireApp *)app
{
	_numberOfResponses = [[app responses] count];
	_numberUsediPadBefore = 0;
	_numberWouldUseiPadAgain = 0;
	_numberHadDifficultyButWouldUseiPadAgain = 0;
	float numHadDifficulty = 0;
	
	// Count up the responses for each value first.
	for(QuestionnaireResponse* response in app.responses)
	{
		BOOL didFindDifficult = NO;
		
		if(![response questionResponses] || [[response questionResponses] count] < 3)
		{
			continue;
		}
		
		// Q1 & 3 = Yes/No
		if([self evaluateBoolFromResponse:[self questionWithNumericalIdentifier:0 fromSet:[response questionResponses]]])
		{
			_numberUsediPadBefore++;
		}
		
		// Q2 could be usages or difficulties. If the response can be a float, it's difficulties.
		QuestionResponse* q2 = [self questionWithNumericalIdentifier:1 fromSet:[response questionResponses]];
		NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
		NSNumber* difficulty = [formatter numberFromString:[[q2 response] stringByReplacingOccurrencesOfString:@"%" withString:@""]];
		if(difficulty)
		{
			// 'Difficult' is 40% and below usability
			didFindDifficult = [difficulty floatValue] <= 40.0f;
			if(didFindDifficult)
			{
				numHadDifficulty++;
			}
		}
		
		if([self evaluateBoolFromResponse:[self questionWithNumericalIdentifier:2 fromSet:[response questionResponses]]])
		{
			_numberWouldUseiPadAgain++;
			if(didFindDifficult)
			{
				_numberHadDifficultyButWouldUseiPadAgain++;
			}
		}
	}
	
	_usediPadBeforePercentage = (int)(((float)_numberUsediPadBefore / (float)_numberOfResponses) * 100.0f);
	_wouldUseiPadAgainPercentage = (int)((float)(_numberWouldUseiPadAgain / (float)_numberOfResponses) * 100.0f);
	
	if(numHadDifficulty > 0)
	{
		_hadDifficultyButWouldUseiPadAgainPercentage = (int)((_numberHadDifficultyButWouldUseiPadAgain / numHadDifficulty) * 100.0f);
	}
	else
	{
		_hadDifficultyButWouldUseiPadAgainPercentage = 0;
	}
}


#pragma mark - Additional Methods

- (QuestionResponse*)questionWithNumericalIdentifier:(int)identifier fromSet:(NSSet*)set
{
	for(QuestionResponse* response in set)
	{
		if([response questionNum] == [NSNumber numberWithInt:identifier])
		{
			return response;
		}
	}
	
	return nil;
}

/**
 * Evaluates the response from the question as a boolean
 * @param response the QuestionResponse to resolve the value from.
 * @return YES or NO depending on the collected response.
 */
- (BOOL)evaluateBoolFromResponse:(QuestionResponse*)response
{
	return [[response response] boolValue];
}


@end
