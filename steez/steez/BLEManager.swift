//
//  BLEManager.swift
//  bleTest
//
//  Created by Lucas Yoshio Nakano on 13/05/22.
//

import SwiftUI
import CoreBluetooth
import UIKit

struct Peripheral: Identifiable {
    let id: Int
    let name: String
}

class BLEManager: NSObject, ObservableObject {
    enum ConnectionStatus {
        case succes
        case fail
        case receiveError
        case didDisconnected
        case notFound
        case notAllowed
        case disconnected
        
        var alertTitle: String {
            switch self {
            case .succes:
                return "Dispositivo conectado"
            case .fail:
                return "Falha ao conectar"
            case .receiveError:
                return "Falha o salvar dados"
            case .didDisconnected:
                return "Dispositivo desconectado"
            case .notFound:
                return "Dispositivo não encontrado"
            case .notAllowed:
                return "Acesso ao Bluetooth não autorizado"
            case .disconnected:
                return ""
            }
        }
        
        var alertMessage: String {
            switch self {
            case .succes:
                return "Dispositivo pronto para uso."
            case .fail:
                return "Não foi possível estabelecer conexão com o dispositivo.\nTente novamente."
            case .receiveError:
                return "Não foi possível salvar os dados ao dispositivo.\nTente novamente."
            case .didDisconnected:
                return "Houve um problema com a conexão.\nConecte o dispositivo novamente para continuar."
            case .notFound:
                return "Não foi possível encontrar o dispositivo.\nReinicie-o e tente novamente."
            case .notAllowed:
                return "É preciso permitir a utilização do Bluetooth para utilizar o dispositivo.\nAcesse as configurações para autorizar."
            case .disconnected:
                return ""
            }
        }
    }
    
    @Published var bluetoothDenied = false
    @Published var peripherals = [Peripheral]()
    @Published var deviceConnected: () -> Void = {}
    @Published var shouldShowConnectionAlert = false
    @Published var connectionStatus: ConnectionStatus = .disconnected
    
    private let characteristicsUUID = CBUUID(string: "43D7CB06-EE4C-4718-BE3E-5654DB9B3795")
    private let serviceUUIDpartKey = "4775-A77B-680697671B20"
    private let controllerNameConstant = "Steez_Skateboard_Controller"
    
    private var inputChar: CBCharacteristic?
    private var myCentral: CBCentralManager!
    private var connectedPeripheral: CBPeripheral!
    private var timer = Timer()
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func startScanning() {
        shouldShowConnectionAlert = false
        connectionStatus = .disconnected
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        myCentral.scanForPeripherals(withServices: nil, options: nil)
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
    
    @objc func fireTimer() {
        shouldShowConnectionAlert.toggle()
        connectionStatus = .notFound
        timer.invalidate()
        myCentral.stopScan()
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bluetoothDenied = central.state == .poweredOn ? false : true
        if bluetoothDenied {
            connectionStatus = .notAllowed
            shouldShowConnectionAlert.toggle()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            if let uuid = dataServiceUUIDtoString(advertisementData[CBAdvertisementDataServiceUUIDsKey]) {
                if name == controllerNameConstant && uuid.contains(serviceUUIDpartKey) {
                    timer.invalidate()
                    connectionStatus = .succes
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
        peripheral.discoverServices(nil)
        deviceConnected()
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Did failt to connect to \(peripheral) with error \(error?.localizedDescription ?? "")")
        shouldShowConnectionAlert = true
        connectionStatus = .fail
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Did disconnected from \(peripheral)")
        shouldShowConnectionAlert = true
        connectionStatus = .didDisconnected
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
            }
            return
        }
        print("Error Sending Value: \(error.localizedDescription)")
        shouldShowConnectionAlert = true
        connectionStatus = .receiveError
    }
}
