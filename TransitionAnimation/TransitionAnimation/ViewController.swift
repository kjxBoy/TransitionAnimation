//
//  ViewController.swift
//  TransitionAnimation
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let modelVc = SecondViewController()
        
        present(modelVc, animated: true)
    }

}

