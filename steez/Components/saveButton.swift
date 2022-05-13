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
                .frame(width: 80, height: 32, alignment: .center)
                .foregroundColor(.black)
            Text("Salvar")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    
        }
        }
    }
}

struct saveButton_Previews: PreviewProvider {
    static var previews: some View {
        saveButton()
    }
}
