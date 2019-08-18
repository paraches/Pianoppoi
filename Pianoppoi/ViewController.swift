//
//  ViewController.swift
//  Pianoppoi
//
//  Created by paraches on 2019/08/18.
//  Copyright © 2019年 paraches lifestyle lab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let player = PCPlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func clickKeyboard(_ sender: Any) {
        player.play(number: (sender as! NSButton).tag)
    }
    
}

