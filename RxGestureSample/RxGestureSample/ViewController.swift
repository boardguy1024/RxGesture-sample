//
//  ViewController.swift
//  RxGestureSample
//
//  Created by park kyung suk on 2017/11/29.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture


class ViewController: UIViewController {

    @IBOutlet weak var blockView: UIView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("block view tapped!!")
            })
            .disposed(by: bag)

    }
}

