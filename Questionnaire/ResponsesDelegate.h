//
//  ResponsesDelegate.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionnaireResponse.h"

/// Represents an object which acts as a delegate for the Responses selection view.
@protocol ResponsesDelegate <NSObject>

/**
 * Occurs when a QuestionnaireResponse has been selected for display.
 * @param response the selected response object.
 */
- (void)didSelectResponse:(QuestionnaireResponse*)response;

/// Occurs when the user requests the statistics view.
- (void)didRequestStatistics;

@end
