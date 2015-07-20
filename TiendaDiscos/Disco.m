//
//  Disco.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "Disco.h"

@implementation Disco

-(id)initWithValue:(NSString *)iD nombre:(NSString *)nombre artista:(NSString *)artista precio:(NSString *)precio imagen:(NSString *)imagen stock:(NSString *)stock{ //(id) o (instancetype)
    self=[super init];
    if (self) {
        _nombre=nombre;
        _artista = artista;
        _precio = precio;
        _imagen = imagen;
        _stock = stock;
    }
    return self;
}

@end
