//
//  CameraViewController.swift
//  Recipe
//
//  Created by Ria Buhlin on 2018-04-19.
//  Copyright © 2018 Ria Buhlin. All rights reserved.
//

import UIKit
import TesseractOCR
import CoreImage
import CoreData

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, G8TesseractDelegate {

    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var penBtn: UIButton!
    @IBOutlet weak var brushBtn: UIButton!
    @IBOutlet weak var markBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var magentaBtn: UIButton!
    @IBOutlet weak var lgBlueBtn: UIButton!
    
    @IBOutlet weak var canvas: UIImageView!
    var lastPoint = CGPoint (x: 0, y: 0)
    var firstPoint = CGPoint (x: 0, y: 0)
    var stopPoint = CGPoint (x: 0, y: 0)
    var swiped = false
    var color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1.0)
    
    var lgBlueColor = UIColor(red: 0, green: 180.0 / 255.0, blue: 1.0, alpha: 1.0)
    var magentaColor = UIColor(red: 190.0 / 255.0 , green: 48.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
    var greenColor = UIColor(red: 115.0 / 255.0, green: 250.0 / 255.0 , blue: 121.0 / 255.0, alpha: 1.0)
    
    @IBOutlet weak var brushLabel: UILabel!
    var brushSize = 0
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    
    var tempTitle = ""
    var tempCategory = ""
    var tempImage: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brushSize = 40
        
 
        

        
    }
    
    func addInfo(title: String, category: String) {
        tempTitle = title
        tempCategory = category
    }

    @IBAction func addPhoto(_ sender: Any) {
        
        let imagePickerActionSheet = UIAlertController(title: "Add photo", message: nil, preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       
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
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        imagePickerActionSheet.view.tintColor = UIColor.black
        present(imagePickerActionSheet, animated: true)
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
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
        brushLabel.isHidden = false
        plusBtn.isHidden = false
        minusBtn.isHidden = false
    }
    
    func stopEdditing() {
        self.penBtn.isHidden = true
        self.brushBtn.isHidden = true
        self.saveBtn.isHidden = true
        self.deleteBtn.isHidden = true
        self.markBtn.isHidden = true
        self.brushLabel.isHidden = true
        self.plusBtn.isHidden = true
        self.minusBtn.isHidden = true
    }
    
    @IBAction func savedClicked(_ sender: Any) {
        print("Title = \(String(describing: tempTitle))")
        print("Category = \(String(describing: tempCategory))")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managesContex = appDelegate.persistentContainer.viewContext
        
        let recipeDescription = NSEntityDescription.entity(forEntityName: "Recipe", in: managesContex)
        
        let recipe = NSManagedObject(entity: recipeDescription!, insertInto: managesContex) as! Recipe
        
        recipe.title = tempTitle
        recipe.category = tempCategory
        
        do {
            try managesContex.save()
        } catch {
            print(error)
        }
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        

        
        do {
            let results = try managesContex.fetch(fetchRequest)
            for r in results as! [Recipe] {
                print("\(String(describing: r.title!)) + \(String(describing: r.category!))")
            }
        } catch {
            print(error)
        }
  
    }
    
    @IBAction func brushClicked(_ sender: Any) {
 
    }
    
    @IBAction func palettClicked(_ sender: Any) {
      
        stopEdditing()
        markBtn.isHidden = false
        greenBtn.isHidden = false
        magentaBtn.isHidden = false
        lgBlueBtn.isHidden = false
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        let deleteSheet = UIAlertController(title: "Do you really want to delete?", message: nil, preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (alert) -> Void in
            
            self.addPhotoBtn.isHidden = false
            self.imageView.image = nil
            self.canvas.image = nil
            
            self.stopEdditing()
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
        contex?.setLineWidth(CGFloat(brushSize))
        contex?.setStrokeColor(color.cgColor)
        
        contex?.strokePath()
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func drawRect(_ fromPoint: CGPoint, _ toPoint: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size);
        
        let contexten:CGContext  = UIGraphicsGetCurrentContext()!;
        
        let rect = CGRect(x: (fromPoint.x - 20), y: (fromPoint.y - 20), width: ((toPoint.x - fromPoint.x) + 20), height: ((toPoint.y - fromPoint.y) + CGFloat(brushSize) ))
        
        contexten.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        contexten.stroke(rect)
        
      //  canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        runTessa(rect)
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
        }
    }
    
    func runTessa(_ rect: CGRect){
        if let tesseract = G8Tesseract(language: "eng+swe") {
            tesseract.pageSegmentationMode = .auto
            
            tesseract.delegate = self
            
            var outputImage = CIImage()
            var newUIImage = UIImage()

            let imagen = imageView.image
            let cgImagen = imagen?.cgImage
            let ciImagen = CIImage(cgImage: cgImagen!)
            let contex = CIContext(options: nil)
            
            outputImage = ciImagen
                .applyingFilter(
                    "CIColorControls",
                    parameters: [
                        kCIInputSaturationKey: 0
                    ])
                .applyingFilter(
                    "CIColorControls",
                    parameters: [
                        kCIInputContrastKey: 5
                    ])
                .applyingFilter(
                    "CINoiseReduction",
                    parameters: [
                        kCIInputSharpnessKey: 2
                    ])
            
            
            let cgimg = contex.createCGImage(outputImage, from: outputImage.extent)
            newUIImage = UIImage(cgImage: cgimg!)
           // imageView.image = newUIImage;
            
            tesseract.image = newUIImage.g8_blackAndWhite()
            
            tesseract.rect = rect
            
            tesseract.recognize()
            
            tempTitle = tesseract.recognizedText!
            print(tempTitle)
        }
    }
    
    
    func showColors() {
        greenBtn.isHidden = true
        magentaBtn.isHidden = true
        lgBlueBtn.isHidden = true
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        let index = sender.tag
        
        switch index {
        case 1:
            color = greenColor
            showColors()
            startEdditing()
        case 2:
            color = magentaColor
            showColors()
            startEdditing()
        case 3:
            color = lgBlueColor
            showColors()
            startEdditing()
        default:
            color = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
    @IBAction func changeSize(_ sender: UIButton) {
        let index = sender.tag
        
        switch index {
        case 1:
            brushSize -= 5
            brushLabel.text = String(brushSize)
        case 2:
            brushSize += 5
            brushLabel.text = String(brushSize)
        default:
            brushSize = 40
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVc = segue.destination as! PopUpViewController
        nextVc.secTempTitle = tempTitle
        nextVc.secTempCategory = tempCategory
        
        
    }
    
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        
        if sender.source is PopUpViewController {
            if let senderVC = sender.source as? PopUpViewController {
                tempTitle = senderVC.secTempTitle
                tempCategory = senderVC.secTempCategory
            }
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

