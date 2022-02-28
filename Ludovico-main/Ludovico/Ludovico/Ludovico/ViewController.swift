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
    private var characteristics :CBCharacteristic?
    
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
        self.characteristics = characteristics[0]
    }
    
    //Mark: Function to write
    private func writeValueToChar( withValue value: Data) {
        guard let characteristic = self.characteristics else {return}

        if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {
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
        writeValueToChar( withValue: RobotActions.indicacionesSr)
    }
    
    @IBAction func ButtonTem(_ sender: Any) {
        print("Funciona Temperatura")
        writeValueToChar( withValue: RobotActions.temperaturaSr)
    }
    
    @IBAction func BrazoArriba(_ sender: Any) {
        print("Funciona BrazoArriba")
       
        writeValueToChar(withValue: RobotActions.brazosArribaSr)
    }
    
    @IBAction func BrazoAbajo(_ sender: Any) {
        print("Funciona BrazoAbajo")
        writeValueToChar(withValue: RobotActions.brazosAbajoSr)
    }
    
    @IBAction func Izquierda(_ sender: Any) {
        print("Funciona Izquierda")
        writeValueToChar( withValue: RobotActions.izquierdaSr)
    }
    
    @IBAction func Adelante(_ sender: Any) {
        print("Funciona Adelante ")
        writeValueToChar( withValue: RobotActions.adelanteSr)
    }
    
    @IBAction func Atras(_ sender: Any) {
        print("Funciona Atras")
        writeValueToChar( withValue: RobotActions.atrasSr)
    }
    
    @IBAction func Derecha(_ sender: Any) {
        print("Funciona Derecha")
        writeValueToChar( withValue: RobotActions.derechaSr)
    }
    
    @IBAction func BrazoDArriba(_ sender: Any) {
        print("Funciona BrazoDArriba")
        writeValueToChar(withValue: RobotActions.brazosDArribaSr)
    }
    
    @IBAction func BrazoDAbajo(_ sender: Any) {
        print("Funciona BrazoDAbajo")
        writeValueToChar( withValue: RobotActions.brazosDAbajoSr)
    }
    
    @IBAction func SI(_ sender: Any) {
        print("Funciona Si")
        
        writeValueToChar( withValue: RobotActions.siSr)
    }
    
    @IBAction func NO(_ sender: Any) {
        print("Funciona No")
        writeValueToChar(withValue: RobotActions.noSr)
    }
    
    @IBAction func Gel(_ sender: Any) {
        print("Funciona Gel")
        writeValueToChar( withValue: RobotActions.gelSr)
    }
}




    

