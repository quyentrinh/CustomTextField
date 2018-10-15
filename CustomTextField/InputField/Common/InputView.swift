//
//  InputView.swift
//  CustomTextField
//
//  Created by Quyen Trinh on 10/15/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

@IBDesignable

class InputView: UIView {
    
    @IBInspectable open var numberInput: Bool = true

    private var inputField: InputField!
    private var bottomLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        backgroundColor = .clear
        
        if numberInput {
            inputField = NumberInput()
        } else {
            inputField = TimeInput()
        }
        addSubview(inputField)
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .red
        addSubview(line)
        bottomLine = line
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = self.bounds

        inputField.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 1)
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
    
}
