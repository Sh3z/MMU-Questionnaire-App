//
//  StatisticsViewDataSourceDelegate.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionnaireApp.h"

/// Represents an object which calculates the statistical information from all the responses.
@protocol StatisticsViewDataSourceDelegate <NSObject>

@required

/// Gets the total number of responses gathered.
@property (nonatomic, readonly) int numberOfResponses;

/// Gets the percentage of respondants who have used an iPad before
@property (nonatomic, readonly) int usediPadBeforePercentage;

/// Gets the number of respondants who had used an iPad before.
@property (nonatomic, readonly) int numberUsediPadBefore;

/// Gets the percentage of respondants who intend on using an iPad again
@property (nonatomic, readonly) int wouldUseiPadAgainPercentage;

/// Gets the number of respondants who intend on using an iPad again
@property (nonatomic, readonly) int numberWouldUseiPadAgain;

/// Gets the percentage of respondants who intend on using an iPad again, having faced some difficulty in using it this time
@property (nonatomic, readonly) int hadDifficultyButWouldUseiPadAgainPercentage;

/// Gets the number of respondans who intend on using an iPad again, having faced some difficulty in using it this time
@property (nonatomic, readonly) int numberHadDifficultyButWouldUseiPadAgain;


/**
 * Recalculates the statistics within this object.
 * @param app the aggregation of collected information
 */
- (void)updateStatistics:(QuestionnaireApp*)app;

@end
