//
//  ResponsesMapAssistant.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ResponseMapDelegate.h"

/// Represents the object which provides the creation of annotations of a MKMapView for a
/// set of QuestionnaireResponse objects.
@interface ResponsesMapAssistant : NSObject<MKMapViewDelegate>

/// Contains a reference to the delegate whom is notified when annotations are interacted with.
@property (nonatomic, strong) NSObject<ResponseMapDelegate>* delegate;

/// Contains a reference to the map view to be populated with responses.
@property (nonatomic, strong) MKMapView* map;

/// Contains the set of responses to be displayed within the map view.
@property (nonatomic, strong) NSArray* responses;

/// Forces an update of the current map.
- (void)refreshMap;

/// Zooms the map onto the last added annotation.
- (void)zoomOnLastAddedAnnotation;

/// Zooms the map to the user's current position.
- (void)zoomOnUserLocation;
@end
