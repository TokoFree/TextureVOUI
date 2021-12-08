//
//  AccessibilityUIKitViewController.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/12/21.
//

import UIKit

public final class AccessibilityUIKitViewController: UIViewController {
    
    private let swicthView: UISwitch = {
        let view = UISwitch()
        view.accessibilityIdentifier = "switch"
        return view
    }()
    
    private let buttonView: UIButton = {
        let view = UIButton()
        view.setTitleColor(.green, for: .normal)
        view.backgroundColor = .red
        view.frame.size = CGSize(width: 100, height: 100)
        view.setTitle("Button", for: .normal)
        view.accessibilityIdentifier = "button"
        view.accessibilityTraits = [.button]
        return view
    }()
    
    private let textFieldView: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "textfield"
        return view
    }()
    
    let stackView: UIStackView = UIStackView()
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        stackView.frame = view.frame
        stackView.addArrangedSubview(swicthView)
        stackView.addArrangedSubview(buttonView)
        stackView.addArrangedSubview(textFieldView)
        stackView.axis = .vertical
        
        view.addSubview(stackView)
    }
}
