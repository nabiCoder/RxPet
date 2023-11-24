//
//  ViewController.swift
//  RxSwiftPetProject
//
//  Created by Денис Набиуллин on 21.11.2023.
//

import UIKit
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .orange
        table.separatorStyle = .none
        table.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstreints()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    private func setupConstreints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier,
                                                       for: indexPath) as? Cell else { return UITableViewCell() }
            
        cell.configureCell("product")
        
        return cell
    }
    
    
}
