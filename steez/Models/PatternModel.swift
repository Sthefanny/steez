//
//  PatternModel.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import Foundation
import UIKit

class PatternModel: Identifiable, Codable {
    var id: Int
    var name: String
    var isActive: Bool
    var colors: [ColorModel]

    
    init (id: Int, name: String, isActive: Bool, colors : [ColorModel]) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.colors = colors
    }
}
