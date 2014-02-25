//
//  QuestionnaireApp.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

@interface QuestionnaireApp : NSManagedObject

@property (nonatomic, retain) QuestionnaireResponse *responses;

@end
