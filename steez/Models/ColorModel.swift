//
//  ColorModel.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 22/05/22.
//

import Foundation
import UIKit

class ColorModel: Identifiable, Codable {
    var id = UUID()
    @CodableColor var color : UIColor
    
    
    init (color: UIColor) {
        self.color = color
    }
}
