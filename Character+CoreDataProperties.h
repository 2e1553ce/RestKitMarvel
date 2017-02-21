//
//  Character+CoreDataProperties.h
//  Marvel
//
//  Created by aiuar on 09.02.17.
//  Copyright © 2017 A.V. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Character+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Character (CoreDataProperties)

+ (NSFetchRequest<Character *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *charDescription;
@property (nonatomic) int32_t charID;
@property (nonatomic) int32_t innerID;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *thumbnailImageData;
@property (nullable, nonatomic, copy) NSString *thumbnailURLString;
@property (nullable, nonatomic, copy) NSString *thumbnailPath;
@property (nullable, nonatomic, copy) NSString *thumbnailExtension;

@property (strong, nonatomic) NSDictionary *thumbnailDictionary;

// Получает число всех героев из базы
+ (NSInteger)allCharsCountWithContext:(NSManagedObjectContext *)managedObjectContext;
// Возвращает героя по его innerID.
+ (Character *)charWithManagedObjectContext:(NSManagedObjectContext *)context andInnerID:(NSInteger)charInnerID;

@end

NS_ASSUME_NONNULL_END
