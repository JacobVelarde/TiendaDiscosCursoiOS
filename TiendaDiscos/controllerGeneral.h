//
//  controllerGeneral.h
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface controllerGeneral : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *txtNombreDisco;

@property (weak, nonatomic) IBOutlet UILabel *txtNombreArtista;

@property (weak, nonatomic) IBOutlet UILabel *txtPrecio;

@property (weak, nonatomic) IBOutlet UILabel *txtStock;

@property (strong, nonatomic) NSMutableArray *detallesDisco;

@property (weak, nonatomic) IBOutlet UIImageView *imagen;

@end
