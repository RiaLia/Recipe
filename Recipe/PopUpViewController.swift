//
//  PopUpViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-23.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var editTitle: UITextField!
    
    @IBOutlet weak var editCategory: UITextField!
    
    var recipies : [String : Any] = [:]
    var defaults = UserDefaults.standard
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let maybeRecipies = defaults.dictionary(forKey: "Recipies") {
            recipies = maybeRecipies
        } else {
            recipies = [:]
        }
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true

    }


    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        recipies[editTitle.text!] = editCategory.text!
        
        addToDefaults(recipies: recipies)
        
        print(recipies)
  
        
    }
    
    func addToDefaults(recipies: [String: Any]) {
         defaults.set(recipies, forKey: "Recipies")
    }
   
}

