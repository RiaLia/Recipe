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
    
    var secTempTitle = ""
    var secTempCategory = ""
    var sender: UIViewController?
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !secTempTitle.isEmpty {
            editTitle.text = secTempTitle
        }
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true

    }


    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
       
        secTempTitle = editTitle.text!
        secTempCategory = editCategory.text!
        
    }
}

