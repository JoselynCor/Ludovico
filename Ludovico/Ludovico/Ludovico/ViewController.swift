//
//  ViewController.swift
//  Ludovico
//
//  Created by LDCBI on 20/01/22.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate{
    
    // Outlet for button and label
    
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
    
    //Characteristics
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
        print("Ver cargando")
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Actualizando del estado central")
        if central.state != .poweredOn {
                    print("La central esta encendida ")
        } else {
          print("Central scanning for", ParticlePeripheral.particleLEDServiceUUID);
            centralManager.scanForPeripherals(withServices: [ParticlePeripheral.particleLEDServiceUUID], options: [CBCentralManagerRestoredStateScanOptionsKey : true])
            
                }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // La hemos encontrado,asi que deja de escanear
        self.centralManager.stopScan()
        // Copia de la instacia periférica
        self.peripheral = peripheral
        self.peripheral.delegate = self
        // Conectado
        self.centralManager.connect(self.peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral{
            print("Conectado a su Robot")
            peripheral.discoverServices([ParticlePeripheral.particleLEDServiceUUID,ParticlePeripheral.batteryServiceUUID]);
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            if let services = peripheral.services {
                for service in services {
                    if service.uuid == ParticlePeripheral.particleLEDServiceUUID {
                        print("Servicio Led encontrado")
                       // EL descubrimiento de características
                        peripheral.discoverCharacteristics([ParticlePeripheral.indicacionesCharacteristicUUID
                                                            
                                                            ,
                                                            ParticlePeripheral.temperaturaCharacteristicUUID,
                                                            ParticlePeripheral.adelanteCharacteristicUUID,ParticlePeripheral.atrasCharacteristicUUID, ParticlePeripheral.brazosAbajoCharacteristicUUID, ParticlePeripheral.brazosArribaCharacteristicUUID, ParticlePeripheral.brazosDAbajoCharacteristicUUID,ParticlePeripheral.brazosDArribaCharacteristicUUID,ParticlePeripheral.izquierdaCharacteristicUUID, ParticlePeripheral.derechaCharacteristicUUID, ParticlePeripheral.siCharacteristicUUID, ParticlePeripheral.noCharacteristicUUID, ParticlePeripheral.gelCharacteristicUUID], for: service)
                    }
                    return
                    }
                }
            }
        
func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            if let characteristics = service.characteristics {
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
                    }else if characteristic.uuid == ParticlePeripheral.izquierdaCharacteristicUUID{
                        print("Botón Izquierda ")
                        izquierdaChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.adelanteCharacteristicUUID{
                        print("Botón Adelante ")
                        adelanteChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.atrasCharacteristicUUID {
                        print("Botón Atras ")
                        atrasChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.brazosDArribaCharacteristicUUID{
                        print("Botón Brazo Derecho Arriba ")
                        brazoDArribaChar = characteristic
                        
                    }else if characteristic.uuid == ParticlePeripheral.brazosDAbajoCharacteristicUUID {
                        print("Botón Brazo Derecho Abajo ")
                        brazoDAbajoChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.siCharacteristicUUID {
                        print("Botón Si")
                        siChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.noCharacteristicUUID {
                        print("Botón No")
                        noChar = characteristic
                    }else if characteristic.uuid == ParticlePeripheral.gelCharacteristicUUID {
                        print("Botón Gel")
                        gelChar = characteristic
                    }
                    
                }
            }
        }

    @IBAction func ButtonIndicaciones(_ sender: UIButton) {
        print("Funciona Indicaciones")
        writeValueToChar(withCharacteristic: indicacionesChar!, withValue: RobotActions.indicacionesSr)
        //let button:UInt8 = UInt8(indicaciones.value)
        //writeValueToChar(withCharacteristic: indicacionesChar!, withValue: Data([button]))
    }
    
    @IBAction func ButtonTem(_ sender: Any) {
        print("Funciona Temperatura")
        writeValueToChar(withCharacteristic: temperaturaChar!, withValue: RobotActions.temperaturaSr)
    }
    
    @IBAction func BrazoArriba(_ sender: Any) {
        print("Funciona BrazoArriba")
        writeValueToChar(withCharacteristic: brazoArribaChar!, withValue: RobotActions.brazosArribaSr)
    }

    @IBAction func BrazoAbajo(_ sender: Any) {
        print("Funciona BrazoAbajo")
        writeValueToChar(withCharacteristic: brazoAbajoChar!, withValue: RobotActions.brazosAbajoSr)
    }
    
    @IBAction func Izquierda(_ sender: Any) {
        print("Funciona Izquierda")
        writeValueToChar(withCharacteristic: izquierdaChar!, withValue: RobotActions.izquierdaSr)
    }
    
    @IBAction func Adelante(_ sender: Any) {
        print("Funciona Adelante ")
        writeValueToChar(withCharacteristic: adelanteChar!, withValue: RobotActions.adelanteSr)
    }
    
    @IBAction func Atras(_ sender: Any) {
        print("Funciona Atras")
        writeValueToChar(withCharacteristic: atrasChar!, withValue: RobotActions.atrasSr)
    }
    
    @IBAction func Derecha(_ sender: Any) {
        print("Funciona Derecha")
        writeValueToChar(withCharacteristic: derechaChar!, withValue: RobotActions.derechaSr)
    }
    
    @IBAction func BrazoDArriba(_ sender: Any) {
        print("Funciona BrazoDArriba")
        writeValueToChar(withCharacteristic: brazoDArribaChar!, withValue: RobotActions.brazosDArribaSr)
    }
    
    
    @IBAction func BrazoDAbajo(_ sender: Any) {
        print("Funciona BrazoDAbajo")
        writeValueToChar(withCharacteristic: brazoDAbajoChar!, withValue: RobotActions.brazosDAbajoSr)
    }
    
    @IBAction func SI(_ sender: Any) {
        print("Funciona Si")
        writeValueToChar(withCharacteristic: siChar!, withValue: RobotActions.siSr)
    }
    
    @IBAction func NO(_ sender: Any) {
        print("Funciona No")
        writeValueToChar(withCharacteristic: noChar!, withValue: RobotActions.noSr)
    }
    
    @IBAction func Gel(_ sender: Any) {
        print("Funciona Gel")
        writeValueToChar(withCharacteristic: gelChar!, withValue: RobotActions.gelSr)
    }
    

    private func writeValueToChar( withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {

               // Check if it has the write property
               if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {

                   peripheral.writeValue(value, for: characteristic, type: .withoutResponse)

               }

           
    }
    
    
    

}

       
        
        
    

