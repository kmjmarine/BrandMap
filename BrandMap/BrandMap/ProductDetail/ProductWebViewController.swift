//
//  ProductWebViewController.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/06/24.
//

import UIKit
import WebKit

final class ProductWebViewController: UIViewController {
    private let webView = WKWebView()
    private var product: String
    
    init(search: String) {
        product = search
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView(with: product)
    }
    
    func setupWebView(with search: String) {
        let basicURL: String = "https://www.drjart.com/search"
        let keyword: String = search.replacingOccurrences(of: "Dr.Jart+ ", with: "")
        
        var components = URLComponents(string: basicURL)
        let id = URLQueryItem(name: "search", value: keyword)
        components?.queryItems = [id]
        
        guard let linkURL = components?.url
        else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
 
        let urlRequest = URLRequest(url: linkURL)
        
        webView.load(urlRequest)
    }
    
}
