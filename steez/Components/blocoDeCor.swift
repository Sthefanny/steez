//
//  blocoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct blocoDeCor: View {
    var body: some View {
        
        
     
        Button(action: {
            // What to perform
        }) {
            VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 98, height: 74, alignment: .center)
                
                Text ("Nome da Cor")
                    .font(.system(size: 12))
                    .foregroundColor(.brown)
                    .fontWeight(.bold)
                    .frame(width: 95, height: 10, alignment: .leading)
                
                Text ("velocidade")
                    .font(.system(size: 12))
                    .foregroundColor(.brown)
                    .fontWeight(.regular)
                    .frame(width: 95, height: 10, alignment: .leading)
                
                    
                
            }
        }
     }
}

struct blocoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        blocoDeCor()
    }
}
