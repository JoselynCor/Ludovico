//
//  ParticlePeripheral.swift
//  Ludovico
//
//  Created by LDCBI on 26/01/22.
//

import Foundation
import UIKit
import CoreBluetooth

class ParticlePeripheral: NSObject {
    
   
        public static let particleLEDServiceUUID     = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6")
        public static let indicacionesCharacteristicUUID   = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
        public static let temperaturaCharacteristicUUID = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
        public static let brazosArribaCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")
        public static let brazosAbajoCharacteristicUUID  = CBUUID.init(string: "b4250404-fb4b-4746-b2b0-93f0e61122c6")
        public static let izquierdaCharacteristicUUID  = CBUUID.init(string: "b4250405-fb4b-4746-b2b0-93f0e61122c6")
        public static let adelanteCharacteristicUUID  = CBUUID.init(string: "b4250406-fb4b-4746-b2b0-93f0e61122c6")
        public static let atrasCharacteristicUUID  = CBUUID.init(string: "b4250407-fb4b-4746-b2b0-93f0e61122c6")
        public static let derechaCharacteristicUUID  = CBUUID.init(string: "b4250408-fb4b-4746-b2b0-93f0e61122c6")
        public static let brazosDArribaCharacteristicUUID  = CBUUID.init(string: "b4250409-fb4b-4746-b2b0-93f0e61122c6")
        public static let brazosDAbajoCharacteristicUUID  = CBUUID.init(string: "b4250410-fb4b-4746-b2b0-93f0e61122c6")
        public static let siCharacteristicUUID  = CBUUID.init(string: "b4250411-fb4b-4746-b2b0-93f0e61122c6")
        public static let noCharacteristicUUID  = CBUUID.init(string: "b4250412-fb4b-4746-b2b0-93f0e61122c6")
        public static let gelCharacteristicUUID  = CBUUID.init(string: "b4250413-fb4b-4746-b2b0-93f0e61122c6")
        
    
    
        public static let batteryServiceUUID         = CBUUID.init(string: "180f")
        
        public static let batteryCharacteristicUUID  = CBUUID.init(string: "2a19")
       

   }
class RobotActions {
     
    
    public static let  indicacionesSr = Data (base64Encoded: "a") ?? Data()
    public static let  temperaturaSr = Data (base64Encoded: "b") ?? Data()
    public static let  brazosArribaSr = Data (base64Encoded: "c") ?? Data()
    public static let  brazosAbajoSr = Data (base64Encoded: "d") ?? Data()
    public static let  izquierdaSr = Data (base64Encoded: "e") ?? Data()
    public static let  adelanteSr = Data (base64Encoded: "f") ?? Data()
    public static let  atrasSr = Data (base64Encoded: "g") ?? Data()
    public static let  derechaSr = Data (base64Encoded: "h") ?? Data()
    public static let  brazosDArribaSr = Data (base64Encoded: "i") ?? Data()
    public static let  brazosDAbajoSr = Data (base64Encoded: "j") ?? Data()
    public static let  siSr = Data (base64Encoded: "k") ?? Data()
    public static let  noSr = Data (base64Encoded: "l") ?? Data()
    public static let  gelSr = Data (base64Encoded: "n") ?? Data()
}
