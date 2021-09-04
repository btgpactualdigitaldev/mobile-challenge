//
//  ReusableProtocol.swift
//  AppDemo
//
//  Created by Tag Livros on 30/07/20.
//  Copyright © 2020 Tag Livros. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var identifier: String { get }
}

extension ReusableView {
  /// By default, use the name of the class as String for its identifier
  static var identifier: String {
    return String(describing: self)
  }
}

// MARK: Reusable support for UICollectionView
extension UICollectionView {
    
  func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: ReusableView {
      self.register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
  }

  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: ReusableView {
      let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
      guard let cell = bareCell as? T else {
        fatalError("Failed to dequeue a cell with identifier \(cellType.identifier)")
      }
      return cell
  }
}

// MARK: Reusable support for UITableView

extension UITableView {
  func register<T: UITableViewCell>(cellType: T.Type)
    where T: ReusableView {
      self.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: ReusableView {
      guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
        fatalError("Failed to dequeue a cell with identifier \(cellType.identifier)")
      }
      return cell
  }
}
