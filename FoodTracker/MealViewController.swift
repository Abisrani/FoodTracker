//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Abhishekkumar Israni on 2018-09-21.
//  Copyright © 2018 abisrani.org. All rights reserved.
//

import UIKit
import os.log


 // The following MealViewCintroller is the subclass of the UIViewcontroller which inherits all the behavior

  class MealViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:Properties
    
    //// Reference variavle for views using view controller ..i.e. any change to the views will be done by this..
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    /// i.e. this var will store the value of the meal name, rating and image....
    var meal: Meal?
    
    
    // Handle the text field's user input through delegate callback
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //here self is refering to viewController class because its scope is within the class...
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal. here the meal property will only be non nil if the existed meal is updated
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        ////The following method will be used to..
        // Enable the Save button only if the text field has a valid Meal name.
        ////i.e. without the meal name you can't save update the meal, user should provide the valid name
        updateSaveButtonState()
        
        }
   
        //MARK:UITextFieldDelegate
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        ///following will be used when user is editing something after he presses the 'return' then the save button gets activated
        saveButton.isEnabled = false
        }
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ////It will close the keyboard to remove its first responder status....
        textField.resignFirstResponder()
        
        // return true means user will respond by pressing the return key after typing the text
        return true
        }
    
        //MARK: after the textFieldShouldReturn funct we need the below function because after resigning the first responder status the system calls this method
        func textFieldDidEndEditing(_ textField: UITextField) {
            updateSaveButtonState()
            navigationItem.title = textField.text
        
       }
    

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIImagePickerControllerDelegate
    ////this is a set of methods that your delegate object must implement to interact with the image picker interface....
    ///the following method will dismiss if a user cancels a picked(selected) image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    
    }
    
    ////The following function is used whenever a user select an image and wants to do something with the image.....
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    
    guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]as?  UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage

    
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
       
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
       
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
            
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
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
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty. i.e is we need to type somthing otherwise it won't allow us to save
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
