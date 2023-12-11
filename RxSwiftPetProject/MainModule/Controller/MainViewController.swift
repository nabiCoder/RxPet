//
//  MainViewController.swift
//  RxSwiftPetProject
//
//  Created by Денис Набиуллин on 21.11.2023.
//

import UIKit
import RxSwift
import SnapKit

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let networkManager = NetworkManager.shared
    private var data = BehaviorSubject<[URL]>(value: [])
    
    private let tableView: UITableView = {
        $0.separatorStyle = .none
        $0.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDataAndBind()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        setupConstreints()
    }
    
    private func setupConstreints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension MainViewController {
    
    private func fetchDataAndBind() {
        networkManager.loadRandomDogImages(count: 5)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] dataStruct in
                let urls = dataStruct.compactMap { URL(string: $0) }
                self?.data.onNext(urls)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)

        data
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Cell.identifier, cellType: Cell.self)) { _, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
    }
}
