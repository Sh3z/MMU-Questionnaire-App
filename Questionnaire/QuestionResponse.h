//
//  QuestionResponse.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 25/02/2014.
//  Copyright (c) 2014 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

@interface QuestionResponse : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSNumber * questionNum;
@property (nonatomic, retain) NSString * response;
@property (nonatomic, retain) QuestionnaireResponse *parentResponse;

@end
