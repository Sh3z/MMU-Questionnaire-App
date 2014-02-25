//
//  ResponseMapDelegate.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionnaireResponse.h"

/// Represents the object that acts a delegate against a ResponseAnnotationView
@protocol ResponseMapDelegate <NSObject>

/**
 * Requests to the delegate the display of a particular QuestionnaireResponse.
 * @param response - the QuestionnaireResponse the user has requested to see.
 */
- (void)didRequestDisplayOfResponse:(QuestionnaireResponse*)response;

@end
