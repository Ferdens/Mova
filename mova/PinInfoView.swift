//
//  PinInfoView.swift
//  mova
//
//  Created by anton Shepetuha on 20.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import UIKit

class PinInfoView: UIView {

    var isActive = false
    
    var collectionView : UICollectionView?
    init(viewFrame: CGRect,annotationViewFrame: CGRect,image: UIImage, topText: String, bottomText: String) {
        let widthForInfoView  : CGFloat = viewFrame.width * 0.6
        let heightForInfoView : CGFloat = viewFrame.height * 0.13
        let rectForInfoView = CGRect(x: -widthForInfoView * 1.1, y: -heightForInfoView/3, width: widthForInfoView, height: heightForInfoView)
        super.init(frame: rectForInfoView)
        self.backgroundColor = UIColor.white
        let cornerView = UIView(frame: CGRect(x: self.frame.width * 0.87, y: self.frame.height * 0.27, width: self.frame.height * 0.45, height: self.frame.height * 0.45))
        cornerView.backgroundColor = UIColor.white
        cornerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        cornerView.addShadow(opacity: 0.5, radius: 1)
        self.addShadow(opacity: 1, radius: 2)
        self.addSubview(cornerView)
        let mainView = UIView(frame:CGRect(x: 0, y: 0, width: widthForInfoView, height: heightForInfoView))
        mainView.backgroundColor = .white
        let imageView = UIImageView(frame: CGRect(x: self.frame.width * 0.05, y: self.frame.height * 0.1, width: self.frame.height * 0.5, height: self.frame.height * 0.5))
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        imageView.image = image
        let shadowViewForImage = UIView(frame: imageView.frame)
        shadowViewForImage.layer.cornerRadius = shadowViewForImage.frame.width/2
        shadowViewForImage.backgroundColor = UIColor.white
        shadowViewForImage.addShadow(opacity: 1, radius: 2)
        let textLabel = UILabel(frame: CGRect(x:mainView.frame.width * 0.4 , y: imageView.frame.origin.y, width: mainView.frame.width * 0.5, height: mainView.frame.height * 0.2))
        textLabel.textColor = .navigationBarBackground
        textLabel.text = topText
        textLabel.font = textLabel.font.withSize(13)
        let bottomLabel = UILabel(frame: CGRect(x: mainView.frame.width * 0.45, y: mainView.frame.height * 0.7, width: textLabel.frame.width, height: mainView.frame.height * 0.2))
        bottomLabel.textColor = .bottomLabelColor
        bottomLabel.text = bottomText
        bottomLabel.font = bottomLabel.font.withSize(13)
        
    let starsView = UIImageView(frame:CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.maxY, width: mainView.frame.width * 0.3, height: mainView.frame.height * 0.24))
        starsView.image = #imageLiteral(resourceName: "StarsImage")
        mainView.addSubview(starsView)
        mainView.addSubview(textLabel)
        mainView.addSubview(bottomLabel)
        mainView.addSubview(shadowViewForImage)
        mainView.addSubview(imageView)
        self.addSubview(mainView)
        self.bringSubview(toFront: mainView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
    
    }
 

}


