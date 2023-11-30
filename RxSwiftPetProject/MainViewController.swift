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
    private var data = BehaviorSubject<[String]>(value: [])
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .orange
        $0.separatorStyle = .none
        $0.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndBindData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        setupConstreints()
    }
    
    private func setupConstreints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension MainViewController {
    func fetchAndBindData() {
        networkManager.loadRandomDogImages(count: 5)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] dataStruct in
                // Обработка успешного результата
                self?.data.onNext(dataStruct)
            }, onError: { error in
                // Обработка ошибки
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        
        bindData()
    }
    
    func bindData() {
        data
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Cell.identifier, cellType: Cell.self)) { _, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
    }
}
