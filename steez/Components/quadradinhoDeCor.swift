//
//  quadradinhoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 20/05/22.
//

import Foundation
import SwiftUI

struct quadradinhoDeCor: View {
    @Binding var isClicked: Bool
    
    @State var isClickable: Bool
    @Binding var color: UIColor
    @State var clickedBorderColor: UIColor = UIColor.red
    @State var action: () -> Void = {}
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 5)
            .stroke(isClicked ? Color(clickedBorderColor) : Color(color), lineWidth: 5)
            .background(Color(color))
            .foregroundColor(Color(color))
            .frame(width: 50, height: 40, alignment: .center)
            .padding(.trailing, 2)
            .onTapGesture {
                if (isClickable) {
                    action()
                }
            }
        
    }
}

struct quadradinhoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        quadradinhoDeCor(isClicked: .constant(false), isClickable: true, color: .constant(UIColor.red), clickedBorderColor: UIColor.blue, action: {})
    }
}
