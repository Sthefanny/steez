//
//  ModalView.swift
//  steez
//
//  Created by Raquel Zocoler on 19/05/22.
//
import SwiftUI
import BottomSheet

//The custom BottomSheetPosition enum with absolute values.
enum BookBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 601, bottom = 125, hidden = 0
}

struct BookDetailView: View {
    @State private var name: String = ""
    @State var bottomSheetPosition: BookBottomSheetPosition = .middle
    @Binding var test: UIColor
    @State var quadradinhoCliked: Int
    
    let backgroundColors: [Color] = [Color(red: 0.1, green: 0.1, blue: 0.1)]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, options: [.noDragIndicator, .allowContentDrag, .swipeToDismiss, .tapToDismiss, .absolutePositionValue, .background({ AnyView(Color("cinzaEscuro")) })], headerContent: {
            }) {
            
                
                VStack(alignment: .center, spacing: 0) {
                TextField("", text: $name)
                        .placeholder(when: name.isEmpty) {
                            Text("Nome do seu padrão")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .multilineTextAlignment(.center)
                        .font(.system(size: 26, weight: .bold))
                        .padding(.bottom, 40)
                        .foregroundColor(.white)
                   
                    colorPickerComponent(color: test)
                        .padding(.bottom, 40)
                    
                    HStack{
                    dashComponent()
                    ForEach (1..<6) { i in
                        quadradinhoDeCor(isCliked: quadradinhoCliked == i, color: quadradinhoCliked == i ? UIColor.green : UIColor.black)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                quadradinhoCliked = i
                            }
                                            }
                    }
                    
                    saveButton()
                    .padding(.top, 30)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top)
            }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(test: .constant(UIColor.red), quadradinhoCliked: 0)
    }
}
