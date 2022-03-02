//
//  ProductDetailListCell.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/28.
//

import UIKit
import SnapKit

final class ProductDetailListCell: UITableViewCell {
    let scrollView = UIScrollView()
    let contentsView = UIView()
    
    var relatedImageView1: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    var relatedImageView2: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    var relatedImageView3: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    var relatedImageView4: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    var relatedImageView5: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    var relatedImageView6: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //backgroundColor = .blue

        [ relatedImageView1, relatedImageView2, relatedImageView3, relatedImageView4, relatedImageView5, relatedImageView6 ].forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentsView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }

        relatedImageView1.contentMode = .scaleAspectFit
        relatedImageView1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(80.0)
            $0.height.equalTo(100.0)
        }
        
        relatedImageView2.contentMode = .scaleAspectFit
        relatedImageView2.snp.makeConstraints {
            $0.leading.equalTo(relatedImageView1.snp.trailing)
            $0.top.equalTo(relatedImageView1.snp.top)
            $0.width.equalTo(relatedImageView1.snp.width)
            $0.height.equalTo(relatedImageView1.snp.height)
        }
        
        relatedImageView3.contentMode = .scaleAspectFit
        relatedImageView3.snp.makeConstraints {
            $0.leading.equalTo(relatedImageView2.snp.trailing)
            $0.top.equalTo(relatedImageView2.snp.top)
            $0.width.equalTo(relatedImageView2.snp.width)
            $0.height.equalTo(relatedImageView2.snp.height)
        }
        
        relatedImageView4.contentMode = .scaleAspectFit
        relatedImageView4.snp.makeConstraints {
            $0.leading.equalTo(relatedImageView3.snp.trailing)
            $0.top.equalTo(relatedImageView3.snp.top)
            $0.width.equalTo(relatedImageView3.snp.width)
            $0.height.equalTo(relatedImageView3.snp.height)
        }
        
        relatedImageView5.contentMode = .scaleAspectFit
        relatedImageView5.snp.makeConstraints {
            $0.leading.equalTo(relatedImageView4.snp.trailing)
            $0.top.equalTo(relatedImageView4.snp.top)
            $0.width.equalTo(relatedImageView4.snp.width)
            $0.height.equalTo(relatedImageView4.snp.height)
        }
        
        relatedImageView6.contentMode = .scaleAspectFit
        relatedImageView6.snp.makeConstraints {
            $0.leading.equalTo(relatedImageView5.snp.trailing)
            $0.top.equalTo(relatedImageView5.snp.top)
            $0.width.equalTo(relatedImageView5.snp.width)
            $0.height.equalTo(relatedImageView5.snp.height)
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalTo(0)
            $0.width.equalTo((relatedImageView1.image!.size.width * frame.height / relatedImageView1.image!.size.height) * 6 + 30)
            $0.height.equalTo(100.0)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ProductDetailListCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with subImages: String) {
        let images = subImages.components(separatedBy: ",")
        print(images.count)
        for i in 0...images.count-1 {
            if i == 0 {
                let imageURL1 = URL(string: images[0])
                relatedImageView1.kf.setImage(with: imageURL1, placeholder: #imageLiteral(resourceName: "noimage"))
            }
            if i == 1 {
                let imageURL2 = URL(string: images[1])
                relatedImageView2.kf.setImage(with: imageURL2, placeholder: #imageLiteral(resourceName: "noimage"))
            }
            if i == 2 {
                let imageURL3 = URL(string: images[2])
                relatedImageView3.kf.setImage(with: imageURL3, placeholder: #imageLiteral(resourceName: "noimage"))
            }
            if i == 3 {
                let imageURL4 = URL(string: images[3])
                relatedImageView4.kf.setImage(with: imageURL4, placeholder: #imageLiteral(resourceName: "noimage"))
            }
            if i == 4 {
                let imageURL5 = URL(string: images[4])
                relatedImageView5.kf.setImage(with: imageURL5, placeholder: #imageLiteral(resourceName: "noimage"))
            }
            if i == 5 {
                let imageURL6 = URL(string: images[5])
                relatedImageView5.kf.setImage(with: imageURL6, placeholder: #imageLiteral(resourceName: "noimage"))
            }
        }
    }
}


