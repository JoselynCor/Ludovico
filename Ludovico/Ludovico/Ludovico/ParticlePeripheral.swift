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
        
    public static let particleLEDServiceUUID                = CBUUID.init(string: "E0270E9A-DCF9-470B-FFBF-579AF1BE1BE6")
    public static let indicacionesCharacteristicUUID        = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
    public static let temperaturaCharacteristicUUID         = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
    public static let brazosArribaCharacteristicUUID        = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")
    public static let brazosAbajoCharacteristicUUID         = CBUUID.init(string: "b4250404-fb4b-4746-b2b0-93f0e61122c6")
    public static let izquierdaCharacteristicUUID           = CBUUID.init(string: "b4250405-fb4b-4746-b2b0-93f0e61122c6")
    public static let adelanteCharacteristicUUID            = CBUUID.init(string: "b4250406-fb4b-4746-b2b0-93f0e61122c6")
    public static let atrasCharacteristicUUID               = CBUUID.init(string: "b4250407-fb4b-4746-b2b0-93f0e61122c6")
    public static let derechaCharacteristicUUID             = CBUUID.init(string: "b4250408-fb4b-4746-b2b0-93f0e61122c6")
    public static let brazosDArribaCharacteristicUUID       = CBUUID.init(string: "b4250409-fb4b-4746-b2b0-93f0e61122c6")
    public static let brazosDAbajoCharacteristicUUID        = CBUUID.init(string: "b4250410-fb4b-4746-b2b0-93f0e61122c6")
    public static let siCharacteristicUUID                  = CBUUID.init(string: "b4250411-fb4b-4746-b2b0-93f0e61122c6")
    public static let noCharacteristicUUID                  = CBUUID.init(string: "b4250412-fb4b-4746-b2b0-93f0e61122c6")
    public static let gelCharacteristicUUID                 = CBUUID.init(string: "b4250413-fb4b-4746-b2b0-93f0e61122c6")
    // System constants
    public static let batteryServiceUUID         = CBUUID.init(string: "180f")
    public static let batteryCharacteristicUUID  = CBUUID.init(string: "2a19")
}

class RobotActions {
    public static let  indicacionesSr  = createDate(with: "a")
    public static let  temperaturaSr   = createDate(with: "b")
    public static let  brazosArribaSr  = createDate(with: "c")
    public static let  brazosAbajoSr   = createDate(with: "d")
    public static let  izquierdaSr     = createDate(with: "e")
    public static let  adelanteSr      = createDate(with: "f")
    public static let  atrasSr         = createDate(with: "g")
    public static let  derechaSr       = createDate(with: "h")
    public static let  brazosDArribaSr = createDate(with: "i")
    public static let  brazosDAbajoSr  = createDate(with: "j")
    public static let  siSr            = createDate(with: "k")
    public static let  noSr            = createDate(with: "l")
    public static let  gelSr           = createDate(with: "m")
    
    private static func createDate( with text: String) -> Data {
        return Data (base64Encoded: text) ?? Data()
    }
}
