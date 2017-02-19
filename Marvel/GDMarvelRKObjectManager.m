//
//  GDMarvelRKObjectManager.m
//  Marvel
//
//  Created by aiuar on 09.02.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#define MARVEL_API_PATH_PATTERN @"v1/public/"
#define MARVEL_PRIVATE_KEY @"0b3c6789fb85fd573a2b86989a2663266bb915f5"
#define MARVEL_PUBLIC_KEY @"24c3faed94e764a6509460481b519f89"

#import "GDMarvelRKObjectManager.h"
#import "NSString+MD5.h"

@interface GDMarvelRKObjectManager ()

@property (strong, nonatomic) RKObjectManager *objectManager;
@property (strong, nonatomic) RKManagedObjectStore *managedObjectStore;

@end

@implementation GDMarvelRKObjectManager

- (id)init {
    
    self = [super init];
    
    if(self) {
        // Инициализация AFNetworking HTTPClient
        NSURL *baseURL = [NSURL URLWithString:@"http://gateway.marvel.com/"];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        //Инициализация RKObjectManager
        self.objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    }
    
    return self;
}

- (void)configureWithManagedObjectModel:(NSManagedObjectModel *)managedObjectModel {
    
    if (!managedObjectModel)
        return;
    
    self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error;
    if (!RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error))
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKMarvel.sqlite"];
    if (![self.managedObjectStore addSQLitePersistentStoreAtPath:path
                                     fromSeedDatabaseAtPath:nil
                                          withConfiguration:nil options:nil error:&error])
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    
    [self.managedObjectStore createManagedObjectContexts];
    //self.objectManager.managedObjectStore = self.managedObjectStore;
}

- (void)addMappingForEntityForName:(NSString *)entityName
andAttributeMappingsFromDictionary:(NSDictionary *)attributeMappings
       andIdentificationAttributes:(NSArray *)ids
                    andPathPattern:(NSString *)pathPattern {
    if (!self.managedObjectStore)
        return;
    
    RKEntityMapping *objectMapping = [RKEntityMapping mappingForEntityForName:entityName
                                                         inManagedObjectStore:self.managedObjectStore];
    // Указываем, какие атрибуты должны мапиться.
    [objectMapping addAttributeMappingsFromDictionary:attributeMappings];
    // Указываем, какие атрибуты являются идентификаторами. Важно для того, чтобы не было дубликатов в локальной базе.
    objectMapping.identificationAttributes = ids;
    
    // Создаем дескриптор ответа, ориентируясь на формат ответов нашего сервера и добавляем его в менеджер.
    RKResponseDescriptor *characterResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:[NSString stringWithFormat:@"%@%@", MARVEL_API_PATH_PATTERN, pathPattern]
                                                keyPath:@"data.results"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [self.objectManager addResponseDescriptor:characterResponseDescriptor];
}

- (void)getMarvelObjectsAtPath:(NSString *)path
                    parameters:(NSDictionary *)params
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
    // Подготовка нужных параметров
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStampString = [formatter stringFromDate:[NSDate date]];
    
    NSString *hash = [[[NSString stringWithFormat:@"%@%@%@", timeStampString, MARVEL_PRIVATE_KEY, MARVEL_PUBLIC_KEY] MD5String] lowercaseString];
    
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:@{@"apikey" : MARVEL_PUBLIC_KEY,
                                                                                       @"ts" : timeStampString,
                                                                                       @"hash" : hash}];
    if (params)
        [queryParams addEntriesFromDictionary:params];
    
    // Непосредственный вызов метода у объекта objectManager с вновь собранными параметрами
    [self.objectManager getObjectsAtPath:[NSString stringWithFormat:@"%@%@", MARVEL_API_PATH_PATTERN, path]
                         parameters:queryParams
                            success:success
                            failure:failure];
}

#pragma mark - Singleton Accessor

+ (GDMarvelRKObjectManager *)manager
{
    static GDMarvelRKObjectManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[GDMarvelRKObjectManager alloc] init];
    });
    return manager;
}

@end
