//
//  quadradinhoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 20/05/22.
//

import Foundation
import SwiftUI

struct quadradinhoDeCor: View {
    var body: some View {


RoundedRectangle(cornerRadius: 5)
    .frame(width: 55, height: 40, alignment: .center)
    .padding(.trailing, -6.0)
        
        
    }
}

        struct quadradinhoDeCor_Previews: PreviewProvider {
            static var previews: some View {
                quadradinhoDeCor()
            }
        }
