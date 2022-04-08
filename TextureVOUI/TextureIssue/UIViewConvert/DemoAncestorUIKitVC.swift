//
//  DemoAncestorUIKitVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 07/04/22.
//

import Foundation
import UIKit

internal final class DemoAncestorUIKitVC: UIViewController {
    private let view1 = UIView()
    private let view2 = UIView()
    private let view3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view1.backgroundColor = .orange
        view2.backgroundColor = .red
        view3.backgroundColor = .green
        
        view.addSubview(view1)
        view1.addSubview(view2)
        view1.addSubview(view3)
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view1.widthAnchor.constraint(equalToConstant: 200),
            view1.heightAnchor.constraint(equalToConstant: 200),
            
            view2.topAnchor.constraint(equalTo: view1.topAnchor, constant: 16),
            view2.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 16),
            view2.widthAnchor.constraint(equalToConstant: 100),
            view2.heightAnchor.constraint(equalToConstant: 100),
            
            view3.topAnchor.constraint(equalTo: view2.topAnchor, constant: 30),
            view3.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 30),
            view3.widthAnchor.constraint(equalToConstant: 50),
            view3.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override internal func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let frameView3FromView1 = view3.convert(view3.bounds, to: view2)
        print(frameView3FromView1)
    }
}


internal final class DemoAncestorCollectionUIKitVC: UIViewController {
    private let colView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    private var data = Array(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.dataSource = self
        colView.delegate = self
        colView.register(MyCellView.self, forCellWithReuseIdentifier: "cell")
        colView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colView)
        view.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            colView.topAnchor.constraint(equalTo: view.topAnchor),
            colView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cell2 = colView.cellForItem(at: IndexPath(row: 1, section: 0))!
        print(cell2.convert(cell2.bounds, to: colView))
    }
}


extension DemoAncestorCollectionUIKitVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = colView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCellView else { return UICollectionViewCell() }
        cell.setData(number: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 800)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = self.colView.visibleCells as! [MyCellView]
        for cell in cells {
            let f = cell.frame
            let w = self.view.window!
//            let rect = cell.convert(cell.bounds, to: colView)
            let rect = w.convert(f, from: colView)
            print("<<< \(cell.frame.origin.x), \(colView.frame.origin.x)")
//            print(">>> ", colView.bounds, w.bounds)
//            print("<<< num\(num): ", rect.origin.x)
            let inter = rect.intersection(w.bounds)
            let ratio = (inter.width * inter.height) / (f.width * f.height)
//            let rep = (String(Int(ratio * 100)) + "%")
//            print(ratio)
            cell.setData(number: Int(ratio * 100))
            
        }
    }
}


internal final class MyCellView: UICollectionViewCell {
    private let label = UILabel()
    
    internal override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .yellow
        addSubview(label)
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setData(number: Int) {
        label.text = "Text ke \(number)"
    }
}
