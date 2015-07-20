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


@interface TableViewControllerDiscos ()

@property (strong, nonatomic) NSDictionary *discosFromJson;
@property (strong, nonatomic) NSMutableArray *discos;

@end

@implementation TableViewControllerDiscos

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCatalogo];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.discos = [NSMutableArray array];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.discos count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    controllerGeneral *general =[[controllerGeneral alloc] initWithNibName:nil bundle:nil];
    general.detallesDisco=[self.discos objectAtIndex:indexPath.row];
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
    
    //NSLog(@"AAAAAAAAAAaA %@",[tempDictionary objectForKey:@"nombre"]);
    
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Not Rated"];
    
    
    return cell;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
    }];
    [operation start];
    
}


@end