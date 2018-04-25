//
//  Model.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-23.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import Foundation


 class CameraModel {
    
 var titles: [Recipe]?
 
 func addRecipe(_ recipe: Recipe) {
  
 if titles == nil {
    titles = []
    
        }
 titles?.append(recipe)
    }
 
 }
 
 
 class Recipe {
    var title: String?
    var category: String?
 }




