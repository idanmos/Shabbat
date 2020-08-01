// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shabbatResponseData = try? newJSONDecoder().decode(ShabbatResponseData.self, from: jsonData)

import Foundation

// MARK: - ShabbatResponseData
struct ShabbatResponseData: Codable {
    let help: String
    let success: Bool
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let includeTotal: Bool
    let resourceID: String
    let fields: [Field]
    let recordsFormat: String
    let records: [Record]
    let links: Links

    enum CodingKeys: String, CodingKey {
        case includeTotal = "include_total"
        case resourceID = "resource_id"
        case fields
        case recordsFormat = "records_format"
        case records
        case links = "_links"
    }
}

// MARK: - Field
struct Field: Codable {
    let type: TypeEnum
    let id: String
}

enum TypeEnum: String, Codable {
    case int = "int"
    case text = "text"
    case timestamp = "timestamp"
}

// MARK: - Links
struct Links: Codable {
    let start, next: String
}

// MARK: - Record
struct Record: Codable {
    let id: Int
    let parasha, hebDate, date, jerusalemIn: String
    let jerusalemOut, telAvivIn, telAvivOut, hayfaIn: String
    let hayfaOut, beerShevaIn, beerShevaOut: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case parasha
        case hebDate = "heb_date"
        case date
        case jerusalemIn = "Jerusalem_in"
        case jerusalemOut = "Jerusalem_out"
        case telAvivIn = "TelAviv_in"
        case telAvivOut = "TelAviv_out"
        case hayfaIn = "Hayfa_in"
        case hayfaOut = "Hayfa_out"
        case beerShevaIn = "BeerSheva_in"
        case beerShevaOut = "BeerSheva_out"
    }
}

