//
//  PinData.swift
//  mova
//
//  Created by anton Shepetuha on 20.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift
import Realm


class PinData : Object {
    dynamic var id         = 0
    dynamic var latitude   = 0.1
    dynamic var longitude  = 0.1
    dynamic var topText    = ""
    dynamic var bottomText = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
