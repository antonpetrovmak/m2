//
//  CalculatorViewController.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CalculatorViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private lazy var calculatorHeaderView: CalculatorHeaderView = {
        let headerView = CalculatorHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 320))
        headerView.delegate = self
        return headerView
    }()
    private let apartmentsScheme = ApartmentsSchemeBuilder()
    
    private let factory = PaymentSchemeFactory()
    private var paymentsScheme: [PaymentSchemeCellViewModel] {
        return apartmentsScheme.payments.map{ factory.makePaymentSchemeCellViewModel($0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.tableHeaderView = calculatorHeaderView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0
        tableView.register(UINib(nibName: "PaymentSchemeCell", bundle: nil),
                           forCellReuseIdentifier: "PaymentSchemeCell")
        tableView.register(UINib(nibName: "PaymentSchemeSectionView", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "PaymentSchemeSectionView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }
}

// MARK: - CalculatorHeaderViewDelegate

extension CalculatorViewController: CalculatorHeaderViewDelegate {
    func segmentedControlValueChanged(_ index: Int) {
        let type = CreditType.init(rawValue: index) ?? .standard
        apartmentsScheme.setCreditType(type)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsScheme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentSchemeCell") as! PaymentSchemeCell
        let alpha: CGFloat = (indexPath.row % 2 == 0) ? 0 : 0.1
        cell.backgroundColor = UIColor.systemTeal.withAlphaComponent(alpha)
        cell.setupViewModel(paymentsScheme[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PaymentSchemeSectionView") as? PaymentSchemeSectionView else {
            return nil
        }
        //let year = tableDataSource.history[section].section
        //header.yearLabel.text = year
        return header
    }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
}
