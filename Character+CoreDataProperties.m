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

@end
