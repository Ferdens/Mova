//
//  CollectionViewCell.swift
//  mova
//
//  Created by anton Shepetuha on 19.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.contentView.addShadow(opacity: 1, radius: 1)
        label = UILabel(frame: CGRect(x: 3, y: 3, width:  self.contentView.frame.width - 3, height:  self.contentView.frame.height - 3))
        label.frame.origin.y += contentView.frame.height * 0.1
        label.textAlignment = .center
        contentView.addSubview(label)
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    
    
   
}
