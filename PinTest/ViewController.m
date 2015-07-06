//
//  ViewController.m
//  PinTest
//
//  Created by Young One Park on 2015. 7. 6..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "PTAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.delegate = self;
	mapView.translatesAutoresizingMaskIntoConstraints = YES;
	mapView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	[self.view addSubview:mapView];
	self.mapView = mapView;
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	tapRecognizer.numberOfTapsRequired = 1;
	tapRecognizer.numberOfTouchesRequired = 1;
	[self.mapView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Event handlers

- (void)tap:(UITapGestureRecognizer *)sender {
	CGPoint point = [sender locationInView:self.mapView];
	CLLocationCoordinate2D tapPoint = [self.mapView convertPoint:point toCoordinateFromView:self.view];
	PTAnnotation *annotation = [PTAnnotation new];
	annotation.coordinate = tapPoint;
	[self.mapView addAnnotation:annotation];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:@"annotationViewID"];
	
	if (annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
	}
	
	annotationView.annotation = annotation;
	annotationView.canShowCallout = YES;
	annotationView.animatesDrop = YES;
	
	return annotationView;
}



@end
