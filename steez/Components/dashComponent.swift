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
                .frame(width: 98, height: 74, alignment: .center)
                .foregroundColor(.black)
                .padding(.bottom, 5)
                
            Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.black)

                }
            Text("Adicione a cor")
                    .font(.system(size: 12))
                    .frame(width: 98, alignment: .leading)
                    .foregroundColor(.black)

        }
        }
    }
}


struct dashComponent_Previews: PreviewProvider {
    static var previews: some View {
        dashComponent()
    }
}
