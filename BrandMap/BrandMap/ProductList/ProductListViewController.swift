//
//  ProductListViewController.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/25.
//

import UIKit
import SnapKit

final class ProductListViewController: UITableViewController {
    var productList = [Product]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    private var currentKeyword = ""
    
    private let tags: [String] = ["CICAPAIR", "BIOME", "CRYORUBBER", "RX"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "BrandMap"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView
        tableView.register(ProductListCell.self, forCellReuseIdentifier: ProductListCell.identifier)
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        
        tableView.register(ProductListHeaderView.self, forHeaderFooterViewReuseIdentifier: ProductListHeaderView.identifier)
        
        fetchData(of: currentPage, keyword: currentKeyword)
    }
}

extension ProductListViewController: UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? ProductListCell else { return UITableViewCell() }
        
        let product = productList[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductListHeaderView.identifier) as? ProductListHeaderView
        header?.setup(tags: tags, delegate: self)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productList[indexPath.row]
        let detailViewController = ProductDetailViewController()
        
        detailViewController.product = selectedProduct
        self.show(detailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1) / 15 + 1 == currentPage {
                self.fetchData(of: currentPage, keyword: currentKeyword)
            }
        }
    }
}

private extension ProductListViewController {
    func fetchData(of page: Int, keyword: String) {
        guard let url = URL(string: "https://bmap.haveandbe.com/product_json.asp?pg=\(page)&linename=\(keyword)"),
              dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let products = try? JSONDecoder().decode([Product].self, from: data) else {
                      print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                      return
                  }
            
            switch response.statusCode {
            case (200...299):
                self.productList += products
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
                    self.tableView.reloadSections([0], with: .none)
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

extension ProductListViewController: ProductListHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        self.currentKeyword = tags[selectedIndex]
        
        self.productList = []
        self.currentPage = 1
        
        //tableView.reloadData()
        self.fetchData(of: currentPage, keyword: currentKeyword)
    }
}
