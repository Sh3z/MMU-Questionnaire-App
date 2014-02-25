//
//  StatisticsViewDataSource.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticsViewDataSourceDelegate.h"

/// Represents the object that generates the data for the statistics view
@interface StatisticsViewDataSource : NSObject<StatisticsViewDataSourceDelegate>
@end
