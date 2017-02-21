//
//  Character+CoreDataProperties.m
//  Marvel
//
//  Created by aiuar on 09.02.17.
//  Copyright © 2017 A.V. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Character+CoreDataProperties.h"

@implementation Character (CoreDataProperties)

+ (NSFetchRequest<Character *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Character"];
}

@dynamic charDescription;
@dynamic charID;
@dynamic innerID;
@dynamic name;
@dynamic thumbnailImageData;
@dynamic thumbnailURLString;
@dynamic thumbnailPath;
@dynamic thumbnailExtension;

// Gets count for all saved CoreData "Character" objects.
+ (NSInteger)allCharsCountWithContext:(NSManagedObjectContext *)managedObjectContext
{
    NSUInteger retVal;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Character" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *err;
    retVal = [managedObjectContext countForFetchRequest:request error:&err];
    
    if (err)
        XLog(@"Error: %@", [err localizedDescription]);
    
    return retVal;
}

// Returns a "Character" CoreData object for specified innerID attribute.
+ (Character *)charWithManagedObjectContext:(NSManagedObjectContext *)context andInnerID:(NSInteger)charInnerID
{
    Character *retVal = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Character" inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *searchFilter = [NSPredicate predicateWithFormat:@"innerID = %d", charInnerID];
    [request setPredicate:searchFilter];
    
    NSError *err;
    NSArray *results = [context executeFetchRequest:request error:&err];
    if (results.count > 0)
        retVal = [results objectAtIndex:0];
    
    if (err)
        XLog(@"Error: %@", [err localizedDescription]);
    
    return retVal;
}


#pragma mark - Getters & Setters

- (void)setThumbnailDictionary:(NSDictionary *)dict
{
    if (!dict)
        return;
    
    //_thumbnailDictionary = dict;
    self.thumbnailURLString = [NSString stringWithFormat:@"%@.%@", dict[@"path"], dict[@"extension"]];
}

- (NSDictionary *)thumbnailDictionary
{
    return self.thumbnailDictionary;
}



@end
