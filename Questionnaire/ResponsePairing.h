//
//  ResponsePairing.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/// Retains the mapping between a UIButton and the annotation is is nested in.
/// NB: this is used in place of a struct due to ARC.
@interface ResponsePairing : NSObject

@property (nonatomic, strong) UIButton* button;

@property (nonatomic, strong) id<MKAnnotation> annotation;

@end
