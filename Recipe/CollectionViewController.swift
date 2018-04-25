//
//  CollectionViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-11.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    
   
    let reuseIdentifier = "collectionCell" // also enter this string as the cell identifier in the storyboard
    var categories = ["All", "Bread", "Chicken", "Cookies & Cake", "Dessert", "Fish", "From around the world", "Holidays", "Meat", "Pasta", "Pie", "Stew", "Vegitarian"]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        let index = self.categories[indexPath.row]
        cell.categoryLabel.text = index
        cell.categoryImage.image = UIImage(named: index)
        cell.id = index
        
        cell.categoryImage.layer.borderWidth = 1
        cell.categoryImage.layer.borderColor = UIColor.gray.cgColor
        cell.categoryImage.layer.masksToBounds = true
        cell.categoryImage.layer.cornerRadius = 5
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
      //  print("You selected category: \(cell.id!)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
    }
}

/*


func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    self.performSegue(withIdentifier: "contentVideoSegue", sender: indexPath)
    
}


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "contentVideoSegue"{
        let selectedIndexPath = sender as? NSIndexPath
        let videoContentVC = segue.destination as! VideoContentController
        videoContentVC.text = items[selectedIndexPath.row] as String
    }
}
*/
