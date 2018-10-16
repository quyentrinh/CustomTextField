//
//  InputField.swift
//  CustomTextField
//
//  Created by Quyen Trinh on 10/12/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class InputField: UITextField {

    // MARK: - Public

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        tintColor = .clear
        textColor = .white
        textAlignment = .center
        font = InputView.mediumFont
        
//        let button = UIButton(frame: self.bounds)
//        button.setTitle("", for: .normal)
//        button.addTarget(self, action: #selector(inputViewDidTap), for: .touchUpInside)
        
    }
    
    // MARK: - ACTION
    
//    @objc private func inputViewDidTap() {
//
//    }
    

}
