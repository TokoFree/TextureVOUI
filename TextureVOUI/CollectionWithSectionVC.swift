//
//  CollectionWithSectionVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 28/07/22.
//

import UIKit


final class CollectionWithSectionVC: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 20)
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return col
    }()
    
    private let sections: [[Int]] = [
        [1,2,3],
        [10,11,12,13]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MySectionCellView.self, forCellWithReuseIdentifier: "reuse")
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionWithSectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("<<< select \(indexPath)")
    }
}

extension CollectionWithSectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath) as? MySectionCellView else { return UICollectionViewCell() }
        cell.update(sections[indexPath.section][indexPath.row])
        return cell
    }
    
    
}

final class MySectionCellView: UICollectionViewCell {
    private let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func update(_ number: Int) {
        label.text = "Label number \(number)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
