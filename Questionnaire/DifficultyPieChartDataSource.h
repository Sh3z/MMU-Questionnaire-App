//
//  DifficultyPieChartDataSource.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYPieChart.h"

/// Represents the object providing an XYPieChart with the difficulty information
/// from question responses.
@interface DifficultyPieChartDataSource : NSObject<XYPieChartDataSource>
@end
