//
//  UIDesign.swift
//  CollectionViewTemplate
//
//  Created by SeoDongHee on 2016. 7. 5..
//  Copyright © 2016년 SeoDongHee. All rights reserved.
//

import UIKit

class UIDesign {
    
    func setTextFieldLayout(textField: UITextField, fontsize: CGFloat) {
        textField.textAlignment = .Center
        textField.font = UIFont(name: "Verdana", size: fontsize)
        textField.layer.borderColor = UIColor.blackColor().CGColor
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.lightGrayColor()
        textField.clearButtonMode = .WhileEditing
    }
    
    func setLabelLayout(label: UILabel, fontsize: CGFloat) {
        label.textAlignment = .Center
        label.font = UIFont(name: "Verdana", size: fontsize)
        label.layer.cornerRadius = 10

    }
}