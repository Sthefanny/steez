//
//  ContentView.swift
//  bleTest
//
//  Created by Lucas Yoshio Nakano on 13/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        VStack {
            Spacer()
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                }
            }
            .frame(height: 300)
            .padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    bleManager.startScanning()
                }) {
                    Text("Start scanning")
                }
                Spacer()
                Button(action: {
                    bleManager.sendColors([UIColor.green, UIColor.red, UIColor.cyan, UIColor.brown, UIColor.clear])
                }) {
                    Text("Send color")
                }
                Spacer()
            }
            Spacer()
            if bleManager.isSwitchedOn {
                Text("Bluetooth is switched on")
                    .foregroundColor(.green)
            }
            else {
                Text("Bluetooth is NOT switched on")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bleManager: BLEManager())
    }
}
