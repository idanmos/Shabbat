//
//  HomeViewController.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 29/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var storyContainerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var noDataView: UIView!
    
    fileprivate var selectedMonth: String = Date.localizedCurrentMonth
    fileprivate var storyCollectionViewController: StoryCollectionViewController!
    
    fileprivate var datasource: [String: [Record]] = [:]
    fileprivate var sortedRecords: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.backgroundView = self.noDataView
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        NetworkManager.shared.fetchShabbatRecords { [weak self] (records: [Record]) in
            guard let weakSelf = self else { return }
            
            for record: Record in records {
                // Ignore old date
                if let date = DateFormatter.serverDateFormatter.date(from: record.date) {
                    if date <= Date() {
                        continue
                    }
                }
                
                // Extract Hebrew month name
                let hebDateComponents = record.hebDate.components(separatedBy: " ")
                let month = hebDateComponents[1]
                
                if let _ = weakSelf.datasource[month] {} else {
                    weakSelf.datasource[month] = []
                }
                 weakSelf.datasource[month]!.append(record)
            }
            
            // Reload screen
            DispatchQueue.main.async {
                weakSelf.select(hebrewMonthName: Date.localizedCurrentMonth)
                weakSelf.tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.storyCollectionViewController = (segue.destination as! StoryCollectionViewController)
        self.storyCollectionViewController.delegate = self
    }
    
    // MARK: - General
    
    fileprivate func select(hebrewMonthName: String) {
        self.selectedMonth = hebrewMonthName
        
        let dateFormatter = DateFormatter.serverDateFormatter
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        
        self.sortedRecords.removeAll()
        
        if let records: [Record] = self.datasource[self.selectedMonth] {
            let sortedRecords: [Record] = records.sorted { (first: Record, second: Record) -> Bool in
                if let firstDate = dateFormatter.date(from: first.date), let secondDate = dateFormatter.date(from: second.date) {
                    return firstDate < secondDate
                } else {
                    return true
                }
            }
            
            self.sortedRecords = sortedRecords
        }
        
        self.tableView.reloadData()
    }

}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        let record: Record = self.sortedRecords[indexPath.row]
        cell.updateRecord(with: record)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.sortedRecords.count
        tableView.backgroundView?.isHidden = rows > 0
        return rows
    }
    
}

extension HomeViewController: StoryCollectionViewControllerDelegate {
    
    func storyCollectionView(_ storyCollectionView: StoryCollectionViewController, didSelect month: String) {
        self.select(hebrewMonthName: month)
    }
    
}
