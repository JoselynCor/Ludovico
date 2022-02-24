//
//  ViewController.swift
//  Ludovico
//
//  Created by LDCBI on 20/01/22.
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
    
    private var centralManager : CBCentralManager!
    private var peripheral: CBPeripheral!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self,  queue:  nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
      if central.state == .poweredOn {
         let withServices = [
            ParticlePeripheral.particleLEDServiceUUID
          //  ParticlePeripheral.indicacionesCharacteristicUUID,
          //  ParticlePeripheral.temperaturaCharacteristicUUID
         ]
          centralManager.scanForPeripherals(withServices: nil)
        }
    }
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
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Conectado")
        //if self.peripheral == peripheral{
           // let services = [
              /* ParticlePeripheral.particleLEDServiceUUID,
               ParticlePeripheral.indicacionesCharacteristicUUID,
               ParticlePeripheral.temperaturaCharacteristicUUID*/
            //]
            //let service = CBUUID(string: "E0270E9B-DCF9-470B-FFBF-579AF1BE1BE6")
            peripheral.discoverServices(nil)
            
        
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Desconectado")
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
       
        print("services")
        if let services = peripheral.services {
        print("services2:\(services)")
          for service in services {
              if service.uuid == ParticlePeripheral.services2UUID{
                  peripheral.discoverCharacteristics(nil, for: service)}
              
    
               /* if service.uuid == ParticlePeripheral.particleLEDServiceUUID {
                    print("Servicio Led encontrado")
                    // EL descubrimiento de características
                    peripheral.discoverCharacteristics([ParticlePeripheral.indicacionesCharacteristicUUID,
                                                        ParticlePeripheral.temperaturaCharacteristicUUID,
                                                        ParticlePeripheral.adelanteCharacteristicUUID,
                                                        ParticlePeripheral.atrasCharacteristicUUID,
                                                        ParticlePeripheral.brazosAbajoCharacteristicUUID,
                                                        ParticlePeripheral.brazosArribaCharacteristicUUID,
                                                        ParticlePeripheral.brazosDAbajoCharacteristicUUID,
                                                        ParticlePeripheral.brazosDArribaCharacteristicUUID,
                                                        ParticlePeripheral.izquierdaCharacteristicUUID,
                                                        ParticlePeripheral.derechaCharacteristicUUID,
                                                        ParticlePeripheral.siCharacteristicUUID,
                                                        ParticlePeripheral.noCharacteristicUUID,
                                                        ParticlePeripheral.gelCharacteristicUUID], for: service)
                }*/
                return
            }
        }
     //   peripheral.discoverCharacteristics(<#T##characteristicUUIDs: [CBUUID]?##[CBUUID]?#>, for: <#T##CBService#>)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else {return}
        
        for characteristic in characteristics {
            print(characteristic)
            
            if  characteristic.properties.contains(.read){
                print("\(characteristic.uuid): properties contains .read")
            }
            if  characteristic.properties.contains(.notify){
                print("\(characteristic.uuid): properties contains .notify")
            }
        }
           /* if characteristic.uuid == SystemIDCharacteristicCbuuid {
                print("Botón Indicaciones")
                indicacionesChar = characteristic
            }
            if characteristic.uuid == ModelCharacacteristticCBUUID {
                print("Botón gel")
                gelChar = characteristic
            }
            if characteristic.uuid == SerialCharacacteristticCBUUID {
                print("Botón temperatura")
                temperaturaChar = characteristic
            }
            if characteristic.uuid == FirmwareCharacacteristticCBUUID {
                print("Botón Si")
                siChar = characteristic
            }
        }*/
        /*if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == ParticlePeripheral.indicacionesCharacteristicUUID{
                    print("Botón Indicaciones")
                    indicacionesChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.temperaturaCharacteristicUUID {
                    print("Botón Temperatura")
                    temperaturaChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.brazosArribaCharacteristicUUID {
                    print("Botón Brazo Izquierdo Arriba ")
                    brazoArribaChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.brazosAbajoCharacteristicUUID {
                    print("Botón Brazo Izquierdo Abajo ")
                    brazoAbajoChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.izquierdaCharacteristicUUID{
                    print("Botón Izquierda ")
                    izquierdaChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.adelanteCharacteristicUUID{
                    print("Botón Adelante ")
                    adelanteChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.atrasCharacteristicUUID {
                    print("Botón Atras ")
                    atrasChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.brazosDArribaCharacteristicUUID{
                    print("Botón Brazo Derecho Arriba ")
                    brazoDArribaChar = characteristic
                    
                } else if characteristic.uuid == ParticlePeripheral.brazosDAbajoCharacteristicUUID {
                    print("Botón Brazo Derecho Abajo ")
                    brazoDAbajoChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.siCharacteristicUUID {
                    print("Botón Si")
                    siChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.noCharacteristicUUID {
                    print("Botón No")
                    noChar = characteristic
                } else if characteristic.uuid == ParticlePeripheral.gelCharacteristicUUID {
                    print("Botón Gel")
                    gelChar = characteristic
                }
                
            }
        }*/
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
      /*  switch characteristic.uuid {
        case SystemIDCharacteristicCbuuid:
            print(characteristic.value ?? "no value")
        default:
            print("Uuid de caracteristica no controlada:\(characteristic.uuid)")
        }*/
        print("Estoy en didupdate")
    }
    
    // MaARK: IBAction 
    @IBAction func ButtonIndicaciones(_ sender: UIButton) {
        print("Funciona Indicaciones")
   /*     guard let characteristic = indicacionesChar else {return }
        print("Funciona Indicaciones2")
        writeValueToChar(withCharacteristic: characteristic, withValue: RobotActions.indicacionesSr)*/
     //   self.peripheral.writeValue(<#T##data: Data##Data#>, for: CBDescriptor)
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
    
    private func writeValueToChar( withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {
        
        // Check if it has the write property
        if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {
            peripheral.writeValue(value, for: characteristic, type: .withoutResponse)
        }
    }
}




    

