//
//  blocoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct blocoDeCor: View {
    
    var selectedPattern: Bool
    
    var body: some View {
        
        
        
      List{
            
            ZStack(alignment: .center){
                
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 326, height: 95)
                    .foregroundColor(selectedPattern ? .gray : .clear)
                
                VStack {
                    Text ("Padrao 01")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(width: 270, height: 18, alignment: .topLeading)
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
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        //        .listRowInsets(EdgeInsets())
        //        .background(Color.clear)
        .onTapGesture {
            print("clicado")
        }
        
    }
}


struct blocoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        blocoDeCor(selectedPattern: true)
    }
}
