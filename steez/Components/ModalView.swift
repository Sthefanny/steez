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
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showingSheet: Bool
    @State private var name: String = ""
    @State private var quadradinhoClicked: PatternModel?
    @State private var bottomSheetPosition: ModalColorBottomSheetPosition = .middle
    @State private var colorPicked = UIColor.red
    @State private var lastIndex = 0
    @State private var showLoading = false
    
    @Binding var pattern: PatternModel
    
    let backgroundColors: [Color] = [Color.clear]
    
    @ViewBuilder
    var loadingView: some View {
        if showLoading {
            LoaderView(progressViewScaleSize: 3.0, title: "Conectando Dispositivo")
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            _buildTitle
            ColorList(pattern: $pattern, colors: $pattern.colors, showingSheet: $showingSheet)
            
            Spacer(minLength: 0)
        }
        .ignoresSafeArea()
        .padding(.top)
        .background(Color("cinzaescuro"))
        .alert(bleManager.connectionStatus.alertTitle, isPresented: $bleManager.shouldShowConnectionAlert, actions: {
            getAlertActions()
        }, message: {
            Text(bleManager.connectionStatus.alertMessage)
        })
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
    
    private func getAlertActions() -> some View {
        switch bleManager.connectionStatus {
        case .succes:
            return Button("Ok", role: .cancel) { }
        case .fail:
            return Button("Ok", role: .cancel) { }
        case .receiveError:
            return Button("Enviar novamente", role: .cancel) {
                savePattern()
            }
        case .didDisconnected:
            return Button("Reconectar", role: .cancel) {
                presentationMode.wrappedValue.dismiss()
                withAnimation{self.showLoading = true}
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
            }
        case .notFound:
            return Button("Ok", role: .cancel) {
                withAnimation{self.showLoading = false}
            }
        case .notAllowed:
            return Button("Abrir configurações", role: .cancel) {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        case .disconnected:
            return Button("Ok", role: .cancel) { }
        }
    }
    
    func savePattern() -> Void {
        
        let colors = pattern.colors.map{$0.color}
        bleManager.sendColors(colors)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(bleManager: BLEManager(), showingSheet: .constant(false), pattern: .constant(PatternModel(id: 0, name: "default", isActive: true, colors: [ColorModel(color: UIColor.red), ColorModel(color: UIColor.green), ColorModel(color: UIColor.blue)])))
    }
}
