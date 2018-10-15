//
//  NumberInput.swift
//  CustomTextField
//
//  Created by Quyen Trinh on 10/12/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class NumberInput: InputField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var value: String? {
        return text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.keyboardType = .asciiCapableNumberPad
        self.keyboardAppearance = .dark
    }
    
}
