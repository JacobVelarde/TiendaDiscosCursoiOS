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
#import "AFNetworking.h"
#import "TableViewControllerDiscos.h"


@interface controllerGeneral ()

@property (strong, nonatomic) NSString *ID;

@end

@implementation controllerGeneral

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *url=@"http://";
    url = [url stringByAppendingString:_detallesDisco.imagen];
    
    _txtArtista.text =_detallesDisco.artista;
    [_imagen setImageWithURL:[NSURL URLWithString:url]];
    _txtNombre.text = _detallesDisco.nombre;
    _txtPrecio.text = _detallesDisco.precio;
    _txtStock.text = _detallesDisco.stock;
    _ID=_detallesDisco.iD;
    [self verificaUsuario];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)verificaUsuario{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long user=[[defaults objectForKey:@"admin"] longValue];
    
    if(user==0){
        _botonComprar.hidden=YES;
        _botonModificar.hidden=NO;
        NSLog(@"EntraAdmin");
        
    }else if(user==1){
        _txtArtista.enabled=NO;
        _txtNombre.enabled=NO;
        _txtPrecio.enabled=NO;
        _txtStock.enabled=NO;
        _botonModificar.enabled=NO;
        _botonModificar.hidden=YES;
        NSLog(@"EntraUser");
        
    }
    
}

- (IBAction)btnComprar:(id)sender {
    NSUserDefaults *nomUser = [NSUserDefaults standardUserDefaults];
    NSString *nameUser = [nomUser objectForKey:@"user"];
    
    [self compraDisco:_ID nombre:_txtNombre.text artista:_txtArtista.text precio:_txtPrecio.text usuario:nameUser];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Boton comprar");
}

- (IBAction)btnModificar:(id)sender {
    
    
    [self modificaDisco:_ID nombre:_txtNombre.text artista:_txtArtista.text precio:_txtPrecio.text stock:_txtStock.text];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Boton modificar");
    
}

-(void)modificaDisco:(NSString *)ID nombre:(NSString *)nombre artista:(NSString *)artista precio:(NSString*)precio stock:(NSString *)stock
{
    
    TableViewControllerDiscos *nextView = [[TableViewControllerDiscos alloc] initWithNibName:nil
                                                                                      bundle:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/modificaDisco.php"
                                                      parameters:@{@"id":ID,@"nombre":nombre,@"artista":artista,@"precio":precio,@"stock":stock}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"OK"]){
            
            [self.navigationController pushViewController:nextView animated:YES];
            [self showMessage:@"Modificacion" mensaje:@"Modificacion realizada"];
            
        }else{
            [self showMessage:@"Modificacion" mensaje:@"Modificacion no realizada"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self showMessage:@"Modificacion" mensaje:@"Error en el servidor"];
    }];
    [operation start];
    
}

-(void)showMessage:(NSString *)titulo mensaje:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titulo
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)compraDisco:(NSString *)ID nombre:(NSString *)nombre artista:(NSString *)artista precio:(NSString*)precio usuario:(NSString *)usuario
{
    
    TableViewControllerDiscos *nextView = [[TableViewControllerDiscos alloc] initWithNibName:nil
                                                                                      bundle:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/registraVenta.php"
                                                      parameters:@{@"id":ID,@"nombre":nombre,@"artista":artista,@"precio":precio,@"usuario":usuario}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"OK"]){
            
            [self.navigationController pushViewController:nextView animated:YES];
            [self showMessage:@"Compra" mensaje:@"Compra realizada"];
            
        }else{
            [self showMessage:@"Compra" mensaje:@"Compra no realizada"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self showMessage:@"Compra" mensaje:@"Error en el servidor"];
    }];
    [operation start];
    
}



@end
