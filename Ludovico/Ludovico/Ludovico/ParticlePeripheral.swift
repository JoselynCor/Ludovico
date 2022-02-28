//
//  ParticlePeripheral.swift
//  Ludovico
//  Created by Jimenez Linares Suemy Ximena, Ramirez Cordero Joselyn on 20/01/22.
//

import Foundation
import UIKit
import CoreBluetooth

//Mark:Class object
class ParticlePeripheral: NSObject {
    
    public static let particleLEDServiceUUID = CBUUID.init(string: "E0270E9A-DCF9-470B-FFBF-579AF1BE1BE6")
    
  }

//Mark: Class create Date
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
        text.data(using: .utf8) ?? Data()
     
    }
}
