//
//  controllerGeneral.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "controllerGeneral.h"
#import "UIImageView+AFNetworking.h"
#import "Disco.h"

@interface controllerGeneral ()

@property (strong, nonatomic) NSMutableArray *disco;

@end

@implementation controllerGeneral

- (void)viewDidLoad {
    [super viewDidLoad];
    self.disco = [NSMutableArray array];
    
    Disco *disco = [self.detallesDisco objectAtIndex:1];
//    self.txtNombreArtista.text =disco.artista;
//    [self.imagen setImageWithURL:[NSURL URLWithString:disco.imagen]];
//    self.txtNombreDisco.text = disco.nombre;
//    self.txtPrecio.text = disco.precio;
//    self.txtStock.text = disco.stock;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
