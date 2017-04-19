//
//  ViewController.swift
//  XFetchCodeButton
//
//  Created by 王雄皓 on 2017/4/19.
//  Copyright © 2017年 王雄皓. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let codeButton = XFetchCodeButton(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
        codeButton.backgroundColor = .black
        codeButton.normalTitle = "Fetch Code"
        codeButton.normalTintColor = UIColor.white
        self.view.addSubview(codeButton)
        
        codeButton.doneSend {
            print("codeButton 已发送")
        }
        
        let codeButton2 = XFetchCodeButton(frame: CGRect(x: 20, y: 200, width: 100, height: 50))
        codeButton2.backgroundColor = .purple
        codeButton2.disabledColor = .black
        codeButton2.normalTintColor = .white
        self.view.addSubview(codeButton2)
        codeButton2.addTarget(target: self, action: #selector(code), forEvents: .touchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc func code() {
        print("codeButton2 已发送")
    }
}

