//
//  blocoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct blocoDeCor: View {
    var body: some View {
        
        
        
        List {
            

            ZStack{
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 326, height: 95, alignment: .center)
                    .foregroundColor(.gray)
                
                
                VStack{
                    Text ("Padrao 01")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(width: 270, height: 18, alignment: .leading)
                        .foregroundColor(.white)
                    
                    HStack{
                        
                        
                        ForEach (1..<6) { i in
                            quadradinhoDeCor()
                        }
                        
                        
                    }
                }
            }
            .swipeActions (allowsFullSwipe: false) {
                
                Button(role: .destructive) {
                    print("editar")
                } label: {
                    Label("Editar", systemImage: "square.and.pencil")
                }
                .tint(.indigo)
                
                Button(role: .destructive) {
                    print("deletar")
                } label: {
                    Label("Deletar", systemImage: "trash.fill")
                        
                }
                
            }
            .listRowBackground(Color.gray)
        }
        .onTapGesture {
            print("clicado")
        }
        
    }
}


struct blocoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        blocoDeCor()
    }
}
