//
//  BeginQuestionnaireDelegate.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Represents the delegate responsible for beginning the questionnaire from a
 * setup view controller.
 */
@protocol QuestionnaireDelegate <NSObject>

/// Notidies this delegate the Questionnaire view should be removed.
- (void)didCompleteQuestionnaire;

@end
