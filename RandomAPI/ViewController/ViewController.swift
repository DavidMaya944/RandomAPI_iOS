//
//  ViewController.swift
//  RandomAPI
//
//  Created by administrador on 12/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var profile: Profile!
    var labelText: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.showData()
    }
}
