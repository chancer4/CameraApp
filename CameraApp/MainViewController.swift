//
//  MainViewController.swift
//  CameraApp
//
//  Created by Chance Rhodes on 12/2/15.
//  Copyright © 2015 Chance Rhodes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: "zoomImage")
        gesture.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(gesture)
        self.scrollView.delegate = self
    }
    
    private var currentZoom : CGFloat = 1.0
    
    func zoomImage() {
        if self.currentZoom == 1.0{
            self.currentZoom = 2.0
        }
        else{
            self.currentZoom = 1.0
        }
        UIView.animateWithDuration(0.5) { [unowned self] in 
        self.scrollView.minimumZoomScale = self.currentZoom
        self.scrollView.maximumZoomScale = self.currentZoom
        self.scrollView.zoomScale = self.currentZoom
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.displayImageView
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage,
        editingInfo: [String : AnyObject]?) {
            self.displayImageView.image = image
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func cameraButtonTouched(sender: UIBarButtonItem) {
        self.displayImagePicker(.Camera)
    }
    
    @IBAction func actionButtonTouched(sender: UIBarButtonItem) {
        if let image = self.displayImageView.image{
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil);
            
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            
            
            self.presentViewController(activityViewController, animated: true,
                completion:nil)
        }
        
    }
    
    @IBAction func libraryButtonTouched(sender: UIBarButtonItem) {
        self.displayImagePicker(.PhotoLibrary)
        
    }
    @IBOutlet weak var displayImageView: UIImageView!
    
    func displayImagePicker(sType:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sType
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
}
