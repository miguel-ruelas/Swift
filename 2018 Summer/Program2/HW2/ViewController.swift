//
//  ViewController.swift
//  HW2
//
//  Created by Steven Luis on 8/22/17.
//  Copyright © 2017 FIU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var displayText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        displayText.text = "Hello World"
        displayText.textColor = .blue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

