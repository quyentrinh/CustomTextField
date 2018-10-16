//
//  ViewController.swift
//  CustomTextField
//
//  Created by Quyen Trinh on 10/12/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNumber: InputView!
    @IBOutlet weak var txtTime: InputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }

}

