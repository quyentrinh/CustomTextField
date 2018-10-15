//
//  TimeInput.swift
//  CustomTextField
//
//  Created by Quyen Trinh on 10/12/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum TimeType: Int {
    case hour
    case minute
    case second
    case milisecond
}

struct TimeValueParts {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var ms: Int
}

class TimeInput: InputField {

    // MARK: - Public
    
    var value: TimeValueParts = TimeValueParts(hours: 0, minutes: 0, seconds: 0, ms: 0) {
        didSet {
            updateText()
        }
    }

    // MARK: - Private
    
    private lazy var miliSecondData: [Int] = {
        return Array(0...99)
    }()
    private lazy var secondData: [Int] = {
        return Array(0...59)
    }()
    private lazy var minuteData: [Int] = {
        return Array(0...59)
    }()
    private lazy var hourData: [Int] = {
        return Array(0...99)
    }()
    
    private let componentWidth: CGFloat = UIScreen.main.bounds.width / 5.0
    
    private lazy var timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - SETUP UI
    
    private func setup() {
        self.inputView = timePicker
        self.tintColor = .clear
        timePicker.backgroundColor = UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
        let pickerHeight = timePicker.bounds.height
        let leftMargin = componentWidth / 2.0 - 10
        
        for i in 1...3 {
            let label = UILabel(frame: CGRect(x: leftMargin + CGFloat(i)*componentWidth + CGFloat(i - 1)*5.0, y: pickerHeight / 2.0 - 22, width: 40, height: 40))
            label.textColor = .white
            label.text = " : "
            timePicker.addSubview(label)
        }
        
    }

    // MARK: - Utilities
    
    private func datasourceFor(_ timeType: TimeType) -> [Int] {
        switch timeType {
        case .milisecond:
            return miliSecondData
        case .second:
            return secondData
        case .minute:
            return minuteData
        case .hour:
            return hourData
        }
    }
    
    private func updateValue(_ new: Int, ofType type: TimeType) {
        switch type {
        case .milisecond:
            value.ms = new
        case .second:
            value.seconds = new
        case .minute:
            value.minutes = new
        case .hour:
            value.hours = new
        }
    }
    
    private func updateText() {
        let text: String = "\(value.hours == 0 ? "" : "\(value.hours)H")  \(value.minutes == 0 && value.hours == 0 ? "" : "\(value.minutes)M")  \(value.seconds == 0 && value.minutes == 0 && value.hours == 0 ? "" : "\(value.seconds)S")  \(value.ms == 0 ? "" : "\(value.ms)MS")"
        
        let attributeString = NSMutableAttributedString(string: text)
        let specificChar: [String] = ["H", "M", "S", "MS"]
        for char in specificChar {
            let range = (text as NSString).range(of: char, options: .caseInsensitive)
            attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 11, weight: .regular), range: range)
        }
        self.attributedText = attributeString
    }
    
}

extension TimeInput: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let timeType = TimeType(rawValue: component) else {
            return 0
        }
        return datasourceFor(timeType).count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return UIScreen.main.bounds.width / 5.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let reusingLabel = view as? UILabel {
            label = reusingLabel
        } else {
            label = UILabel()
        }
        label.textAlignment = .center
        guard let timeType = TimeType(rawValue: component) else {
            label.text = " "
            return label
        }
        label.text = "\(datasourceFor(timeType)[row])"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = . white
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let timeType = TimeType(rawValue: component) else {
            return
        }
        updateValue(datasourceFor(timeType)[row], ofType: timeType)
    }
}
