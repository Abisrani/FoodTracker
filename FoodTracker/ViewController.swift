//
//  ViewController.swift
//  FoodTracker
//
//  Created by Abhishekkumar Israni on 2018-09-21.
//  Copyright © 2018 abisrani.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:Properties
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    // Handle the text field's user input through delegate callback
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //here self is refering to viewController class because its scope is inside within the class
        nameTextField.delegate = self
        
        }
   
        //MARK:UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //It will close the keyboard to remove its first responder status
        textField.resignFirstResponder()
        
        // return true means user will respond by pressing the return key after typing the text
        return true
        }
    
        //MARK: after the textFieldShouldReturn funct we need the below function because after resigning the first responder status the system calls this method
        func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
       }
    

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    
    }
    
    //The following function is used whenever a user select an image and wants to do something with the image.
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    guard let selectedImage = info[UIImagePickerControllerOriginalImage]as?  UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage

    
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    //gesture recognizers are the objects that allow to view to respond to a user the way a control does
    
    
    //here will attach a tap gesture in the view image i.e.UITapGestureRecognizer
    
    //MARK:Action method for gesture recognizer..i.e. when user taps the image
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //The following code is used because if the user is typing and he taps the image view the keyboard should disappear
        
        self.nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller used to select image from the library
        let imagePickerController = UIImagePickerController()
        
        //To select images only from gallery and not to click pictures and attach
        imagePickerController.sourceType = .photoLibrary
        
        
        //the following code is required to set the image picker controllers delegate just same as we did for text field
        imagePickerController.delegate = self
        
        
        //this method will ask view controller to view controller defined by imgaePickerController
        
        //complettion pararameter is a piece of code executes after this method is executed and since there is nothing to execute after this hence we pass nil parameter .
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        mealNameLabel.text="Default Text"
        
    }
}

