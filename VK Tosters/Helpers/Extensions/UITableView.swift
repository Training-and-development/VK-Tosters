//
//  UITableView.swift
//  Epic Phrases
//
//  Created by programmist_np on 16.03.2020.
//  Copyright © 2020 Funny Applications. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Material

extension UITableView {
    func applyChanges<T>(changes: RealmCollectionChange<T>) {
        DispatchQueue.main.async(execute: { [weak self] in
            guard let strongSelf = self else { return }
            switch changes {
            case .initial:
                strongSelf.reloadData()

            case .update(_, let deletions, let insertions, let updates):
                let fromRow0 = { (row: Int) in
                    return IndexPath(row: row, section: 1)
                }
                strongSelf.beginUpdates()
                strongSelf.deleteRows(at: deletions.map(fromRow0), with: .none)
                strongSelf.insertRows(at: insertions.map(fromRow0), with: .none)
                strongSelf.reloadRows(at: updates.map(fromRow0), with: .none)
                strongSelf.endUpdates()
                
            case .error(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func dequeCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: IdentifiableCell {
        if let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Cell with identifier \(T.identifier) not registerd")
        }
    }
    
    func reloadData(with batchUpdates: BatchUpdates, from section: Int) {
        beginUpdates()

        insertRows(at: batchUpdates.inserted
            .map { IndexPath(row: $0, section: section) }, with: .top)
        deleteRows(at: batchUpdates.deleted
            .map { IndexPath(row: $0, section: section) }, with: .bottom)
        reloadRows(at: batchUpdates.reloaded
            .map { IndexPath(row: $0, section: section) }, with: .right)

        endUpdates()
    }
}
extension UITableView {
    open var tableViewHeight: CGFloat {
        self.layoutIfNeeded()
        return self.contentSize.height
    }
}
