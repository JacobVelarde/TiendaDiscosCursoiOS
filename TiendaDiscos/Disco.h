//
//  Disco.h
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Disco : NSObject

@property (nonatomic,copy) NSString *iD;

@property (nonatomic,copy) NSString *nombre;

@property (nonatomic,copy) NSString *artista;

@property (nonatomic,copy) NSString *precio;

@property (nonatomic,copy) NSString *imagen;

@property (nonatomic,copy) NSString *stock;





-(id)initWithValue:(NSString *)iD nombre:(NSString *)nombre artista:(NSString *)artista precio:(NSString *)precio imagen:(NSString *)imagen stock:(NSString *)stock;  //(id) o (instancetype)
@end
