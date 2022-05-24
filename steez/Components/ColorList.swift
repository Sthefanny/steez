//
//  ColorList.swift
//  steez
//
//  Created by Sthefanny Gonzaga on 23/05/22.
//

import SwiftUI
import ColorPickerRing

struct ColorList: View {
    
    @Binding var pattern: PatternModel
    @Binding var colors: [ColorModel]
    @Binding var showingSheet: Bool
    @State private var quadradinhoClicked: UUID?
    @State private var colorPicked = UIColor.red
    @State private var lastIndex: UUID?
    
    var body: some View {
        
        VStack {
            ZStack {
                ColorPickerRing(color: $colorPicked, strokeWidth: 30)
                    .frame(width: 140, height: 140, alignment: .center)
                Circle()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(Color(colorPicked))
                
            }
            .padding(.bottom, 40)
    
            HStack {
                if colors.count < 5 {
                    dashComponent(action: {
                        print("before = \(colors.count)")
                        colors.append(ColorModel(color: colorPicked))
                        UserData().addPattern(id: pattern.id, value: pattern)
                        pattern = UserData().getPatternById(id: pattern.id)!
                        print("after = \(pattern.colors.count)")
                    })
                }
                
                ForEach ($colors) { actualColor in
                    HStack {
                        quadradinhoDeCor(isClicked: .constant(quadradinhoClicked == actualColor.id), isClickable: true, color: quadradinhoClicked == actualColor.id ? $colorPicked : actualColor.color, clickedBorderColor: UIColor.white, action: {
                            if lastIndex == nil {
                                lastIndex = actualColor.id
                            }
                            quadradinhoClicked = actualColor.id
                            let c = colors.first(where: {$0.id == lastIndex})
                            c?.color = colorPicked
                            lastIndex = actualColor.id
                        })
                        .padding(.horizontal, 5)
                    }
                }
            }
            
            saveButton(action: savePattern)
                .padding(.top, 30)
        }
    }
    
    func savePattern() -> Void {
        
        let c = colors.first(where: {$0.id == lastIndex})
        c?.color = colorPicked
        
        UserData().addPattern(id: pattern.id, value: pattern)
        
        pattern = UserData().getPatternById(id: pattern.id)!
        
        self.showingSheet.toggle()
        
        showingSheet = false
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ColorList(pattern: .constant(PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red)])), colors: .constant([ColorModel(color: UIColor.red)]), showingSheet: .constant(true))
    }
}
