//
//  SecondCollectionViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-13.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit
import CoreData



class SecondCollectionViewController: UICollectionViewController {

    
    
    let reuseIdentifier = "Cell"
    var category: String!

    var filterText: String?
    var filterCategories: [Int] = []
    var useFilter = false
 
    var recipes: [Recipe] = []
    var searchResult: [String] = []

 
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managesContex = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        fetchRequest.returnsObjectsAsFaults = false
        

        if category != "All" {
            let filter = category
            let predicate = NSPredicate(format: "category = %@", filter!)
            fetchRequest.predicate = predicate
        }
        
        do {
            let results = try managesContex.fetch(fetchRequest)
            recipes = results as! [Recipe]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if useFilter {
            collectionView?.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SecondCollectionViewCell
    
        let recipe = recipes[indexPath.item]
        
        
        cell.recipeTitle.text = recipe.value(forKey: "title") as? String
        cell.id = recipe.value(forKey: "title") as? String
        if let data = recipe.thumbnail as Data? {
                cell.recipeThumb.image = UIImage(data: data)
            
        if let datan = recipe.image as Data? {
                cell.recipeImage = UIImage(data: datan)
            }
        }
        
        cell.layer.borderColor = UIColor.gray.cgColor
        
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      //  performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "filterSegue" {
            
        } else {
            if let cell = sender as? SecondCollectionViewCell {
            let detailVc = segue.destination as? DetailViewController
                detailVc?.title = cell.id
                detailVc?.recipeImage = cell.recipeImage
            } else {
                print("Something is wrong with the cell")
            }
        }
    }
    

    @IBAction func unwindFromFilter(_ sender: UIStoryboardSegue) {
        if sender.source is FilterViewController {
            if let senderVC = sender.source as? FilterViewController {
                filterText = senderVC.filterText
                filterCategories = senderVC.filterCategories
                useFilter = true
  
            }
        }
        
    }
    
}


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


