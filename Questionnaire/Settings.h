//
//  Settings.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 25/02/2014.
//  Copyright (c) 2014 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireApp;

@interface Settings : NSManagedObject

@property (nonatomic, retain) NSString * passcodeAsString;
@property (nonatomic, retain) NSNumber * usePasscode;
@property (nonatomic, retain) QuestionnaireApp *app;

@end
