//
//  Meal.swift
//  FoodTracker
//
//  Created by Abhishekkumar Israni on 2018-09-25.
//  Copyright © 2018 abisrani.org. All rights reserved.
//


//  UIKit also gives you access to Foundation, we can remove the redundant import to Foundation.
import UIKit
import os.log
class Meal:NSObject , NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    
    
    //    encode(with aCoder: NSCoder)
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: - Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: - Archiving Paths
    
    /*
     The following lines of code explains ....
     The DocumentsDirectory constant uses the file manager’s urls(for:in:) method to look up the URL for your app’s documents directory.
     Here you will find one directory where you can store your apps data....
     for making your own directory, {we use DocumentsDirectory.appendingPathComponent("meals")}  i.e. "meals" in the end indicates the directory for our app...
 
    */
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!//this line determines the url for the directory....
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")// this line is used to create directory for our apps data...
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    /*
     Initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup or initialization......
     */
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
