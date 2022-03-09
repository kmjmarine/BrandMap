//
//  StatisticsView.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/03/06.
//

import UIKit
import SnapKit
import Charts

final class StatisticsView: UIView {
    lazy var drjartTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.text = "Dr.jart SKUs"
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var drjartSKULabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.text = "0"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var dtrtTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.text = "DTRT SKUs"
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var dtrtSKULabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.text = "0"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.backgroundColor = .white
        
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatisticsView {
    func setUILayout() {
        backgroundColor = .white

        let verticalStackView1 = UIStackView(arrangedSubviews: [drjartTitleLabel, drjartSKULabel])
        verticalStackView1.axis = .vertical
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 1.0
        verticalStackView1.layer.borderWidth = 1.0
        verticalStackView1.layer.borderColor = UIColor.lightGray.cgColor
        
        let verticalStackView2 = UIStackView(arrangedSubviews: [dtrtTitleLabel, dtrtSKULabel])
        verticalStackView2.axis = .vertical
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 1.0
        verticalStackView2.layer.borderWidth = 1.0
        verticalStackView2.layer.borderColor = UIColor.lightGray.cgColor
        
        let hotizontalStackView = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        hotizontalStackView.axis = .horizontal
        hotizontalStackView.spacing = 30.0
        
        [hotizontalStackView, barChartView]
            .forEach { addSubview($0) }
        
        drjartTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10.0)
        }
        
        dtrtTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10.0)
        }
        
        verticalStackView1.snp.makeConstraints {
            $0.width.equalTo(180.0)
        }
        
        verticalStackView2.snp.makeConstraints {
            $0.width.equalTo(180.0)
        }
        
        hotizontalStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100.0)
        }
        
        barChartView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(hotizontalStackView.snp.bottom).offset(30.0)
            $0.height.equalTo(480.0)
        }
    }
}


