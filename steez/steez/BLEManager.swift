//
//  BLEManager.swift
//  bleTest
//
//  Created by Lucas Yoshio Nakano on 13/05/22.
//

import Foundation
import CoreBluetooth
import UIKit

struct Peripheral: Identifiable {
    let id: Int
    let name: String
}

class BLEManager: NSObject, ObservableObject {
    @Published var isSwitchedOn = false // Bluetooth foi permitido pelo usuário
    @Published var peripherals = [Peripheral]() // Todos os devices conectados ao app
    
    private let characteristicsUUID = CBUUID(string: "43D7CB06-EE4C-4718-BE3E-5654DB9B3795")
    private let serviceUUIDpartKey = "4775-A77B-680697671B20"
    private let controllerNameConstant = "Steez_Skateboard_Controller"
    
    private var inputChar: CBCharacteristic?
    private var myCentral: CBCentralManager!
    private var connectedPeripheral: CBPeripheral!
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func startScanning() {
        myCentral.scanForPeripherals(withServices: nil, options: nil)
        
        // TODO: Início do scan, podemos colocar alguma representação visual para o usuário
    }
    
    func sendColors(_ value: [UIColor]) {
        guard value.count <= 5 else { return }
        guard let peripheral = connectedPeripheral, let inputChar = inputChar else { return }
        guard let jsonData = buildJsonData(value) else { return }
        peripheral.writeValue(jsonData, for: inputChar, type: .withoutResponse)
    }
}

private extension BLEManager {
    func dataServiceUUIDtoString(_ value: Any?) -> String? {
        let dataArray = value as? NSArray
        if let dataArray = dataArray, let cbuuid = dataArray.firstObject as? CBUUID {
            return cbuuid.uuidString
        } else {
            return nil
        }
    }
    
    func discoverCharacteristics(peripheral: CBPeripheral) {
        guard let services = peripheral.services else { return }
        for service in services {
            let CBUUIDsArray = [services.first?.uuid ?? CBUUID()]
            let connectedPeripherals = myCentral.retrieveConnectedPeripherals(withServices: CBUUIDsArray)
            for connectedPeripheral in connectedPeripherals {
                peripherals.append(Peripheral(id: peripherals.count, name: connectedPeripheral.name ?? "Unkown"))
            }
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func buildJsonData(_ value: [UIColor]) -> Data? {
        var colorsRGB: [String: [Int]] = [:]
        for (colorNum, colorValue) in value.enumerated() {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            colorValue.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            colorsRGB["Color\(colorNum + 1)"] = [Int(red * 255), Int(green * 255), Int(blue * 255)]
        }
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(colorsRGB) {
            return jsonData
        }
        return nil
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isSwitchedOn = central.state == .poweredOn ? true : false
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            if let uuid = dataServiceUUIDtoString(advertisementData[CBAdvertisementDataServiceUUIDsKey]) {
                if name == controllerNameConstant && uuid.contains(serviceUUIDpartKey) {
                    connectedPeripheral = peripheral
                    central.connect(peripheral)
                    central.stopScan()
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        print("Connected with \(peripheral)")
        // TODO: Device conectado, mostrar para o usuário que isso ocorreu ou prosseguir para próxima tela
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Did failt to connect to \(peripheral) with error \(error?.localizedDescription ?? "")")
        // TODO: Falha ao conectar ao device. Mostrar isso ao usuário
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Did disconnected from \(peripheral)")
        // TODO: Device desconectado. Travar todos os elementos que não podem ser navegados e mostrar ao usuário
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        print(services)
        discoverCharacteristics(peripheral: peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        print(characteristics)
        for characteristic in characteristics {
            switch characteristic.uuid {
            case characteristicsUUID:
                inputChar = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            default:
                break
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let error = error else {
            if let data = characteristic.value {
                let notification = String(data: data, encoding: .ascii)
                print(notification ?? "")
                // TODO: Cor foi recebida corretamento pelo ESP. Podemos dar dismiss no modal
            }
            return
        }
        print("Error Sending Value: \(error.localizedDescription)")
        // TODO: Falha ao receber a cor pelo ESP. Mostrar mensagem de erro ao usuário
    }
}
