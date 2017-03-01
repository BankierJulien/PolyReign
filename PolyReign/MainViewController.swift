//
//  ViewController.swift
//  PolyReign
//
//  Created by Julien Bankier on 2/28/17.
//  Copyright © 2017 Julien Bankier. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let draggableBackground: PRDraggableViewBackground = PRDraggableViewBackground(frame: self.view.frame)
        self.view.addSubview(draggableBackground)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

