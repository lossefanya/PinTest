//
//  Annotation.h
//  PinTest
//
//  Created by Young One Park on 2015. 7. 6..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSManagedObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

+ (Annotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate;
+ (NSArray *)readData;
- (void)deleteData;

@end
