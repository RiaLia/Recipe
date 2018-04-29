//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Ria Buhlin on 2018-04-28.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var image: NSData?
    @NSManaged public var thumbnail: NSData?

}
