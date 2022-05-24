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
    @State var onActivate: () -> Void
    @State var onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .center){
            
            RoundedRectangle(cornerRadius: 5)                .foregroundColor(selectedPattern ? .gray : .clear)
            
            VStack {
                Text (pattern.name)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(width: screenSize.width - 80, height: 18, alignment: .topLeading)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                HStack {
                    
                    ForEach ($pattern.colors) { actualColor in
                        HStack {
                            quadradinhoDeCor(isClicked: .constant(false), isClickable: true, color: actualColor.color, action: {
                                showingSheet = true
                            })
                        }
                    }
                    
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
        .onTapGesture {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
            HalfSheet {
                ModalView(bleManager: bleManager, showingSheet: $showingSheet, pattern: $pattern)
                    .ignoresSafeArea()
            }
        }
        .swipeActions (allowsFullSwipe: false) {
            
            Button(role: .destructive) {
                print("deletar")
                onDelete()
            } label: {
                Label("Deletar", systemImage: "trash.fill")
            }
            
            Button(role: .destructive) {
                print("ativar")
                onActivate()
            } label: {
                Label("Ativar", systemImage: "square.and.pencil")
            }
            .tint(.indigo)
            
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        
    }
}


struct blocoDeCor_Previews: PreviewProvider {
    static var previews: some View {
        blocoDeCor(bleManager: BLEManager(), selectedPattern: true, pattern: PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue)]), onActivate: {}, onDelete: {})
    }
}
