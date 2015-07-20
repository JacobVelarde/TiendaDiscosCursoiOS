//
//  ViewController.h
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUser;

@property (weak, nonatomic) IBOutlet UITextField *txtPass;

- (IBAction)btnAcceder:(id)sender;

- (IBAction)btnRegistrarse:(id)sender;

-(void)acceso;

@end

