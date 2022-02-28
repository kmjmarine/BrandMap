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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let arrSubImage = [product?.subimageurls]
            return arrSubImage.count
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
            let isProdSizeEmpty = product?.prodsize?.isEmpty ?? true
            return isProdSizeEmpty ? nil : "Size"
        case 4:
            let isBoxSizeEmpty = product?.boxsize?.isEmpty ?? true
            return isBoxSizeEmpty ? nil : "Box Size"
        case 5:
            let isSpecEmpty = product?.spec?.isEmpty ?? true
            return isSpecEmpty ? nil : "Spec"
        case 6:
            let isLaunchDateEmpty = product?.launchdate?.isEmpty ?? true
            return isLaunchDateEmpty ? nil : "Release"
        case 7:
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
            let arrSubImage = [product?.subimageurls]
            
            cell.textLabel?.text = arrSubImage[indexPath.row] ?? ""
            
//            let imageURL = URL(string: arrSubImage[indexPath.row] ?? "")
//            UIImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "beer_icon"))
            
            return cell
        case 1:
            cell.textLabel?.text = product?.line ?? ""
            return cell
        case 2:
            cell.textLabel?.text = product?.channel ?? ""
            return cell
        case 3:
            cell.textLabel?.text = product?.prodsize ?? "no content"
            return cell
        case 4:
            cell.textLabel?.text = product?.boxsize ?? "no content"
            return cell
        case 5:
            cell.textLabel?.text = product?.spec ?? "no content"
            return cell
        case 6:
            cell.textLabel?.text = product?.launchdate ?? ""
            return cell
        case 7:
            cell.textLabel?.text = product?.type ?? ""
            return cell
        default:
            return cell
        }
    }
}
