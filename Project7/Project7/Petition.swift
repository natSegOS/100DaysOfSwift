//
//  Petition.swift
//  Project7
//
//  Created by Nathan Segura on 3/10/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
