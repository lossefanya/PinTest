//
//  ViewController.m
//  PinTest
//
//  Created by Young One Park on 2015. 7. 6..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "Annotation.h"

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.translatesAutoresizingMaskIntoConstraints = NO;
	mapView.delegate = self;
	MKCoordinateSpan span = MKCoordinateSpanMake(0, 360/pow(2, 10) * mapView.frame.size.width/256);
	mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(52.5, 13.4), span);
	[self.view addSubview:mapView];
	self.mapView = mapView;
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	tapRecognizer.numberOfTapsRequired = 1;
	tapRecognizer.numberOfTouchesRequired = 1;
	[self.mapView addGestureRecognizer:tapRecognizer];
	
	[self.mapView addAnnotations:[Annotation readData]];
	
	UIButton *deleteButton = [UIButton new];
	deleteButton.backgroundColor = [UIColor lightGrayColor];
	deleteButton.layer.cornerRadius = 25;
	deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
	[deleteButton setTitle:@"DELETE" forState:UIControlStateNormal];
	[deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:deleteButton];
	self.deleteButton = deleteButton;
	
	NSDictionary *viewsDictionary = @{@"mapView": self.mapView, @"deleteButton":self.deleteButton};
	[self.view addConstraints:[self constraintsWithFormat:@"V:|-0-[mapView]-0-|" views:viewsDictionary]];
	[self.view addConstraints:[self constraintsWithFormat:@"H:|-0-[mapView]-0-|" views:viewsDictionary]];
	[self.view addConstraints:[self constraintsWithFormat:@"V:[deleteButton(50)]-30-|" views:viewsDictionary]];
	[self.view addConstraints:[self constraintsWithFormat:@"H:[deleteButton(100)]-30-|" views:viewsDictionary]];
}

- (NSArray *)constraintsWithFormat:(NSString *)format views:(NSDictionary *)views {
	return [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Event handlers

- (void)tap:(UITapGestureRecognizer *)sender {
	CGPoint point = [sender locationInView:self.mapView];
	CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.view];
	Annotation *annotation = [Annotation annotationWithCoordinate:coordinate];
	[self.mapView addAnnotation:annotation];
}

- (void)delete {
	for (Annotation *annotation in self.mapView.annotations) {
		[annotation deleteData];
	}
	[self.mapView removeAnnotations:self.mapView.annotations];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:@"annotationViewID"];
	
	if (annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
	}
	
	annotationView.annotation = annotation;
	annotationView.animatesDrop = YES;
	
	return annotationView;
}



@end
