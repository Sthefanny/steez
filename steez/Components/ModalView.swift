//
//  ModalView.swift
//  steez
//
//  Created by Raquel Zocoler on 19/05/22.
//
import SwiftUI
import BottomSheet

//The custom BottomSheetPosition enum with absolute values.
enum ModalColorBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 600, bottom = 125, hidden = 0
}

struct ModalView: View {
    
    @ObservedObject var bleManager: BLEManager
    
    @Binding var showingSheet: Bool
    @State private var name: String = ""
    @State private var quadradinhoClicked: PatternModel?
    @State private var bottomSheetPosition: ModalColorBottomSheetPosition = .middle
    @State private var colorPicked = UIColor.red
    @State private var lastIndex = 0
    
    @Binding var pattern: PatternModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            _buildTitle
            ColorList(pattern: $pattern, colors: $pattern.colors, showingSheet: $showingSheet)
            
            Spacer(minLength: 0)
        }
        .ignoresSafeArea()
        .padding(.top)
        .background(Color("cinzaescuro"))
    }
    
    var _buildTitle: some View {
        TextField("", text: $name)
            .placeholder(when: name.isEmpty) {
                Text(pattern.name)
                    .foregroundColor(.white.opacity(0.5))
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 26, weight: .bold))
            .padding(.bottom, 40)
            .foregroundColor(.white)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(bleManager: BLEManager(), showingSheet: .constant(false), pattern: .constant(PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue)])))
    }
}
