//
//  StatisticsViewContoroller.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/03/06.
//

import UIKit
import Charts

final class StatisticsViewContoroller: UIViewController {
    var statistics = [Statistics]()
    var dataTasks = [URLSessionTask]()
    
    var arrValue: [String]!
    var arrLabel: [String]!
    
    //메인 뷰 영역
    lazy var statisticsView: StatisticsView = {
        return StatisticsView(frame: self.view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = statisticsView
        
        title = "SKUs Statistics"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        statisticsView.barChartView.noDataText = "데이터가 없습니다."
        statisticsView.barChartView.noDataFont = .systemFont(ofSize: 20)
        statisticsView.barChartView.noDataTextColor = .lightGray
        
        //데이터 바인딩
        fetchData()
    }
    
    func configureChartView(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "SKUs")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue, .systemCyan, .systemMint, .systemPink, .systemTeal, .systemBrown, .systemGreen, .systemIndigo, .systemPurple, .systemOrange, .systemYellow, .systemGray2]
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        statisticsView.barChartView.data = chartData
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        statisticsView.barChartView.doubleTapToZoomEnabled = false
        // X축 레이블 위치 조정
        statisticsView.barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        statisticsView.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        statisticsView.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        //기본 애니메이션
        statisticsView.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 리미트라인
        let average = ChartLimitLine(limit: 20.0, label: "평균")
        statisticsView.barChartView.leftAxis.addLimitLine(average)
        statisticsView.barChartView.backgroundColor = .white
        average.valueTextColor = .red
    }
}

private extension StatisticsViewContoroller {
    func fetchData() {
        guard let url = URL(string: "https://bmap.haveandbe.com/statistics_json.asp"),
              dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let statistics = try? JSONDecoder().decode([Statistics].self, from: data) else {
                      print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                      return
                  }
            
            switch response.statusCode {
            case (200...299):
                let statistics = statistics[0]
            
                let arrValue = statistics.statValue.split(separator: ",")
                let arrLabel = statistics.statLabel.split(separator: ",")
                
                DispatchQueue.main.async { [self] in
                    self.statisticsView.drjartSKULabel.text = String(statistics.drjartSKUs)
                    self.statisticsView.dtrtSKULabel.text = String(statistics.dtrtSKUs)
                   
                    self.configureChartView(dataPoints: arrLabel.compactMap{ String($0) }, values: arrValue.compactMap{ Double($0) })
                }
            case (400...499):
                print("""
            ERROR: Client error \(response.statusCode)
            Response: \(response)
        """)
            case (500...599):
                print("""
            ERROR: Server error \(response.statusCode)
            Response: \(response)
        """)
            default:
                print("""
            ERROR: \(response.statusCode)
            Response: \(response)
        """)
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}

