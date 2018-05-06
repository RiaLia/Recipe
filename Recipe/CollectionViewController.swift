//
//  CollectionViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-11.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    
   
    let reuseIdentifier = "collectionCell"
    var categories = ["All", "Bread", "Chicken", "Cookies & Cake", "Dessert", "Fish", "From around the world", "Holidays", "Meat", "Pasta", "Pie", "Stew", "Vegitarian"]
    
    
    // MARK: - UICollectionViewDataSource protocol

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

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
        
        performSegue(withIdentifier: "toRecipes", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        guard let indexPath = sender as? IndexPath else { return }

//        let navVC = segue.destination as! UINavigationController
//        let secVC = navVC.viewControllers[0] as? SecondCollectionViewController
        
        let secVC = segue.destination as? SecondCollectionViewController
        secVC?.title = categories[indexPath.item]
        secVC?.category = categories[indexPath.item]
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
