//
//  button.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct button1: View {
    
    var title: String
    var showBackgroundColor: Bool
    var changeColorTitle: Bool
    
    var body: some View {
      
        Button(action: {
            // What to perform
        }) {
            
         ZStack{
           RoundedRectangle (cornerRadius: 20)
                 .frame(width: 114, height: 34, alignment: .center)
                 .foregroundColor(showBackgroundColor ? .gray : .clear)
             
           Text (title)
                .fontWeight(.bold)
                .foregroundColor(changeColorTitle ? .white : .gray)
                .font(.system(size: 12))
                
            }
        }
    }
}

struct button1_Previews: PreviewProvider {
    static var previews: some View {
        button1(title: "IMPULSO", showBackgroundColor: true, changeColorTitle: true)
    }
}
