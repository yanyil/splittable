//
//  Service.swift
//  splittable
//
//  Created by Yan-Yi Li on 11/11/2016.
//  Copyright © 2016 Yan-Yi Li. All rights reserved.
//

import UIKit

class Service: NSObject, NSCoding {
    
    // MARK: Properties
    
    var sortOrder: String
    var name: String
    var url: String
    var imageURL: String
    
    // MARK: Archiving Paths
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("services")
    
    // MARK: Types
    
    struct PropertyKey {
        static let sortOrderKey = "sortOrder"
        static let nameKey = "name"
        static let urlKey = "url"
        static let imageURLKey = "imageURL"
    }
    
    // MARK: Initialization
    
    init(sortOrder: String, name: String, url: String, imageURL: String) {
        self.sortOrder = sortOrder
        self.name = name
        self.url = url
        self.imageURL = imageURL
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sortOrder, forKey: PropertyKey.sortOrderKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(url, forKey: PropertyKey.urlKey)
        aCoder.encode(imageURL, forKey: PropertyKey.imageURLKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let sortOrder = aDecoder.decodeObject(forKey: PropertyKey.sortOrderKey) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let url = aDecoder.decodeObject(forKey: PropertyKey.urlKey) as! String
        let imageURL = aDecoder.decodeObject(forKey: PropertyKey.imageURLKey) as! String
        
        self.init(sortOrder: sortOrder, name: name, url: url, imageURL: imageURL)
    }
    
}
