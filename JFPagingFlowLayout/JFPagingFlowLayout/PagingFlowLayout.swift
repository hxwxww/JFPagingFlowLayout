//
//  PagingFlowLayout.swift
//  JFPagingFlowLayout
//
//  Created by HongXiangWen on 2020/4/16.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

open class PagingFlowLayout: UICollectionViewFlowLayout {

    public enum PagingStyle {
        case centered
        case leadingBoundary(spacing: CGFloat)
        case none
    }
    
    struct Group {
        let index: Int
        let frame: CGRect
        let layoutAttributes: [UICollectionViewLayoutAttributes]
        
        static var empty: Group {
            return Group(index: 0, frame: .zero, layoutAttributes: [])
        }
    }
    
    open var pagingStyle: PagingStyle = .centered
    open var numberOfItemsInGroup: Int = 1
    
    private var currentCollectionView: UICollectionView {
        guard let collectionView = collectionView else {
            fatalError("collectionView should not be nil")
        }
        if collectionView.isPagingEnabled {
            collectionView.isPagingEnabled = false
        }
        return collectionView
    }
    
    public override init() {
        super.init()
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        scrollDirection = .horizontal
    }
    
    open override func prepare() {
        super.prepare()
        
        guard scrollDirection == .horizontal else {
            fatalError("scrollDirection must be horizontal")
        }
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetContentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        guard let layoutAttributes = layoutAttributesForElements(in: currentCollectionView.bounds) else {
            return targetContentOffset
        }
        switch pagingStyle {
        case .centered:
            let midSide = currentCollectionView.bounds.size.width / 2
            let proposedContentOffsetCenterX = proposedContentOffset.x + midSide
            let closestLayoutAttributes = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterX) < abs($1.center.x - proposedContentOffsetCenterX) }.first
            
            let group = layoutGroup(for: closestLayoutAttributes)
            
            targetContentOffset = CGPoint(x: group.frame.midX - midSide, y: proposedContentOffset.y)
        case .leadingBoundary(let spacing):
            let closestLayoutAttributes = layoutAttributes.sorted { abs($0.frame.minX - proposedContentOffset.x) < abs($1.frame.minX - proposedContentOffset.x) }.first
            
            let group = layoutGroup(for: closestLayoutAttributes)
            
            let targetContentOffsetX = group.index == 0 ? 0 : group.frame.minX - spacing
            targetContentOffset = CGPoint(x: targetContentOffsetX, y: proposedContentOffset.y)
        case .none:
            break
        }
        return targetContentOffset
    }
    
    private func layoutGroup(for layoutAttributes: UICollectionViewLayoutAttributes?) -> Group {
        guard let layoutAttributes = layoutAttributes else { return .empty }
        let groupIndex = layoutAttributes.indexPath.item / numberOfItemsInGroup
        let startIndex = groupIndex * numberOfItemsInGroup
        let endIndex = (groupIndex + 1) * numberOfItemsInGroup
        var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
        for index in startIndex ..< endIndex {
            if let groupLayoutAttributes = super.layoutAttributesForItem(at: IndexPath(item: index, section: 0)) {
                layoutAttributesArray.append(groupLayoutAttributes)
            }
        }
        var minX: CGFloat = .infinity
        var minY: CGFloat = .infinity
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        for layoutAttributes in layoutAttributesArray {
            minX = min(layoutAttributes.frame.minX, minX)
            minY = min(layoutAttributes.frame.minY, minY)
            maxX = max(layoutAttributes.frame.maxX, maxX)
            maxY = max(layoutAttributes.frame.maxY, maxY)
        }
        let frame = CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        return Group(index: groupIndex, frame: frame, layoutAttributes: layoutAttributesArray)
    }
}
