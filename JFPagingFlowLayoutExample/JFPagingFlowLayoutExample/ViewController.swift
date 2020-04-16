//
//  ViewController.swift
//  JFPagingFlowLayoutExample
//
//  Created by HongXiangWen on 2020/4/16.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedRowHeight = 0
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        let section1 = buildSection(with: .centerd_singleItem, count: 5)
        let section2 = buildSection(with: .centerd_mutiItem, count: 15)
        let section3 = buildSection(with: .leadingBoundary_singleItem, count: 5)
        let section4 = buildSection(with: .leadingBoundary_multiItem, count: 15)
        let section5 = buildSection(with: .none, count: 5)

        dataSource.sections = [section1, section2, section3, section4, section5]
    }
    
    private func buildSection(with style: LayoutStyle, count: Int) -> TableViewScection<[Int]> {
        let data = (0 ..< count).map { $0 }
        let section = TableViewScection(items: [data]) { (tableView, indexPath, data) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PagingTableViewCell", for: indexPath) as! PagingTableViewCell
            cell.configureCell(data: data, with: style)
            return cell
        }
        section.cellHeightProvider = { _, _, _ in return LayoutSize.pagingCellHeight }
        section.headerTitle = style.rawValue
        section.headerHeight = 40
        section.footerHeight = 0.1

        return section
    }
}

