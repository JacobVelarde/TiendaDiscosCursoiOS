//
//  TableViewControllerDiscos.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 20/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "TableViewControllerDiscos.h"
#import "AFNetworking.h"
#import "disco.h"
#import "controllerGeneral.h"
#import "TableViewControllerHistorial.h"


@interface TableViewControllerDiscos ()

@property (strong, nonatomic) NSMutableArray *discos;
@property (strong, nonatomic) NSMutableArray *dHistorial;

@end

@implementation TableViewControllerDiscos

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.dHistorial = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated{
    self.discos = [NSMutableArray array];
    [self getCatalogo];
    
    NSUserDefaults *nomUser = [NSUserDefaults standardUserDefaults];
    NSString *nameUser = [nomUser objectForKey:@"user"];
    [self getHistorial:nameUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.discos count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    controllerGeneral *general =[[controllerGeneral alloc] initWithNibName:@"controllerGeneral" bundle:nil];
    
    Disco *disco = [self.discos objectAtIndex:indexPath.row];
    NSLog(@"Aqui: %@",disco.nombre);
    
    general.detallesDisco=disco;
    
    [self.navigationController pushViewController:general animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Disco *disco = [self.discos objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = disco.artista;
    
    cell.detailTextLabel.text = disco.nombre;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if(![self verificaUsuario]){
            
            Disco *disco = [self.discos objectAtIndex:indexPath.row];
            [self eliminaDisco:disco.iD];
            [self.discos removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

-(void)eliminaDisco:(NSString *)ID{
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/eliminaDisco.php"
                                                      parameters:@{@"id":ID}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"OK"]){
            
            [self showMessage:@"Disco" mensaje:@"Disco eliminado"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        
    }];
    [operation start];
    
}


-(BOOL)verificaUsuario{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long user=[[defaults objectForKey:@"admin"] longValue];
    
    if(user==1){
        [self showMessage:@"Admin" mensaje:@"Entre como administrador"];
        return true;
        
    }else{
        return false;
    }
    
}


-(void)getCatalogo{
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/getCatalogo.php"
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSError *jsonError = nil;
        
        NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:responseObject options:nil error:&jsonError];
        
        
        for (NSDictionary *dic in jsonArray){
            Disco *disc=[[Disco alloc] init];
            
            disc.iD=(NSString*)[dic valueForKey:@"id"];
            disc.nombre=(NSString*)[dic valueForKey:@"nombre"];
            disc.artista=(NSString*)[dic valueForKey:@"artista"];
            disc.precio=(NSString*)[dic valueForKey:@"precio"];
            disc.imagen=(NSString*)[dic valueForKey:@"imagen"];
            disc.stock=(NSString*)[dic valueForKey:@"stock"];
            
            //self.discos=[NSArray arrayWithObject:disc];
            [self.discos addObject:disc];
            //NSLog([dic valueForKey:@"nombre"]);
            
        }
        
        NSLog(@"DiscoAgregados: %ld",[self.discos count]);
        
        [self.tableView reloadData];
        [self showMessage:@"Cargando catalogo" mensaje:@"Listo!"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self getCatalogo];
        
        
    }];
    [operation start];
    
}

-(void)showMessage:(NSString *)titulo mensaje:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titulo
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}


- (IBAction)btnComprasRealizadas:(id)sender {
    
    TableViewControllerHistorial *historial =[[TableViewControllerHistorial alloc] initWithNibName:@"TableViewControllerHistorial" bundle:nil];
    
    historial.historialDiscos=self.dHistorial;
    [self showMessage:@"Espere" mensaje:@"Cargando su historial"];
    
    [self.navigationController pushViewController:historial animated:YES];
}

-(void)getHistorial:(NSString *)user{
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pruebajava.hol.es/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://pruebajava.hol.es/consultaVentas.php"
                                                      parameters:@{@"usuario":user}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSError *jsonError = nil;
        
        NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:responseObject options:nil error:&jsonError];
        
        
        for (NSDictionary *dic in jsonArray){
            Disco *disc=[[Disco alloc] init];
            
            disc.iD=(NSString*)[dic valueForKey:@"id"];
            disc.nombre=(NSString*)[dic valueForKey:@"nombre"];
            disc.artista=(NSString*)[dic valueForKey:@"artista"];
            disc.precio=(NSString*)[dic valueForKey:@"precio"];
            //disc.imagen=(NSString*)[dic valueForKey:@"imagen"];
            //disc.stock=(NSString*)[dic valueForKey:@"stock"];
            
            //self.discos=[NSArray arrayWithObject:disc];
            [self.dHistorial addObject:disc];
            //NSLog([dic valueForKey:@"nombre"]);
            
        }
        
        NSLog(@"DiscoHistorial: %ld",[self.dHistorial count]);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        
    }];
    [operation start];
    
}

@end
