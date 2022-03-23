//
//  Person.swift
//  Project10
//
//  Created by Nathan Segura on 3/22/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
