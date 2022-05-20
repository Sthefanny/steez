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
                       
                        

                    
                    
                    colorPickerComponent()
                    
                        saveButton()
                    .padding(.top, 50)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top)
            }
    }
}

////The gradient ButtonStyle.
//struct BookButton: ButtonStyle {
//
//    let colors: [Color]
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .font(.headline)
//            .foregroundColor(.white)
//            .padding()
//            .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
//    }
//}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
