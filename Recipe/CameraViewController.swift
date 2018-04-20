//
//  CameraViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-19.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func addPhoto(_ sender: Any) {
        
        let imagePickerActionSheet = UIAlertController(title: "Add photo", message: nil, preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       // imagePicker.allowsEditing = true
       
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "Choose From Gallery",
                                          style: .default) { (alert) -> Void in
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 2
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        // 3
        imagePickerActionSheet.view.tintColor = UIColor.black
        present(imagePickerActionSheet, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = originalImage.scaleImage(640)
        imageView.image = scaledImage
   
        picker.dismiss(animated: true, completion: nil)
        addPhotoBtn.isHidden = true
        approvePhoto()
        
    }
    
    
    func approvePhoto() {
        let photoApproveSheet = UIAlertController(title: "Approve Photo?", message: nil, preferredStyle: .actionSheet)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (alert) -> Void in
            print("Photo Approved")
            //self.startEdditing()
        }
        photoApproveSheet.addAction(okButton)
        
        let takeNewButton = UIAlertAction(title: "Take new!", style: .default) { (alert) -> Void in
            self.addPhoto(photoApproveSheet)
           
        }
        photoApproveSheet.addAction(takeNewButton)
        
        
        photoApproveSheet.view.tintColor = UIColor.black
        present(photoApproveSheet, animated: true)
    }
    

    
    
    
}








// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
 



