//
//  dashComponent.swift
//  steez
//
//  Created by Raquel Zocoler on 13/05/22.
//

import SwiftUI

struct dashComponent: View {
    
    @State var action: () -> Void = {}
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(style: StrokeStyle(lineWidth: 0.75, dash: [8]))
                        .frame(width: 55, height: 45, alignment: .center)
                        .foregroundColor(.gray)
                        .padding(.trailing, 2)
                    
                    Image(systemName: "plus")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .frame(width: 55, height: 45, alignment: .center)
                }
                
                
            }
        }
    }
}


struct dashComponent_Previews: PreviewProvider {
    static var previews: some View {
        dashComponent()
    }
}
