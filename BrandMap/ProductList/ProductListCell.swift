//
//  ProductListCell.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ProductListCell: UITableViewCell {
    let prodctImageView = UIImageView()
    let koNameLabel = UILabel()
    let enNameLabel = UILabel()
    let capacityLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
        
        let verticalStackView = UIStackView(arrangedSubviews: [koNameLabel, enNameLabel, capacityLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 10.0
        
        [prodctImageView, verticalStackView].forEach{
            contentView.addSubview($0)
        }
        
        prodctImageView.contentMode = .scaleAspectFit
        
        koNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        koNameLabel.numberOfLines = 2
        koNameLabel.textAlignment = .left
        
        enNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        enNameLabel.numberOfLines = 2
        koNameLabel.textAlignment = .left
        
        capacityLabel.font = .systemFont(ofSize: 10, weight: .light)
        capacityLabel.textColor = .systemBlue
        capacityLabel.numberOfLines = 0
        koNameLabel.textAlignment = .left
        
        prodctImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(120)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.leading.equalTo(prodctImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(prodctImageView.snp.centerY) //라벨이 beerImageView의 중앙
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(with product: Product) {
        let imageURL = URL(string: product.imageurl ?? "")
        prodctImageView.kf.setImage(with: imageURL)
        koNameLabel.text = product.nameko
        enNameLabel.text = product.nameen
        capacityLabel.text = product.capacity
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
