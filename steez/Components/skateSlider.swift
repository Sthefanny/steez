//
//  skateSlider.swift
//  steez
//
//  Created by Jessica Akemi Meguro on 19/05/22.
//

import SwiftUI

struct skateSlider: View {
    @ObservedObject var bleManager = BLEManager()
    @State private var goToHome = false
    @State private var showLoading = false
    
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
            Color.black
            Image("noise")
                .resizable()
                .scaledToFill()
            homeView
            loadingView
        }
        .ignoresSafeArea()
        .onAppear() { }
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
        .alert(bleManager.connectionStatus.alertTitle, isPresented: $bleManager.shouldShowConnectionAlert, actions: {
            getAlertActions()
        }, message: {
            Text(bleManager.connectionStatus.alertMessage)
        })
    }
    
    private func getAlertActions() -> some View {
        switch bleManager.connectionStatus {
        case .succes:
            return Button("Ok", role: .cancel) { }
        case .fail:
            return Button("Ok", role: .cancel) { }
        case .receiveError:
            return Button("Ok", role: .cancel) { }
        case .didDisconnected:
            return Button("Reconectar", role: .cancel) {
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
}

struct skateSlider_Previews: PreviewProvider {
    static var previews: some View {
        skateSlider()
    }
}
