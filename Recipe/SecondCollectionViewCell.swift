//
//  SecondCollectionViewCell.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-13.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeThumb: UIImageView!
    var id: String?
    var recipeImage: UIImage?
}
