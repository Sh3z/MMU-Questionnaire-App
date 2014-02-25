//
//  AppSettingsDelegate.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Represents the object which manages the settings of an application.
@protocol AppSettingsDelegate <NSObject>

/// Occurs when the user is done modifying the app settings.
- (void)didFinishChangingSettings;

@end
