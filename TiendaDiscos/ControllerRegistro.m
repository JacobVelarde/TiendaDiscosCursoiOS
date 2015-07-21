//
//  ControllerRegistro.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "ControllerRegistro.h"
#import "AFNetworking.h"
#import "ViewController.h"

@implementation ControllerRegistro

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (IBAction)btnRegistrar:(id)sender {
    
    if([_txtUser.text isEqualToString:@""] || [_txtContrasena.text isEqualToString:@""] ||
       [_txtCorreo.text isEqualToString:@""] || [_txtNombre.text isEqualToString:@""] ||
       [_txtRepContrasena.text isEqualToString:@""]){
        
        [self showMessage:@"Campos vacios" mensaje:@"No puede haber campos vacios"];
    }else{
        
        if ([_txtContrasena.text isEqualToString:_txtRepContrasena.text]) {
            
            [self showMessage:@"Conectando" mensaje:@"Sera notificado cuando se halla hecho su registro"];
            
            [self registraUsuarios:_txtNombre.text usuario:_txtUser.text email:_txtCorreo.text password:_txtContrasena.text];
            
            
        }else{
            
            [self showMessage:@"Contraseñas" mensaje:@"Las contraseñas no coinciden"];
            
        }
    }
    
}


-(void)registraUsuarios:(NSString *)nombre usuario:(NSString *)user email:(NSString *)email password:(NSString*)pwd
{
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/registraUser.php"
                                                      parameters:@{@"nombre":nombre,@"usuario":user,@"correo":email,@"pwd":pwd}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"OK"]){
            
            
            [self showMessage:@"Registro" mensaje:@"Registrado con exito"];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self showMessage:@"Error" mensaje:@"Error en el servidor, intente de nuevo"];
        
        
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
@end
