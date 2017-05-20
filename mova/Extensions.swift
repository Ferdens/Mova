//
//  Extensions.swift
//  mova
//
//  Created by anton Shepetuha on 19.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    open class var navigationBarBackground: UIColor { get {
        return UIColor(red: 70/255, green: 142/255, blue: 231/255, alpha: 1)
        }
    }
    open class var bottomLabelColor: UIColor { get {
        return UIColor(red: 214/255, green: 214/255, blue: 216/255, alpha: 1)
        }
    }
}

extension UIView {
    func addShadow( opacity: Float,radius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = radius
    }
    
}


