//
//  ViewController.swift
//  Ludovico
//  Created by Jimenez Linares Suemy Ximena, Ramirez Cordero Joselyn on 20/01/22.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate{
    
    //Mark : Outlet for button and label
    @IBOutlet weak var indicaciones: UIButton!
    @IBOutlet weak var temperatura: UIButton!
    @IBOutlet weak var brazoArriba: UIButton!
    @IBOutlet weak var brazoAbajo: UIButton!
    @IBOutlet weak var izquierda: UIButton!
    @IBOutlet weak var adelante: UIButton!
    @IBOutlet weak var atras: UIButton!
    @IBOutlet weak var derecha: UIButton!
    @IBOutlet weak var brazoDArriba: UIButton!
    @IBOutlet weak var brazoDAbajo: UIButton!
    @IBOutlet weak var si: UIButton!
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var gel: UIButton!
    
    //Mark : Characteristics
    private var indicacionesChar: CBCharacteristic?
    private var temperaturaChar:CBCharacteristic?
    private var brazoArribaChar:CBCharacteristic?
    private var brazoAbajoChar:CBCharacteristic?
    private var izquierdaChar:CBCharacteristic?
    private var adelanteChar:CBCharacteristic?
    private var atrasChar:CBCharacteristic?
    private var derechaChar:CBCharacteristic?
    private var brazoDArribaChar:CBCharacteristic?
    private var brazoDAbajoChar:CBCharacteristic?
    private var siChar: CBCharacteristic?
    private var noChar:CBCharacteristic?
    private var gelChar:CBCharacteristic?
    
    // Mark : Connectors
    private var centralManager : CBCentralManager!
    private var peripheral: CBPeripheral!
    
    // Mark: Lifecicle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self,  queue:  nil)
    }
    
    // Mark: Bluetooth on
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
      if central.state == .poweredOn {
         let withServices = [
            ParticlePeripheral.particleLEDServiceUUID
         ]
          centralManager.scanForPeripherals(withServices: nil)
        }
    }
    
    // Mark: didDiscover peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            if  peripheral.identifier == UUID(uuidString: "E0270E9A-DCF9-470B-FFBF-579AF1BE1BE6") {
                self.centralManager.stopScan()
                // Copia de la instacia periférica
                self.peripheral = peripheral
                self.peripheral.delegate = self
                // Conectado
                self.centralManager.connect(self.peripheral, options: nil)
                    print(peripheral)
            }
    }
    
    //Mark: didConnect peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Conectado")
            peripheral.discoverServices(nil)
    }
    
    //Mark: did Disconnect Peripheral
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Desconectado")
    }
    
    //Mark: did Discover Services
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
          for  service in services {
              peripheral.discoverCharacteristics(nil, for: service)
           }
        }
    }
    
    //Mark: did Discover Characteristics For Service
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
        for charac in characteristics {
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.indicacionesSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.temperaturaSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.brazosArribaSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.brazosAbajoSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.izquierdaSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.adelanteSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.atrasSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.derechaSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.brazosDArribaSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.brazosDAbajoSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.siSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.noSr)
            writeValueToChar(withCharacteristic: charac, withValue: RobotActions.gelSr)
        }
    }
    
    //Mark: Function to write
    private func writeValueToChar( withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {
        if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {
            print("writeValue")
            peripheral.writeValue(value, for: characteristic, type: .withoutResponse)
        }
    }
    
    //Mark: did Update Value For Characteristic
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Estoy en didupdate")
    }
    
    // Mark: IBActions
    @IBAction func ButtonIndicaciones(_ sender: UIButton) {
        print("Funciona Temperatura")
        guard let characteristic = indicacionesChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.indicacionesSr)
    }
    
    @IBAction func ButtonTem(_ sender: Any) {
        print("Funciona Temperatura")
        guard let characteristic = temperaturaChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.temperaturaSr)
    }
    
    @IBAction func BrazoArriba(_ sender: Any) {
        print("Funciona BrazoArriba")
        guard let characteristic = brazoArribaChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.brazosArribaSr)
    }
    
    @IBAction func BrazoAbajo(_ sender: Any) {
        print("Funciona BrazoAbajo")
        guard let characteristic = brazoAbajoChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.brazosAbajoSr)
    }
    
    @IBAction func Izquierda(_ sender: Any) {
        print("Funciona Izquierda")
        guard let characteristic = izquierdaChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.izquierdaSr)
    }
    
    @IBAction func Adelante(_ sender: Any) {
        print("Funciona Adelante ")
        guard let characteristic = adelanteChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.adelanteSr)
    }
    
    @IBAction func Atras(_ sender: Any) {
        print("Funciona Atras")
        guard let characteristic = atrasChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.atrasSr)
    }
    
    @IBAction func Derecha(_ sender: Any) {
        print("Funciona Derecha")
        guard let characteristic = derechaChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.derechaSr)
    }
    
    @IBAction func BrazoDArriba(_ sender: Any) {
        print("Funciona BrazoDArriba")
        guard let characteristic = brazoDArribaChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.brazosDArribaSr)
    }
    
    @IBAction func BrazoDAbajo(_ sender: Any) {
        print("Funciona BrazoDAbajo")
        guard let characteristic = brazoDAbajoChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.brazosDAbajoSr)
    }
    
    @IBAction func SI(_ sender: Any) {
        print("Funciona Si")
        guard let characteristic = siChar else {return }
        writeValueToChar(withCharacteristic:characteristic, withValue: RobotActions.siSr)
    }
    
    @IBAction func NO(_ sender: Any) {
        print("Funciona No")
        guard let characteristic = noChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.noSr)
    }
    
    @IBAction func Gel(_ sender: Any) {
        print("Funciona Gel")
        guard let characteristic = gelChar else {return }
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.gelSr)
    }
}




    

