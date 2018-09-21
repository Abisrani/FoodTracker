//
//  ViewController.swift
//  FoodTracker
//
//  Created by Abhishekkumar Israni on 2018-09-21.
//  Copyright © 2018 abisrani.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
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


    @IBAction func buttonAction(_ sender: UIButton) {
        
        mealNameLabel.text="Default Text"
        
    }
}

