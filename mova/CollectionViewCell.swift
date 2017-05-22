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
        label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let topLabelConstraint = label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6)
        let leadingLabelConstraint = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3)
        let trailingLabelConstraint = label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3)
        let bottomLabelConstrint    = label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        NSLayoutConstraint.activate([topLabelConstraint,leadingLabelConstraint,trailingLabelConstraint,bottomLabelConstrint])
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
