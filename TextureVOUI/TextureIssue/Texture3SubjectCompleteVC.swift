//
//  Texture3SubjectCompleteVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 08/09/22.
//

import AsyncDisplayKit
import RxCocoa
import RxCocoa_Texture
import RxSwift
import NSObject_Rx

internal final class Texture3SubjectCompleteVC: ASDKViewController<ASDisplayNode> {
    private let button = ASButtonNode()
    private let mySubject = PublishSubject<Void>()
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString.body("Tap Me"), for: .normal)
        button.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
        
        node.layoutSpecBlock = { [button] _, _ in
            ASInsetLayoutSpec(insets: .zero, child: button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySubject
            .asObservable()
            .debug("<<< mySubject")
            .subscribe()
            .disposed(by: rx.disposeBag)
    }
    
    @objc private func didTap() {
        let vc = Number2VC()
        vc.myDriver
            .debug("<<< myDriver")
            .drive(mySubject)
            .disposed(by: vc.rx.disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal final class Number2VC: ASDKViewController<ASDisplayNode> {
//    private let subject = PublishSubject<Int>()
    internal var myDriver: Driver<Void> {
//        subject.asDriver(onErrorDriveWith: .empty())
        button.rx.tap.asDriverOnErrorJustComplete()
    }
    private let button = ASButtonNode()
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .red
        button.setAttributedTitle(NSAttributedString.body("Tap Me"), for: .normal)
//        button.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
        
        node.layoutSpecBlock = { [button] _, _ in
            ASInsetLayoutSpec(insets: .zero, child: button)
        }
    }
    
//    @objc private func didTap() {
//        print("<<< A")
//        subject.onNext(Int.random(in: 0...1000))
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("<<< deinit")
    }
}



extension ObservableType {
    public func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            Observable.empty()
        }
    }

    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }

    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
