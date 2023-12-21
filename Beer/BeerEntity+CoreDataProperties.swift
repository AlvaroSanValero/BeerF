//
//  BeerEntity+CoreDataProperties.swift
//  Beer
//
//  Created by alumno on 12/12/23.
//
//

import Foundation
import CoreData


extension BeerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeerEntity> {
        return NSFetchRequest<BeerEntity>(entityName: "BeerEntity")
    }

    @NSManaged public var beer: String?
    @NSManaged public var image: String?
    @NSManaged public var mannufacter: NSOrderedSet?

}

// MARK: Generated accessors for mannufacter
extension BeerEntity {

    @objc(insertObject:inMannufacterAtIndex:)
    @NSManaged public func insertIntoMannufacter(_ value: ManufacterEntity, at idx: Int)

    @objc(removeObjectFromMannufacterAtIndex:)
    @NSManaged public func removeFromMannufacter(at idx: Int)

    @objc(insertMannufacter:atIndexes:)
    @NSManaged public func insertIntoMannufacter(_ values: [ManufacterEntity], at indexes: NSIndexSet)

    @objc(removeMannufacterAtIndexes:)
    @NSManaged public func removeFromMannufacter(at indexes: NSIndexSet)

    @objc(replaceObjectInMannufacterAtIndex:withObject:)
    @NSManaged public func replaceMannufacter(at idx: Int, with value: ManufacterEntity)

    @objc(replaceMannufacterAtIndexes:withMannufacter:)
    @NSManaged public func replaceMannufacter(at indexes: NSIndexSet, with values: [ManufacterEntity])

    @objc(addMannufacterObject:)
    @NSManaged public func addToMannufacter(_ value: ManufacterEntity)

    @objc(removeMannufacterObject:)
    @NSManaged public func removeFromMannufacter(_ value: ManufacterEntity)

    @objc(addMannufacter:)
    @NSManaged public func addToMannufacter(_ values: NSOrderedSet)

    @objc(removeMannufacter:)
    @NSManaged public func removeFromMannufacter(_ values: NSOrderedSet)

}

extension BeerEntity : Identifiable {

}
