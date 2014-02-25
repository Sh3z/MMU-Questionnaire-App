//
//  QuestionResponse+QuestionResponseDifficulty.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionResponse+QuestionResponseDifficulty.h"

@implementation QuestionResponse (QuestionResponseDifficulty)

+ (NSString*)percentageDifficultyToString:(float)difficulty
{
	NSString* difficultyAsString;
	if(difficulty < 20)
	{
		difficultyAsString = @"Very Easy";
	}
	else if(difficulty < 40)
	{
		difficultyAsString = @"Easy";
	}
	else if(difficulty < 60)
	{
		difficultyAsString = @"Medium";
	}
	else if(difficulty < 80)
	{
		difficultyAsString = @"Difficult";
	}
	else
	{
		difficultyAsString = @"Very Difficult";
	}

	return difficultyAsString;
}

@end
