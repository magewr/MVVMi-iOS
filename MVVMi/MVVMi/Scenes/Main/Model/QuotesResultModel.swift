import Foundation

// MARK: - QuotesResultModel
struct QuotesResultModel: Codable {
    let id, en, author, quotesResultModelID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case en, author
        case quotesResultModelID = "id"
    }
}
