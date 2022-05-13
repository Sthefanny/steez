//
//  colorPickerComponent.swift
//  steez
//
//  Created by Jessica Akemi Meguro on 13/05/22.
//

import SwiftUI
import ColorPickerRing

struct colorPickerComponent: View {
    
    @State var color = UIColor.red
    
    var body: some View {
        ZStack {
            ColorPickerRing(color: $color, strokeWidth: 30)
                .frame(width: 300, height: 300, alignment: .center)
            Circle()
                .frame(width: 120, height: 120, alignment: .center)
                .foregroundColor(Color(color))
        }
    }
}

struct colorPickerComponent_Previews: PreviewProvider {
    static var previews: some View {
        colorPickerComponent()
    }
}
