//
//  Recipe+CoreDataProperties.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-29.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
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
