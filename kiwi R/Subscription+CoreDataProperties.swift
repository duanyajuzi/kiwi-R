//
//  Subscription+CoreDataProperties.swift
//  
//
//  Created by jarvis on 2023/5/31.
//
//

import Foundation
import CoreData


extension Subscription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subscription> {
        return NSFetchRequest<Subscription>(entityName: "Subscription")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: URL?
    @NSManaged public var articles: Article?

}
