//
//  ModalView.swift
//  steez
//
//  Created by Raquel Zocoler on 19/05/22.
//
import SwiftUI
import BottomSheet
import ColorPickerRing

//The custom BottomSheetPosition enum with absolute values.
enum ModalColorBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 600, bottom = 125, hidden = 0
}

struct ModalView: View {
    
    @ObservedObject var bleManager: BLEManager
    
    @State private var name: String = ""
    @State private var quadradinhoClicked: Int?
    @State private var bottomSheetPosition: ModalColorBottomSheetPosition = .middle
    @State private var colorPicked = UIColor.red
    @State private var lastIndex = 0
    
    @Binding var pattern: PatternModel
    
    let backgroundColors: [Color] = [Color.clear]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TextField("", text: $name)
                .placeholder(when: name.isEmpty) {
                    Text(pattern.name)
                        .foregroundColor(.white.opacity(0.5))
                }
                .multilineTextAlignment(.center)
                .font(.system(size: 26, weight: .bold))
                .padding(.bottom, 40)
                .foregroundColor(.white)
            
            
            ZStack {
                ColorPickerRing(color: $colorPicked, strokeWidth: 30)
                    .frame(width: 140, height: 140, alignment: .center)
                Circle()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(Color(colorPicked))
                
            }
            .padding(.bottom, 40)
            
            HStack{
                if pattern.colors.count < 5 {
                    dashComponent(action: {
                        print("before = \(pattern.colors.count)")
                        pattern.colors.append(ColorModel(color: colorPicked))
                        print("after = \(pattern.colors.count)")
                    })
                }
                
                ForEach (0..<pattern.colors.count) { i in
                    HStack {
                        quadradinhoDeCor(isClicked: .constant(quadradinhoClicked == i), isClickable: true, color: quadradinhoClicked == i ? $colorPicked : $pattern.colors[i].color, clickedBorderColor: UIColor.white, action: {
                            quadradinhoClicked = i
                            pattern.colors[lastIndex].color = colorPicked
                            lastIndex = i
                        })
                        .padding(.horizontal, 5)
                    }
                }
            }
            
            saveButton(action: savePattern)
                .padding(.top, 30)
            
            Spacer(minLength: 0)
        }
        .ignoresSafeArea()
        .padding(.top)
        .background(Color("cinzaescuro"))
    }
    
    func savePattern() -> Void {
        UserData().addPattern(id: pattern.id, value: pattern)
        
        let colors = pattern.colors.map{
            $0.color
        }
        
        bleManager.sendColors(colors)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(bleManager: BLEManager(), pattern: .constant(PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue)])))
    }
}
