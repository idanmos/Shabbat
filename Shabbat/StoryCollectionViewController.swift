//
//  StoryCollectionViewController.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 30/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import UIKit

protocol StoryCollectionViewControllerDelegate: class {
    func storyCollectionView(_ storyCollectionView: StoryCollectionViewController, didSelect month: String)
}

class StoryCollectionViewController: UICollectionViewController {
    
    weak var delegate: StoryCollectionViewControllerDelegate?
    
    private let months: [String] = Date.localizedMonths.reversed()
    fileprivate var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
                
        // Scroll to current Hebrew month
        if let index = self.months.firstIndex(of: Date.localizedCurrentMonth) {
            DispatchQueue.main.async {
                let indexPath = IndexPath(item: index, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                
                self.showEventsForMonth(at: indexPath)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier, for: indexPath) as! StoryCollectionViewCell
        
        cell.imageView.image = UIImage(named: "flower_\(indexPath.item)")
        
        let month = months[indexPath.item]
        cell.titleLabel.text = month
        
        if let _ = self.selectedIndexPath, self.selectedIndexPath!.item == indexPath.item {
            cell.currentMonthView.isHidden = false
        } else {
            cell.currentMonthView.isHidden = true
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showEventsForMonth(at: indexPath)
    }
    
    private func showEventsForMonth(at indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        
        // Circle the selected month with green color
        for visibleIndexPath: IndexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: visibleIndexPath) as? StoryCollectionViewCell {
                if visibleIndexPath.item == indexPath.item {
                    cell.currentMonthView.isHidden = false
                } else {
                    cell.currentMonthView.isHidden = true
                }
            }
        }
                
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let selectedMonth = months[indexPath.item]
        self.delegate?.storyCollectionView(self, didSelect: selectedMonth)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
