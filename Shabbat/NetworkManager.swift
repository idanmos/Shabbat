//
//  NetworkManager.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 29/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var records: [Record] = []
    
    func fetchShabbatRecords(shabbatRecords: @escaping ([Record]) -> Void) {
        let url = URL(string: "https://data.gov.il/api/3/action/datastore_search?resource_id=cfe1dd76-a7f8-453a-aa42-88e5db30d567")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let weakSelf = self else { return }
            guard let jsonData = data else { return }
                         
            do {
                let shabbat = try JSONDecoder().decode(ShabbatResponseData.self, from: jsonData)
                
                weakSelf.records = shabbat.result.records
                
                shabbatRecords(shabbat.result.records)
               } catch {
                   debugPrint(error)
               }
        }.resume()
    }
    
}
