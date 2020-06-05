//
//  UITableViewExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell(by anyClass: AnyClass) {
        let name = String(describing: anyClass)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }

    func registerHeaderFooterView(by anyClass: AnyClass) {
        let name = String(describing: anyClass)
        register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.className) as? T
            else { fatalError("") }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UIView>(_ cellClass: T.Type) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: cellClass.className) as? T
            else { fatalError("") }
        return cell
    }
}
