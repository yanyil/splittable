//
//  Service.swift
//  splittable
//
//  Created by Yan-Yi Li on 10/11/2016.
//  Copyright © 2016 Yan-Yi Li. All rights reserved.
//

import UIKit

class Service {
    
    // MARK: Properties
    
    var sortOrder: String
    var name: String
    var url: String
    var imageURL: String
    
    // MARK: Initialization
    
    init(sortOrder: String, name: String, url: String, imageURL: String) {
        self.sortOrder = sortOrder
        self.name = name
        self.url = url
        self.imageURL = imageURL
    }
}
