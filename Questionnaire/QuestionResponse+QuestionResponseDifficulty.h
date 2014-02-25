//
//  QuestionResponse+QuestionResponseDifficulty.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionResponse.h"

/// Adds additional methods against a QuestionResponse
@interface QuestionResponse (QuestionResponseDifficulty)

/**
 * Converts the floating-point difficulty value into a string form.
 * @param difficulty the floating-point value between 0 and 100 inclusive representing the difficulty provided by the user.
 * @return the String form of the difficulty for presentation.
 */
+ (NSString*)percentageDifficultyToString:(float)difficulty;

@end
