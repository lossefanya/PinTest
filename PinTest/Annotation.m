//
//  Annotation.m
//  PinTest
//
//  Created by Young One Park on 2015. 7. 6..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import "Annotation.h"
#import "AppDelegate.h"


@implementation Annotation

@synthesize coordinate;
@dynamic latitude, longitude, date, title, subtitle;

+ (NSDateFormatter *)timeForm {
	NSDateFormatter *dateForm = [NSDateFormatter new];
	[dateForm setDateFormat:@"HH:mm:ss"];
	return dateForm;
}

+ (NSDateFormatter *)dateForm {
	NSDateFormatter *dateForm = [NSDateFormatter new];
	[dateForm setDateFormat:@"dd MMM yyyy"];
	return dateForm;
}

+ (Annotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate {
	AppDelegate *app = [UIApplication sharedApplication].delegate;
	
	Annotation *annotation = [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:app.managedObjectContext];
	annotation.latitude = @(coordinate.latitude);
	annotation.longitude = @(coordinate.longitude);
	annotation.coordinate = coordinate;
	annotation.date = [NSDate date];
	annotation.title = [[Annotation dateForm] stringFromDate:annotation.date];
	annotation.subtitle = [[Annotation timeForm] stringFromDate:annotation.date];
	
	NSError *error;
	if (![app.managedObjectContext save:&error]) {
		NSLog(@"creat error : %@", error);
	}
	
	return annotation;
}

+ (NSArray *)readData {
	AppDelegate *app = [UIApplication sharedApplication].delegate;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:app.managedObjectContext];
	[fetchRequest setEntity:entity];
	NSError *error;
	NSArray *fetchedObjects = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (error) {
		NSLog(@"read error : %@", error);
	}
	
	for (Annotation *info in fetchedObjects) {
		double lat = [info.latitude doubleValue];
		double lon = [info.longitude doubleValue];
		info.coordinate = CLLocationCoordinate2DMake(lat, lon);
	}
	
	return fetchedObjects;
}

- (void)deleteData {
	AppDelegate *app = [UIApplication sharedApplication].delegate;
	
	[app.managedObjectContext deleteObject:self];
	NSError *error;
	if (![app.managedObjectContext save:&error]) {
		NSLog(@"delete error : %@", error);
	}
}

@end
