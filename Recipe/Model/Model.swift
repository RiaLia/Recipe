//
//  Model.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-23.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import Foundation


class CameraModel {
    
 var titles: [Recipes]?
 
 func addRecipe(_ recipe: Recipes) {
  
 if titles == nil {
    titles = []
    
        }
 titles?.append(recipe)
    }
    
    
    func addInfo(title: String, category: String) {
        let recipes = Recipes()
        recipes.title = title
        recipes.category = category
        titles?.append(recipes)
    }
 
 }
 
 
 class Recipes {
    var title: String?
    var category: String?
    
 }




