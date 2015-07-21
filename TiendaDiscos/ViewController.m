//
//  ViewController.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "TableViewControllerDiscos.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAcceder:(id)sender {
    
    if([_txtUser.text isEqualToString:@""] || [_txtPass.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos vacios"
                                                        message:@"Existen campos vacios"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [self consultaUsuario:_txtUser.text password:_txtPass.text];
    }
    
}

- (IBAction)btnRegistrarse:(id)sender {
}

-(void)consultaUsuario:(NSString *)user password:(NSString *)pass
{
    
    TableViewControllerDiscos *nextView = [[TableViewControllerDiscos alloc] initWithNibName:nil
                                                                                      bundle:nil];
    NSUserDefaults *admin = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *nomUser = [NSUserDefaults standardUserDefaults];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/validarUser.php"
                                                      parameters:@{@"usuario":user,@"psw":pass}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"SI"]){
            
            [admin setInteger:1 forKey:@"admin"];
            [nomUser setObject:user forKey:@"user"]; //GUARDO USUARIO PARA RECUPERLO EN LA TABLA_VENTA
            [self.navigationController pushViewController:nextView animated:YES];
            NSLog(@"Entra user");
            
            
        }else{
            if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"admin"]){
                
                [admin setInteger:0 forKey:@"admin"];
                [self.navigationController pushViewController:nextView
                                                     animated:YES];
                NSLog(@"Entra admin");
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    
}


@end
