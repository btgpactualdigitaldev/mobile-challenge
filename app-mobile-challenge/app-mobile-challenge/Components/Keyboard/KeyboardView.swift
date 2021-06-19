//
//  KeyboardView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Protocols

protocol KeyboardViewDelegate: AnyObject {
    func selected(value: String)
}

// Class

final class KeyboardView: UICollectionView {

    // Constans

    private enum Contants {
        static let keyboardItems: Int = 12
    }

    // Properties

    private let layout = UICollectionViewFlowLayout()
    weak var delegateController: KeyboardViewDelegate?

    private let viewModel = KeyboardViewModel()

    // Lifecycle

    init(frame: CGRect, delegate: KeyboardViewDelegate) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegateController = delegate
        self.dataSource = self
        self.delegate = self
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private Methods

    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        register()
    }

    private func register() {
        register(KeyboardViewCell.self,
                 forCellWithReuseIdentifier: KeyboardViewCell.self.description())
    }
}

extension KeyboardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Contants.keyboardItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: KeyboardViewCell.self.description(), for: indexPath) as? KeyboardViewCell else {
            return UICollectionViewCell()
        }
        cell.setupComponent(index: indexPath.row)

        return cell
    }
}

// CollectionView

extension KeyboardView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(
            width: DesignSystem.Keyboard.Cell.width,
            height: DesignSystem.Keyboard.Cell.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ImpactFeedback.run(style: .medium)
        let value = viewModel.convertValue(index: indexPath.row)
        delegateController?.selected(value: value)
    }
}
