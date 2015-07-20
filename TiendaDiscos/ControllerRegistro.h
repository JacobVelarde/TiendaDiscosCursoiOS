//
//  ControllerRegistro.h
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerRegistro : UIView

@property (weak, nonatomic) IBOutlet UITextField *txtNombre;


@property (weak, nonatomic) IBOutlet UITextField *txtUser;


@property (weak, nonatomic) IBOutlet UITextField *txtCorreo;


@property (weak, nonatomic) IBOutlet UITextField *txtContrasena;

@property (weak, nonatomic) IBOutlet UITextField *txtRepContrasena;


- (IBAction)btnRegistrar:(id)sender;

@end
