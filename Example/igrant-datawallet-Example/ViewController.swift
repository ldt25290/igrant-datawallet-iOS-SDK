//
//  ViewController.swift
//  AriesMobileAgent-iOS
//
//  Created by rebin@igrant.io on 11/11/2020.
//  Copyright (c) 2020 rebin@igrant.io. All rights reserved.
//

import UIKit
import igrant_datawallet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let AriesMobileAgentVC = AriesMobileAgent.shared.getAriesMobileAgentQRDemoViewController(themeColor: .black)
        AriesMobileAgentVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(AriesMobileAgentVC, animated: false, completion: nil)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



