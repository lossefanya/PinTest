//
//  PTAnnotation.h
//  PinTest
//
//  Created by Young One Park on 2015. 7. 6..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PTAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
