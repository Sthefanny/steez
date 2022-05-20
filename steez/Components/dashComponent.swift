//
//  dashComponent.swift
//  steez
//
//  Created by Raquel Zocoler on 13/05/22.
//

import SwiftUI

struct dashComponent: View {
    var body: some View {
        Button(action: {
            // What to perform
        }) {
            VStack{
                ZStack{
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(style: StrokeStyle(lineWidth: 0.75, dash: [8]))
                .frame(width: 55, height: 40, alignment: .center)
                .foregroundColor(.white)
                .padding(.bottom, 5)
                
            Image(systemName: "plus")
                        .font(.system(size: 15))
                        .foregroundColor(.white)

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
