//
//  blocoDeCor.swift
//  steez
//
//  Created by Deborah Santos on 13/05/22.
//

import SwiftUI

struct blocoDeCor: View {
    
    @ObservedObject var bleManager: BLEManager
    
    var selectedPattern: Bool
    let screenSize = UIScreen.main.bounds.size
    @State private var showingSheet = false
    @State private var color = UIColor.red
    @State var pattern: PatternModel
    
    var body: some View {
        ZStack(alignment: .center){
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: screenSize.width - 40, height: 105, alignment: .center)
                .foregroundColor(selectedPattern ? .gray : .clear)
            
            VStack {
                Text ("Padrao 01")
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(width: screenSize.width - 40, height: 18, alignment: .topLeading)
                    .foregroundColor(.white)
                    .padding(.leading, 40)
                    .padding(.bottom, 10)
                
                HStack {
                    
                    ForEach (0..<pattern.colors.count) { i in
                        quadradinhoDeCor(isClicked: .constant(false), isClickable: true, color: $pattern.colors[i].color, action: {showingSheet = true})
                    }
                    
                }
                .padding(.bottom, 10)
            }
        }
        .onTapGesture {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
           HalfSheet {
               ModalView(bleManager: bleManager, pattern: $pattern)
                   .ignoresSafeArea()
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
}


struct blocoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        blocoDeCor(bleManager: BLEManager(), selectedPattern: true, pattern: PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue)]))
    }
}
