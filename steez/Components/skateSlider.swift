//
//  skateSlider.swift
//  steez
//
//  Created by Jessica Akemi Meguro on 19/05/22.
//

import SwiftUI

struct skateSlider: View {
    @ObservedObject var bleManager = BLEManager()
    @State var goToHome = false
    @State var showLoading = false
    
    @ViewBuilder
    var homeView: some View {
        if goToHome {
            HomeView(bleManager: bleManager)
        } else {
            OnBoardScreen()
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        if showLoading {
            LoaderView(progressViewScaleSize: 3.0, title: "Conectando Dispositivo")
        }
    }
    
    var body: some View {
        ZStack {
            homeView
            loadingView
        }
        .onAppear() {
            
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Success")), perform: { _ in
            UserData().reset()
            bleManager.startScanning()
            withAnimation{self.showLoading = true}
            bleManager.deviceConnected = {
                withAnimation{self.showLoading = false}
                let activePattern = UserData().getActivePattern()
                if (activePattern != nil) {
                    let colors = activePattern!.colors.map{
                        $0.color
                    }
                    bleManager.sendColors(colors)
                }
                withAnimation{self.goToHome = true}
            }
        })
        .alert("Dispositivo não encontrado", isPresented: $bleManager.presentDeviceNotFoundAlert, actions: {
            Button("Ok", role: .cancel) {
                withAnimation{self.showLoading = false}
            }
        }, message: {
            Text("Não foi possível encontrar o dispositivo.\nReinicie-o e tente novamente")
        })
        .alert("Acesso ao Bluetooth não autorizado", isPresented: $bleManager.bluetoothDenied, actions: {
            Button("Abrir configurações", role: .cancel) {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }, message: {
            Text("É preciso permitir a utilização do Bluetooth para utilizar o dispositivo.\nAcesse as configurações para autorizar.")
        })

    }
}

struct skateSlider_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            skateSlider()
        }
    }
}
