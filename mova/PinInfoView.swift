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
    var constraintsForActivation = [NSLayoutConstraint]()
    
    init(viewFrame: CGRect,annotationViewFrame: CGRect,image: UIImage, topText: String, bottomText: String) {
        
        let widthForInfoView  : CGFloat = viewFrame.width * 0.6
        let heightForInfoView : CGFloat = viewFrame.height * 0.13
        let rectForInfoView = CGRect(x: -widthForInfoView * 1.1, y: -heightForInfoView/3, width: widthForInfoView, height: heightForInfoView)
        super.init(frame: rectForInfoView)
        self.backgroundColor = UIColor.white
        
        let cornerView = UIView()
        cornerView.translatesAutoresizingMaskIntoConstraints = false
        cornerView.backgroundColor = .white
        cornerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        cornerView.addShadow(opacity: 0.5, radius: 1)
        self.addShadow(opacity: 1, radius: 2)
        self.addSubview(cornerView)
        let cornerViewHeightConstraint  = cornerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        let cornerViewWidthConstraint   = cornerView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        let cornerViewTrailingConstraint = cornerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (self.frame.height * 0.35)/2)
        let cornerViewCenterVerticalyConstraint = cornerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        constraintsForActivation.append(contentsOf: [cornerViewHeightConstraint,cornerViewWidthConstraint,cornerViewTrailingConstraint,cornerViewCenterVerticalyConstraint])
        
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.layer.cornerRadius = (self.frame.height * 0.5)/2
        imageView.layer.masksToBounds = true
        
        let shadowViewForImage = UIView(frame: imageView.frame)
        shadowViewForImage.layer.cornerRadius = shadowViewForImage.frame.width/2
        shadowViewForImage.backgroundColor = UIColor.white
        shadowViewForImage.addShadow(opacity: 1, radius: 2)
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .navigationBarBackground
        textLabel.text = topText
        textLabel.font = textLabel.font.withSize(13)
        
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.textColor = .bottomLabelColor
        bottomLabel.text = bottomText
        bottomLabel.font = bottomLabel.font.withSize(13)
        
        let starsView = UIImageView()
        starsView.translatesAutoresizingMaskIntoConstraints = false
        starsView.image = #imageLiteral(resourceName: "StarsImage")
        mainView.addSubview(imageView)
        mainView.addSubview(shadowViewForImage)
        mainView.addSubview(textLabel)
        mainView.addSubview(bottomLabel)
        mainView.addSubview(starsView)
        
        self.addSubview(mainView)
        self.bringSubview(toFront: mainView)

        let topStarsImageViewConstraint = starsView.topAnchor.constraint(equalTo: textLabel.bottomAnchor)
        let leadingStarsImageViewConstraint = starsView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor)
        let starsImageViewHeightConstraint = starsView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.24)
        let starsImageViewWidthConstraint  = starsView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3)
        
        let imageViewTopConstraint     = imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5)
        let imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5)
        let imageViewHeightConstraint  = imageView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5)
        let imageViewWidthConstraint   = imageView.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5)
        
        let textLabelTopConstraint     = textLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
        let textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: self.frame.width * 0.15)
        let textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5)
        let textLabelHeightConstraint   = textLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2)
        
        let bottomLabelLeadingConstraint = bottomLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: self.frame.width * 0.15)
        let bottomLabelTrailingConstraint = bottomLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5)
        let bottomLabelBottomConstraint  = bottomLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        let bottomLabelHeightConstraint  = bottomLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2)
        
        let mainViewHeightConstraint = mainView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
        let mainViewWidthConstraint  = mainView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        let mainViewYPosition        = mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let mainViewXPostion         = mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        constraintsForActivation.append(contentsOf: [mainViewHeightConstraint,mainViewWidthConstraint,mainViewXPostion,mainViewYPosition,imageViewTopConstraint,imageViewLeadingConstraint,imageViewHeightConstraint,imageViewWidthConstraint,textLabelTopConstraint,textLabelLeadingConstraint,textLabelTrailingConstraint,textLabelHeightConstraint,bottomLabelLeadingConstraint,bottomLabelTrailingConstraint,bottomLabelBottomConstraint,bottomLabelHeightConstraint,topStarsImageViewConstraint,leadingStarsImageViewConstraint,starsImageViewHeightConstraint,starsImageViewWidthConstraint])
        NSLayoutConstraint.activate(constraintsForActivation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


