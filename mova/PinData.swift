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


class PinData : Object {
    dynamic var latitude   = 0.1
    dynamic var longitude  = 0.1
    dynamic var topText    = ""
    dynamic var bottomText = ""
}
