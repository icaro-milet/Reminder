//
//  MyReceiptsViewController.swift
//  Reminder
//
//  Created by milet on 30/06/25.
//

import Foundation
import UIKit
import CoreFramework

class MyReceiptsViewController: UIViewController {
    let contentView: MyReceiptsView
    weak var flowDelegate: MyReceiptsFlowDelegate?
    let viewModel = MyReceiptsViewModel()
    
    private var medicines: [Medicine] = []
    
    init(contentView: MyReceiptsView,
         flowDelegate: MyReceiptsFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        loadData()
    }
    
    private func setup() {
        view.addSubview(contentView)
        view.backgroundColor = Colors.gray800
        
        setupConstraints()
        contentView.delegate = self
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(RemedyCell.self, forCellReuseIdentifier: RemedyCell.identifier)
        contentView.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    private func loadData() {
        medicines = viewModel.fetchData()
    }
}

extension MyReceiptsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
}

extension MyReceiptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RemedyCell.identifier, for: indexPath) as! RemedyCell
        let medicines = medicines[indexPath.section]
        cell.configure(title: medicines.remedy, time: medicines.time, recurrence: medicines.recurrence)
        
        cell.onDelete = {[weak self] in
            guard let self = self else { return }
            
            if let actualIndexPath = tableView.indexPath(for: cell) {
                if actualIndexPath.section < self.medicines.count {
                    self.viewModel.deleteReceipt(byId: self.medicines[actualIndexPath.section].id)
                    self.medicines.remove(at: actualIndexPath.row)
                    
                    tableView.deleteSections(IndexSet(integer: actualIndexPath.section), with: .automatic)
                }
            } else {
                print("Erro ao excluir uma sessão inválida")
            }
        }
        
        return cell
    }
}

extension MyReceiptsViewController: MyReceiptsViewDelegate {
    func didTapBackButton() {
        flowDelegate?.popScreen()
    }
    
    func didTapAddButton() {
        flowDelegate?.goToNewReceipts()
    }
}
