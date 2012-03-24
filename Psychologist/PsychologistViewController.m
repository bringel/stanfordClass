//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Brad Ringel on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()
@property (nonatomic) int diagnosis;
@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;

- (HappinessViewController *)splitViewHappinesViewController{
    id happiness = [self.splitViewController.viewControllers lastObject];
    if(![happiness isKindOfClass:[HappinessViewController class]])
        happiness = nil;
    return happiness;
}

- (void)setAndShowDiagnosis:(int)diagnosis{
    self.diagnosis = diagnosis;
    if([self splitViewHappinesViewController])
        [self splitViewHappinesViewController].happiness = diagnosis;
    else 
        [self performSegueWithIdentifier:@"showDiagnosis" sender:self];
}

- (IBAction)flying {
    [self setAndShowDiagnosis:85];
}

- (IBAction)apple {
    [self setAndShowDiagnosis:100];
}

- (IBAction)dragons {
    [self setAndShowDiagnosis:20];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    if([[segue identifier] isEqualToString:@"celebrity"]){
        [segue.destinationViewController setHappiness:100];
    }
    if([[segue identifier] isEqualToString:@"serious"]){
        [segue.destinationViewController setHappiness:20];
    }
    if([[segue identifier] isEqualToString:@"tvKook"]){
        [segue.destinationViewController setHappiness:50];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

@end
