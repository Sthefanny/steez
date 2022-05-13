//
//  button.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct button1: View {
    var body: some View {
      
        Button(action: {
            // What to perform
        }) {
            
         ZStack{
           RoundedRectangle (cornerRadius: 20)
                 .frame(width: 114, height: 34, alignment: .center)
                 .foregroundColor(.gray)
             
           Text ("VELOCIDADE")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 12))
                
            }
        }
    }
}

struct button1_Previews: PreviewProvider {
    static var previews: some View {
        button1()
    }
}
