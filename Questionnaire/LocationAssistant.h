//
//  LocationAssistant.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * Represents a singleton providing location updates throughout the application.
 * This class broadcasts a "updatedLocation" notification to the application's
 * notification center while tracking.
 */
@interface LocationAssistant : NSObject<CLLocationManagerDelegate>

/// Gets the last resolved location from this assistant.
@property (nonatomic, readonly) CLLocation* lastLocation;

/**
 * Gets the shared LocationAssistant singleton object.
 * @return the shared LocationAssistant singleton object.
 */
+ (LocationAssistant*)instance;

/// Begins tracking the users location.
- (void)beginTracking;

/// Stops tracking the users location.
- (void)stopTracking;

@end
