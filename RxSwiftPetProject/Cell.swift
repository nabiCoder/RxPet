//
//  Cell.swift
//  RxSwiftPetProject
//
//  Created by Денис Набиуллин on 24.11.2023.
//

import UIKit
import SnapKit

final class Cell: UITableViewCell {
    
    static let identifier = "Cell"
    
    private lazy var cellImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(cellImageView)
        setupConstreints()
    }
    
    func configureCell (_ imageURL: String?) {
        
    }
    
    private func setupConstreints(){
        cellImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }
}
