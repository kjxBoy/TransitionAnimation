//
//  ModelViewController.swift
//  按钮位置变化
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 kang. All rights reserved.
//

import UIKit

class ModelViewController: UIViewController {
    
    var newDelegate: UIViewControllerTransitioningDelegate? = JXCoolTransitioningDelegate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    func setup() {
        // init
         self.modalPresentationStyle = UIModalPresentationStyle.custom
        //transition 转场，转成代理
         self.transitioningDelegate = newDelegate
    }
    
}

