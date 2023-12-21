//
//  ManufacterEntity+CoreDataProperties.swift
//  Beer
//
//  Created by alumno on 12/12/23.
//
//

import Foundation
import CoreData


extension ManufacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManufacterEntity> {
        return NSFetchRequest<ManufacterEntity>(entityName: "ManufacterEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var logo: String?
    @NSManaged public var beers: NSOrderedSet?

}

// MARK: Generated accessors for beers
extension ManufacterEntity {

    @objc(insertObject:inBeersAtIndex:)
    @NSManaged public func insertIntoBeers(_ value: BeerEntity, at idx: Int)

    @objc(removeObjectFromBeersAtIndex:)
    @NSManaged public func removeFromBeers(at idx: Int)

    @objc(insertBeers:atIndexes:)
    @NSManaged public func insertIntoBeers(_ values: [BeerEntity], at indexes: NSIndexSet)

    @objc(removeBeersAtIndexes:)
    @NSManaged public func removeFromBeers(at indexes: NSIndexSet)

    @objc(replaceObjectInBeersAtIndex:withObject:)
    @NSManaged public func replaceBeers(at idx: Int, with value: BeerEntity)

    @objc(replaceBeersAtIndexes:withBeers:)
    @NSManaged public func replaceBeers(at indexes: NSIndexSet, with values: [BeerEntity])

    @objc(addBeersObject:)
    @NSManaged public func addToBeers(_ value: BeerEntity)

    @objc(removeBeersObject:)
    @NSManaged public func removeFromBeers(_ value: BeerEntity)

    @objc(addBeers:)
    @NSManaged public func addToBeers(_ values: NSOrderedSet)

    @objc(removeBeers:)
    @NSManaged public func removeFromBeers(_ values: NSOrderedSet)

}

extension ManufacterEntity : Identifiable {

}
