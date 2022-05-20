//
//  saveButton.swift
//  steez
//
//  Created by Raquel Zocoler on 13/05/22.
//

import SwiftUI

struct saveButton: View {
    var body: some View {
        Button(action: {
            // What to perform
        }) {
            ZStack{
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 90, height: 42, alignment: .center)
                .foregroundColor(.white)
            Text("Salvar")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    
        }
        }
    }
}

struct saveButton_Previews: PreviewProvider {
    static var previews: some View {
        saveButton()
    }
}
