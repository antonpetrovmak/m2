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
    
    lazy var viewModel: CalculatorViewModelProtocol = {
        var model = CalculatorViewModel()
        model.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        return model
    }()
    
    // MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        //tableView.tableHeaderView = calculatorHeaderView
        tableView.backgroundColor = Theme.whiteDirtyLight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0
        tableView.registerHeaderFooterView(by: PaymentSchemeSectionView.self)
        tableView.registerCell(by: PaymentSchemeCell.self)
        tableView.registerCell(by: SliderTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .paymentInput(let cells):
            return cells.count
        case .paymentScheme(let cells):
            return cells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .paymentInput(let cells):
            switch cells[indexPath.row] {
            case .slider(let viewModel):
                let cell = tableView.dequeueReusableCell(SliderTableViewCell.self)
                cell.delegate = self
                cell.setViewModel(viewModel)
                return cell
            default:
                break
            }
        case .paymentScheme(let cells):
            break
        }
        
        return UITableViewCell()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentSchemeCell") as! PaymentSchemeCell
//        let alpha: CGFloat = (indexPath.row % 2 == 0) ? 0 : 0.1
//        cell.backgroundColor = Theme.mint1.withAlphaComponent(alpha)
//        cell.setupViewModel(paymentsScheme[indexPath.row])
//        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(PaymentSchemeSectionView.self)
//        //let year = tableDataSource.history[section].section
//        //header.yearLabel.text = year
//        return header
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
}

// MARK: - CalculatorHeaderViewDelegate

extension CalculatorViewController: CalculatorHeaderViewDelegate {
    func segmentedControlValueChanged(_ index: Int) {
        viewModel.segmentedControlValueChanged(index)
    }
}

// MARK: - SliderTableViewCellDelegate

extension CalculatorViewController: SliderTableViewCellDelegate {
    func sliderDidChange(_ sender: UITableViewCell, _ value: Float) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        viewModel.sliderDidChange(indexPath, value)
    }
}
