//
//  Note+CoreDataClass.swift
//  CoreDataExample
//
//  Created by apple on 19.02.2024.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

}

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Note : Identifiable {

}
