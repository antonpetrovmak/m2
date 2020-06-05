//
//  CalculatorViewController.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Firebase
import GoogleMobileAds
import UIKit

class CalculatorViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var bannerView: GADBannerView! {
        didSet {
            bannerView.adUnitID = Config.BannerADUnitID
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
    }

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
        tableView.backgroundColor = Theme.whiteDirtyLight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0
        tableView.registerHeaderFooterView(by: PaymentSchemeSectionView.self)
        tableView.registerCell(by: PaymentSchemeCell.self)
        tableView.registerCell(by: SliderTableViewCell.self)
        tableView.registerCell(by: SliderEditableTableViewCell.self)
        tableView.registerCell(by: ResultCardCell.self)
        tableView.registerCell(by: CreditTypeCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
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
        switch viewModel.sections[indexPath.section] {
        case .paymentInput(let cells):
            switch cells[indexPath.row] {
            case .slider(let viewModel):
                let cell = tableView.dequeueReusableCell(SliderEditableTableViewCell.self)
                cell.delegate = self
                cell.setViewModel(viewModel)
                return cell
            case .card(let viewModel):
                let cell = tableView.dequeueReusableCell(ResultCardCell.self)
                cell.setViewModel(viewModel)
                return cell
            case .segment(let viewModel):
                let cell = tableView.dequeueReusableCell(CreditTypeCell.self)
                cell.delegate = self
                cell.setViewModel(viewModel)
                return cell
            default: break
            }
        case .paymentScheme(let cells):
            switch cells[indexPath.row] {
            case .paymentMonth(let viewModel):
                let cell = tableView.dequeueReusableCell(PaymentSchemeCell.self)
                cell.setupViewModel(viewModel)
                return cell
            default: break
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = viewModel.sections[section]
        guard sectionType.isContainsHeader else { return nil }
        let header = tableView.dequeueReusableHeaderFooterView(PaymentSchemeSectionView.self)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = viewModel.sections[section]
        guard sectionType.isContainsHeader else { return 0.0 }
        return 60
    }
}

// MARK: - CalculatorHeaderViewDelegate

extension CalculatorViewController: CreditTypeCellDelegate {
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

    func sliderDidStopped(_ sender: UITableViewCell, _ value: Float) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        viewModel.sliderDidStopped(indexPath, value)
    }
}

// MARK: - SliderEditableTableViewCellDelegate

extension CalculatorViewController: SliderEditableTableViewCellDelegate {
    func rightValueDidChanged(_ sender: UITableViewCell, _ value: Float) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        viewModel.rightValueDidEntered(indexPath, value)
    }

    func leftValueDidChanged(_ sender: UITableViewCell, _ value: Float) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        viewModel.leftValueDidEntered(indexPath, value)
    }
}
