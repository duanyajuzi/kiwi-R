//
//  Article+CoreDataProperties.swift
//  
//
//  Created by jarvis on 2023/5/31.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var summary: String?
    @NSManaged public var title: String?

}
