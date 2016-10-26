//
//  MyCollectionCell.swift
//  HitAndMiss
//
//  Created by Yeom on 2016. 10. 7..
//  Copyright © 2016년 Yeom. All rights reserved.
//

import UIKit

class MyCollectionCell: UICollectionViewCell {
    // MARK: - Internal Properties
    
    internal var colorView: UIView!
    
    internal var label: UILabel!
    
    // MARK: - Object Lifecycle
    
    internal override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.colorView = UIView()
        self.label = UILabel()
        
        self.contentView.addSubview(self.colorView)
        self.contentView.addSubview(self.label)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    internal override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.colorView.frame = CGRect(origin: CGPoint.zero, size: self.contentView.bounds.size)
        self.label.frame = CGRect(origin: CGPoint.zero, size: self.contentView.bounds.size)
    }
    
    internal override class var requiresConstraintBasedLayout: Bool {
        
        return false
    }
}
