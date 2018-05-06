//
//  FilterViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-05-02.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UISearchBarDelegate {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterText: String?
    var filterCategories: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        filterText = searchBar.text
        
        // Skicka med searchText och searchCat till 
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
