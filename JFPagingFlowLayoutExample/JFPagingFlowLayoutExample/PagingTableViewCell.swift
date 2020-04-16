//
//  PagingTableViewCell.swift
//  JFPagingFlowLayoutExample
//
//  Created by HongXiangWen on 2020/4/16.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource
import JFPagingFlowLayout

enum LayoutStyle: String {
    case centerd_singleItem
    case centerd_mutiItem
    case leadingBoundary_singleItem
    case leadingBoundary_multiItem
    case none
}

struct LayoutSize {
    
    static let pagingCellHeight: CGFloat = 260
    static let spacing: CGFloat = 16
}

class PagingTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    private let dataSource = CollectionViewDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    func configureCell(data: [Int], with style: LayoutStyle) {
        
        switch style {
        case .centerd_singleItem:
            let layout = createSinglePagingFlowLayout()
            collectionView.collectionViewLayout = layout
            
            let section = CollectionViewSection(items: data) { (collectionView, indexPath, num) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                cell.nameLabel.text = "\(num)"
                return cell
            }
            dataSource.sections = [section]
            
        case .centerd_mutiItem:
            let layout = createGroupPagingFlowLayout()
            collectionView.collectionViewLayout = layout
            
            let groupSize = CGSize(width: UIScreen.main.bounds.width - LayoutSize.spacing * 6, height: LayoutSize.pagingCellHeight - LayoutSize.spacing * 2)

            let section = CollectionViewSection(items: data) { (collectionView, indexPath, num) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                cell.nameLabel.text = "\(num)"
                return cell
            }
            section.cellSizeProvider = { _, _, indexPath, _ in
                if indexPath.item % 3 == 0 {
                    return CGSize(width: groupSize.width * 0.6, height: groupSize.height)
                } else {
                    return CGSize(width: groupSize.width * 0.4 - LayoutSize.spacing, height: (groupSize.height - LayoutSize.spacing) / 2)
                }
            }
            dataSource.sections = [section]
            
        case .leadingBoundary_singleItem:
            let layout = createSinglePagingFlowLayout()
            collectionView.collectionViewLayout = layout
            
            layout.pagingStyle = .leadingBoundary(spacing: LayoutSize.spacing / 2)
            
            let section = CollectionViewSection(items: data) { (collectionView, indexPath, num) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                cell.nameLabel.text = "\(num)"
                return cell
            }
            dataSource.sections = [section]
            
        case .leadingBoundary_multiItem:
            let layout = createGroupPagingFlowLayout()
            collectionView.collectionViewLayout = layout
            
            layout.pagingStyle = .leadingBoundary(spacing: LayoutSize.spacing / 2)

            let groupSize = CGSize(width: UIScreen.main.bounds.width - LayoutSize.spacing * 6, height: LayoutSize.pagingCellHeight - LayoutSize.spacing * 2)
            
            let section = CollectionViewSection(items: data) { (collectionView, indexPath, num) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                cell.nameLabel.text = "\(num)"
                return cell
            }
            section.cellSizeProvider = { _, _, indexPath, _ in
                if indexPath.item % 3 == 0 {
                    return CGSize(width: groupSize.width * 0.6, height: groupSize.height)
                } else {
                    return CGSize(width: groupSize.width * 0.4 - LayoutSize.spacing, height: (groupSize.height - LayoutSize.spacing) / 2)
                }
            }
            dataSource.sections = [section]
            
        case .none:
            let layout = createSinglePagingFlowLayout()
            collectionView.collectionViewLayout = layout
            
            layout.pagingStyle = .none
            
            let section = CollectionViewSection(items: data) { (collectionView, indexPath, num) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                cell.nameLabel.text = "\(num)"
                return cell
            }
            dataSource.sections = [section]
        }
        
        collectionView.reloadData()
    }
    
    private func createSinglePagingFlowLayout() -> PagingFlowLayout {
        let layout = PagingFlowLayout()
        layout.minimumLineSpacing = LayoutSize.spacing
        layout.minimumInteritemSpacing = LayoutSize.spacing
        layout.sectionInset = UIEdgeInsets(top: LayoutSize.spacing, left: LayoutSize.spacing * 3, bottom: LayoutSize.spacing, right: LayoutSize.spacing * 3)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - LayoutSize.spacing * 6, height: LayoutSize.pagingCellHeight - LayoutSize.spacing * 2)
        return layout
    }
    
    private func createGroupPagingFlowLayout() -> PagingFlowLayout {
        let layout = PagingFlowLayout()
        layout.minimumLineSpacing = LayoutSize.spacing
        layout.minimumInteritemSpacing = LayoutSize.spacing
        layout.sectionInset = UIEdgeInsets(top: LayoutSize.spacing, left: LayoutSize.spacing * 3, bottom: LayoutSize.spacing, right: LayoutSize.spacing * 3)
        layout.numberOfItemsInGroup = 3
        return layout
    }
}
