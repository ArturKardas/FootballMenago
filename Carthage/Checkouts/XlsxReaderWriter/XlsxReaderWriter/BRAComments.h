//
//  BRAComments.m
//  XlsxReaderWriter
//
//  Created by René BIGOT on 23/09/2015.
//  Copyright © 2015 BRAE. All rights reserved.
//

#import <XlsxReaderWriter/BRARelationship.h>
#import <XlsxReaderWriter/BRARelationships.h>
#import <XlsxReaderWriter/BRARelatedToColumnAndRowProtocol.h>

/** This class does not change the comments content.
 * It just handles rows and columns deletions / additions */

@interface BRAComments : BRARelationship <BRARelatedToColumnAndRowProtocol>

@property (nonatomic, strong) NSArray *comments;

@end
