//
//  TabbarController.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/03/06.
//

import UIKit

final class TabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statisticsController = UINavigationController(rootViewController: StatisticsViewContoroller())
        statisticsController.tabBarItem = UITabBarItem(title: "SKUs Statistics", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let productListContoller = UINavigationController(rootViewController: ProductListViewController())
        productListContoller.tabBarItem = UITabBarItem(title: "BrandMap", image: UIImage(systemName: "cross.case"), selectedImage: UIImage(systemName: "cross.case.fill"))
        
        viewControllers = [statisticsController, productListContoller]
    }
}
