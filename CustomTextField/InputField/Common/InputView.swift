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
    
    // MARK: - Constant
    static let backgroundColor: UIColor = .clear
    static let keyboardBackgroundColor: UIColor = UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    static let mediumFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
    static let smallFont: UIFont = .systemFont(ofSize: 11, weight: .regular)
    static let pickerFont: UIFont = .systemFont(ofSize: 16, weight: .bold)

    // MARK: - Public
    
    var enable: Bool = true {
        didSet {
            self.isUserInteractionEnabled = enable
            self.alpha = enable ? 1.0 : 0.5
        }
    }
    
    
    // MARK: - Private
    private var inputField: InputField!
    private var bottomLine: UIView!
    private var textLabel: UILabel?
    
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
            
            let label = UILabel(frame: self.bounds)
            label.textAlignment = .center
            label.textColor = .white
            label.font = InputView.mediumFont
            self.addSubview(label)
            textLabel = label
            
            (inputField as! TimeInput).inputCompletion = { [unowned self] value in
                self.setupTimeText(value)
            }
        }
        inputField.delegate = self
        addSubview(inputField)
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .lightGray
        addSubview(line)
        bottomLine = line
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = self.bounds
        if let label = textLabel {
            label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 1)
        }
        inputField.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 1)
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
    
    // MARK: - Utilities
    
    private func setupTimeText(_ value: TimeValueParts) {
        
        guard let label = textLabel else {
            return
        }
        
        let text: String = "\(value.hours == 0 ? "" : "\(value.hours)H")  \(value.minutes == 0 && value.hours == 0 ? "" : "\(value.minutes)M")  \(value.seconds == 0 && value.minutes == 0 && value.hours == 0 ? "" : "\(value.seconds)S")  \(value.seconds == 0 && value.minutes == 0 && value.hours == 0 && value.ms == 0 ? "0MS" : "\(value.ms)MS")"
        
        let attributeString = NSMutableAttributedString(string: text)
        let specificChar: [String] = ["H", "M", "S", "MS"]
        for char in specificChar {
            let range = (text as NSString).range(of: char, options: .caseInsensitive)
            attributeString.addAttribute(NSAttributedString.Key.font, value: InputView.smallFont, range: range)
        }
 
        label.attributedText = attributeString
    }
    
}

extension InputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomLine.backgroundColor = .red
        }, completion:nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomLine.backgroundColor = .lightGray
        }, completion:nil)
    }
}
