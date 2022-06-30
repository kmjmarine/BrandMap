//
//  ProductListHeaderView.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/06/26.
//

import UIKit
import TTGTags
import SnapKit

protocol ProductListHeaderViewDelegate: AnyObject {
    func didSelectTag(_ selectedIndex: Int)
}

final class ProductListHeaderView: UITableViewHeaderFooterView {
    static let identifier = "ProductListHeaderView"
    
    private weak var delegate: ProductListHeaderViewDelegate?
    
    private var tags: [String] = []
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setup(tags: [String], delegate: ProductListHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate
        contentView.backgroundColor = .systemBackground
        
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}

extension ProductListHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
    
        delegate?.didSelectTag(Int(index))
    }
}

private extension ProductListHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTagCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        let insetValue: CGFloat = 16.0
        tagCollectionView.contentInset = UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue)
        
        let cornerRadiusValue = 12.0
        let shadowOpacityValue = 0.0
        let extraSpaceValue = CGSize(width: 20.0, height: 12.0)
        let color = UIColor.systemGray3
        
        let style = TTGTextTagStyle()
        style.backgroundColor = color
        style.cornerRadius = cornerRadiusValue
        style.borderWidth = 0.0
        style.shadowOpacity = shadowOpacityValue
        style.extraSpace = extraSpaceValue
        
        let selectStyle = TTGTextTagStyle()
        selectStyle.backgroundColor = .black
        selectStyle.cornerRadius = cornerRadiusValue
        selectStyle.shadowOpacity = shadowOpacityValue
        selectStyle.extraSpace = extraSpaceValue
        selectStyle.borderColor = color
     
        tags.forEach { tag in
            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            let tagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .white
            )
            let selectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: color
            )
            
            let tag = TTGTextTag(
                content: tagContents,
                style: style,
                selectedContent: selectedTagContents,
                selectedStyle: selectStyle
            )
            
            tagCollectionView.addTag(tag)
        }
    }
}
