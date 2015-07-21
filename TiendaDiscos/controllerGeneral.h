//
//  controllerGeneral.h
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disco.h"

@interface controllerGeneral : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *txtNombre;

@property (weak, nonatomic) IBOutlet UITextField *txtArtista;

@property (weak, nonatomic) IBOutlet UITextField *txtPrecio;


@property (weak, nonatomic) IBOutlet UITextField *txtStock;

@property (nonatomic) Disco *detallesDisco;

@property (weak, nonatomic) IBOutlet UIImageView *imagen;


- (IBAction)btnComprar:(id)sender;

- (IBAction)btnModificar:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *botonComprar;


@property (weak, nonatomic) IBOutlet UIButton *botonModificar;


@end
