//
//  Meal.swift
//  FoodTracker
//
//  Created by Abhishekkumar Israni on 2018-09-25.
//  Copyright © 2018 abisrani.org. All rights reserved.
//


//  UIKit also gives you access to Foundation, we can remove the redundant import to Foundation.
import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
 
    
    // Initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup or initialization.
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
