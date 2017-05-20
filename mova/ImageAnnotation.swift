//
//  ImageAnnotation.swift
//  mova
//
//  Created by anton Shepetuha on 20.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ImageAnnotation : NSObject, MKAnnotation {
    var coordinate    : CLLocationCoordinate2D
    var title         : String?
    var topText       : String?
    var image         : UIImage?
    var colour        : UIColor?
    
    override init() {
        self.coordinate  = CLLocationCoordinate2D()
        self.title       = nil
        self.topText     = nil
        self.image       = nil
        self.colour      = UIColor.white
    }
}

class ImageAnnotationView: MKAnnotationView {
    private var imageView: UIImageView!
     override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 35))
        self.addSubview(self.imageView)
    }
    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
