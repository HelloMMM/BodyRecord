//
//  User+CoreDataProperties.swift
//  
//
//  Created by HellöM on 2020/6/29.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int32
    @NSManaged public var gender: Int32
    @NSManaged public var bodyWeight: Double
    @NSManaged public var bodyHeight: Double
    @NSManaged public var date: String

}
