//
//  DetailViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-05-01.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    var recipeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.image = recipeImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
