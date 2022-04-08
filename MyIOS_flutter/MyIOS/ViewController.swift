//
//  ViewController.swift
//  MyIOS
//
//  Created by wangkun42 on 2022/4/7.
//

import UIKit
import flutter_boost
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.title = "Main"

        let btnGoFlutter = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
            let options = FlutterBoostRouteOptions()
            options.pageName = "flutter"
            options.arguments = [:]
            FlutterBoost.instance().open(options)
        }))
        btnGoFlutter.setTitle("Go Flutter", for: .normal)

        self.view.addSubview(btnGoFlutter)
        btnGoFlutter.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }


}

