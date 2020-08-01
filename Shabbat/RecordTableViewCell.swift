//
//  RecordTableViewCell.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 31/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    enum City: Int {
        case jerusalem = 0
        case telAviv = 1
        case haifa = 2
        case beerSheva = 3
    }
    
    @IBOutlet weak var parashaLabel: UILabel!
    @IBOutlet weak var hebDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var citySegment: UISegmentedControl!
    @IBOutlet weak var timeInLabel: UILabel!
    @IBOutlet weak var timeOutLabel: UILabel!
    
    private var record: Record?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateRecord(with newValue: Record) {
        self.record = newValue
        
        self.parashaLabel.text = newValue.parasha
        self.hebDateLabel.text = newValue.hebDate
        self.dateLabel.text = newValue.date
        
        let dateFormatter = DateFormatter.serverDateFormatter
        if let date: Date = dateFormatter.date(from: newValue.date) {
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            dateFormatter.calendar = Calendar.current
            
            let dateString = dateFormatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        if let selectedCity = RecordTableViewCell.City(rawValue: self.citySegment.selectedSegmentIndex) {
            switch selectedCity {
            case .jerusalem:
                self.timeInLabel.text = newValue.jerusalemIn
                self.timeOutLabel.text = newValue.jerusalemOut
            case .telAviv:
                self.timeInLabel.text = newValue.telAvivIn
                self.timeOutLabel.text = newValue.telAvivOut
            case .haifa:
                self.timeInLabel.text = newValue.hayfaIn
                self.timeOutLabel.text = newValue.hayfaOut
            case .beerSheva:
                self.timeInLabel.text = newValue.beerShevaIn
                self.timeOutLabel.text = newValue.beerShevaOut
            }
        } else {
            self.citySegment.selectedSegmentIndex = 3
            self.timeInLabel.text = newValue.jerusalemIn
            self.timeOutLabel.text = newValue.jerusalemOut
        }
    }
    
    private func changeTimes() {
        if let _ = self.record {
            self.updateRecord(with: self.record!)
        }
    }
    
    @IBAction func onPressCity(_ sender: Any) {
        self.changeTimes()
    }
}
