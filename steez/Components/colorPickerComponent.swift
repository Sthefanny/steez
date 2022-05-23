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
                .frame(width: 140, height: 140, alignment: .center)
            Circle()
                .frame(width: 80, height: 80, alignment: .center)
                .foregroundColor(Color(color))
        }
    }
}

struct colorPickerComponent_Previews: PreviewProvider {
    static var previews: some View {
        colorPickerComponent()
    }
}
