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
        
        //---------------------------
        //Tap Gesture
        
//        blockView.rx.tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { _ in
//                print("block view tapped!!")
//            })
//            .disposed(by: bag)
        
        //---------------------------
        //LongPress Gesture
        
//        blockView.rx.anyGesture(.tap(),.longPress())
//            .when(.recognized)
//            .subscribe(onNext: { gesture in
//
//                if let gesture = gesture as? UITapGestureRecognizer {
//                    print("view was tapped!!")
//                } else {
//                    print("view was long pressed!!")
//                }
//            })
//            .disposed(by: bag)

        //---------------------------
        //screenEdgePanGesture
        view.rx.screenEdgePanGesture(edges: [.left, .top, .right])
            .when(.recognized)
            .subscribe(onNext: { recognizer in
                print(recognizer)
            })
            .disposed(by: bag)
        
        //---------------------------
        //swipeGesture
//        view.rx.swipeGesture(.left, numberOfTouchesRequired: 1) { (recognizer, delegate) in
//        }
//            .subscribe(onNext: { recognizer in
//                print(recognizer)
//            })
//            .disposed(by: bag)
        
        //---------------------------
        //currentLocation
//        view.rx.tapGesture()
//            .when(.recognized)
//            .asLocation(in: .view)
//            .subscribe(onNext: { location in
//                print("location x : \(location.x), location y : \(location.y)")
//            })
//            .disposed(by: bag)

        
        //---------------------------
        //Pan gesture
//        view.rx.panGesture()
//            .asTranslation(in: .superview)
//            .subscribe(onNext :{ translation, velocity in
//                print("Translation: \(translation), velocity: \(velocity)")
//
//                self.blockView.transform = CGAffineTransform(translationX: -translation.x, y: -translation.y)
//            })
//            .disposed(by: bag)
        
        //---------------------------
        //Rotation gesture
//        view.rx.rotationGesture()
//            .asRotation()
//            .subscribe(onNext: { rotation, velocity in
//                print("Rotation: \(rotation), velocity: \(velocity)")
//
//                self.blockView.transform = CGAffineTransform(rotationAngle: rotation)
//            })
//            .disposed(by: bag)
        
        //---------------------------
        //Automated View transform gesture
        //transform全般なので「zoom inout, rotate, 移動」などが同時にできる
//        view.rx.transformGestures()
//            .asTransform()
//            .subscribe(onNext: { transform, velocity in
//                print("Transform: \(transform), velocity: \(velocity)")
//
//                self.view.transform = transform
//            })
//            .disposed(by: bag)
//
        
        // ここではPanGestureの changed と ended の２パターンを購読したいので
        // 二回購読にならないよう .shareReplay1で　hotに変更する
        let panGesture = view.rx.panGesture()
            .share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        // chagend
        panGesture
            .when(.changed)
            .asTranslation()
            .subscribe(onNext: { [unowned self] translation, _ in
                self.blockView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            })
            .disposed(by: bag)
        
        panGesture
            .when(.ended)
            .subscribe(onNext: { _ in
                print("Done panning")
            })
            .disposed(by: bag)
    }
}

























