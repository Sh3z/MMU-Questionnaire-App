//
//  ResponseInformation.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

@interface ResponseInformation : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * respondantDateOfBirth;
@property (nonatomic, retain) NSString * respondantForename;
@property (nonatomic, retain) NSString * respondantSurname;
@property (nonatomic, retain) NSDate * timeCompleted;
@property (nonatomic, retain) NSDate * timeBegan;
@property (nonatomic, retain) QuestionnaireResponse *response;

@end
