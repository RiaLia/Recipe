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
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var penBtn: UIButton!
    @IBOutlet weak var brushBtn: UIButton!
    @IBOutlet weak var markBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    var defaults = UserDefaults.standard
    var recipies : [String : Any] = [:]
    
    @IBOutlet weak var canvas: UIImageView!
    var lastPoint = CGPoint (x: 0, y: 0)
    var firstPoint = CGPoint (x: 0, y: 0)
    var stopPoint = CGPoint (x: 0, y: 0)
    var swiped = false
    var color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1.0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
   
        
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
            let cameraButton = UIAlertAction(title: "Use Camera",
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
        
        let okButton = UIAlertAction(title: "Yes, Keep this one", style: .default) { (alert) -> Void in
            self.startEdditing()
        }
        photoApproveSheet.addAction(okButton)
        
        let takeNewButton = UIAlertAction(title: "No, Take new!", style: .default) { (alert) -> Void in
            self.addPhoto(photoApproveSheet)
           
        }
        photoApproveSheet.addAction(takeNewButton)
        
        
        photoApproveSheet.view.tintColor = UIColor.black
        present(photoApproveSheet, animated: true)
    }
    
    
    
    func startEdditing() {
        penBtn.isHidden = false
        brushBtn.isHidden = false
        markBtn.isHidden = false
        saveBtn.isHidden = false
        deleteBtn.isHidden = false
        
        
        // Skapa Pan, och ev pinch
       
        
    }
    
    
    @IBAction func savedClicked(_ sender: Any) {
        // Spara informationen på lämpligt ställe.
        // kanske i en array med dictioneries i CameraModel?
        // Keys borde då vara: Titel, Category, Image
        // För enkelhetes skull bör vara varje recept bara var i en kategori? 
        print("Saved Clicked")
    }
    
    @IBAction func brushClicked(_ sender: Any) {
         //Ta fram color palett
         // Pensel för titel
         // Spara ner makrering och kör tessa
        
        // Testa om det går att köra tessa i bakgrunden
        print("Brush Clicked")
        
        if let maybeRecipies = defaults.dictionary(forKey: "Recipies") {
            recipies = maybeRecipies
        } else {
            recipies = [:]
        }
        
       
        print(recipies)
       
    }
    
    @IBAction func penClicked(_ sender: Any) {
         
        
        print("Pen Clicked")
    }
    
    @IBAction func markClicked(_ sender: Any) {
        // Kvadratisk markering för tumbnail
        // Crop to mark
        print("Mark Clicked")
    }
    
    
    
    
    
    
    
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        let deleteSheet = UIAlertController(title: "Do you really want to delete?", message: nil, preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (alert) -> Void in
            
            self.addPhotoBtn.isHidden = false
            self.imageView.image = nil
            
            self.penBtn.isHidden = true
            self.brushBtn.isHidden = true
            self.markBtn.isHidden = true
            self.saveBtn.isHidden = true
            self.deleteBtn.isHidden = true
        }
        deleteSheet.addAction(yesButton)
        
        let noButton = UIAlertAction(title: "No", style: .default) { (alert) -> Void in

            
        }
        deleteSheet.addAction(noButton)
        
        
        deleteSheet.view.tintColor = UIColor.black
        present(deleteSheet, animated: true)
     
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        canvas.image = nil
        if let touch = touches.first {
            lastPoint = touch.location(in: canvas)
            firstPoint = touch.location(in: canvas)
            print("FirstPoint = \(firstPoint)")
        }
    }
    
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: canvas.frame.width, height: canvas.frame.height))
        let contex = UIGraphicsGetCurrentContext()
        
        contex?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        contex?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        contex?.setBlendMode(CGBlendMode.normal)
        contex?.setLineCap(CGLineCap.round)
        contex?.setLineWidth(40)
        contex?.setStrokeColor(color.cgColor)
        
        contex?.strokePath()
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    func drawRect(_ fromPoint: CGPoint, _ toPoint: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size);
        
        let contexten:CGContext  = UIGraphicsGetCurrentContext()!;
        
        let rect = CGRect(x: (fromPoint.x - 20), y: (fromPoint.y - 20), width: ((toPoint.x - fromPoint.x) + 20), height: ((toPoint.y - fromPoint.y) + 40 ))
        
        // Filling
      //  contexten.setFillColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
      //  contexten.fill(rect)
        
        // Frame
        contexten.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        contexten.stroke(rect)
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        // Run tessa with rect
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: canvas)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        if let touch = touches.first {
            stopPoint = touch.location(in: canvas)
            drawRect(firstPoint, lastPoint)
            print("StopPoint = \(stopPoint)")
        }
        
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        let index = sender.tag
        
        switch index {
        case 1:
            color = UIColor(red: 115.0 / 255.0, green: 250.0 / 255.0 , blue: 121.0 / 255.0, alpha: 1.0)
        case 2:
            color = UIColor(red: 190.0 / 255.0 , green: 48.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        case 3:
            color = UIColor(red: 0, green: 180.0 / 255.0, blue: 1.0, alpha: 1.0)
        default:
            color = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
}
    


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


/*

//
//  ViewController.swift
//  DemoDraw
//
//  Created by Ria Buhlin on 2018-04-25.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvas: UIImageView!
    var lastPoint = CGPoint (x: 0, y: 0)
    var firstPoint = CGPoint (x: 0, y: 0)
    var stopPoint = CGPoint (x: 0, y: 0)
    var swiped = false
    var color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        canvas.image = nil
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
            firstPoint = touch.location(in: self.view)
            print("FirstPoint = \(firstPoint)")
        }
    }
    
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let contex = UIGraphicsGetCurrentContext()
        
        contex?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        contex?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        contex?.setBlendMode(CGBlendMode.normal)
        contex?.setLineCap(CGLineCap.round)
        contex?.setLineWidth(40)
        contex?.setStrokeColor(color.cgColor)
        
        
        contex?.strokePath()
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    func drawRect(_ fromPoint: CGPoint, _ toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        
        let contexten:CGContext  = UIGraphicsGetCurrentContext()!;
        
        let rect = CGRect(x: (fromPoint.x - 20), y: (fromPoint.y - 20), width: ((toPoint.x - fromPoint.x) + 20), height: ((toPoint.y - fromPoint.y) + 40 ))
        
        // Filling
        contexten.setFillColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        contexten.fill(rect)
        
        // Frame
        contexten.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        contexten.stroke(rect)
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        // Run tessa with rect
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
            
            
        }
        
        if let touch = touches.first {
            stopPoint = touch.location(in: self.view)
            drawRect(firstPoint, lastPoint)
            
            print("StopPoint = \(stopPoint)")
        }
        
        
        
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        let index = sender.tag
        
        switch index {
        case 1:
            color = UIColor(red: 115.0 / 255.0, green: 250.0 / 255.0 , blue: 121.0 / 255.0, alpha: 1.0)
        case 2:
            color = UIColor(red: 190.0 / 255.0 , green: 48.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        case 3:
            color = UIColor(red: 0, green: 180.0 / 255.0, blue: 1.0, alpha: 1.0)
        default:
            color = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



*/
