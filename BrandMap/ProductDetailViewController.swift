//
//  ProductDetailViewController.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/27.
//

import UIKit
import Kingfisher

final class ProductDetailViewController: UITableViewController {
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "About the Product"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(ProductDetailListCell.self, forCellReuseIdentifier: "ProductDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: product?.imageurl ?? "")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "noimage"))
        
        tableView.tableHeaderView = headerView
    }
}

//UITableview Datasource, Delegate
extension ProductDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            guard let arrSpec = product?.spec?.split(separator: ",") else { return 0 }
            return arrSpec.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            let isSubImagesEmpty = product?.subimageurls?.isEmpty ?? true
            return isSubImagesEmpty ? nil : "Related"
        case 1:
            let isLineEmpty = product?.line?.isEmpty ?? true
            return isLineEmpty ? nil : "Line"
        case 2:
            let isChannelEmpty = product?.channel?.isEmpty ?? true
            return isChannelEmpty ? nil : "Channel"
        case 3:
            let isProdSizeEmpty = product?.spec?.isEmpty ?? true
            return isProdSizeEmpty ? nil : "Spec"
        case 4:
            let isLaunchDateEmpty = product?.launchdate?.isEmpty ?? true
            return isLaunchDateEmpty ? nil : "Release"
        case 5:
            let isTypeEmpty = product?.type?.isEmpty ?? true
            return isTypeEmpty ? nil : "Type"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ProductDetailListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            let subImages = product?.subimageurls ?? ""
         
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailListCell", for: indexPath) as? ProductDetailListCell else { return UITableViewCell() }
            
            cell.setup(with: subImages)
            
            return cell
        case 1:
            cell.textLabel?.text = product?.line ?? ""
            return cell
        case 2:
            cell.textLabel?.text = product?.channel ?? ""
            return cell
        case 3:
            guard let arrSpec = product?.spec?.split(separator: ",") else { return cell }
            cell.textLabel?.text = String(describing: arrSpec[indexPath.row])
            return cell
        case 4:
            cell.textLabel?.text = product?.launchdate ?? ""
            return cell
        case 5:
            cell.textLabel?.text = product?.type ?? ""
            return cell
        default:
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.0
        default:
            return 40.0
        }
    }
}
