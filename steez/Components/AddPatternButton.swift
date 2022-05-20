//
//  AddPatternButton.swift
//  steez
//
//  Created by Raquel Zocoler on 19/05/22.
//

import SwiftUI

struct AddPatternButton: View {
    var body: some View {
        HStack{
            ZStack{
        Circle()
            .frame(width: 24, height: 24, alignment: .center)
            .foregroundColor(.black)
        Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .bold))
            }
        Text("Adicionar Padrão")
                .font(.system(size: 12, weight: .bold))
        }
    }
}

struct AddPatternButton_Previews: PreviewProvider {
    static var previews: some View {
        AddPatternButton()
    }
}
