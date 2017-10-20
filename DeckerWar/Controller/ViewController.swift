//
//  ViewController.swift
//  DeckerWar
//
//  Created by vitalii on 13/10/2017.
//  Copyright © 2017 vitalii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var area: Area!
    
    let deckers = [FourDecker(),
                   ThreeDecker(),ThreeDecker(),
                   DoubleDecker(),DoubleDecker(),DoubleDecker(),
                   SingleDecker(), SingleDecker(), SingleDecker(), SingleDecker()
        ] as [Decker]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateDeckers(_ sender: UIButton, forEvent event: UIEvent) {
        let deckerGenerator = DeckerGenerator()
        deckerGenerator.generateDeckers(deckers: deckers)
        
        DeckerUtils.printDeckers(deckerGenerator: deckerGenerator)
        area.drawDeckers(deckerGenerator: deckerGenerator)
    }
    
    
    
    
    
}

