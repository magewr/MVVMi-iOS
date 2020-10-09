import Foundation

// MARK: - NumberResultModel
struct NumberResultModel: Codable {
    let success: Success?
    let copyright: Copyright?
    let contents: Contents?
}

// MARK: - Contents
struct Contents: Codable {
    let nod: Nod?
}

// MARK: - Nod
struct Nod: Codable {
    let numbers: Numbers?
}

// MARK: - Numbers
struct Numbers: Codable {
    let number, uuid, id: String?
    let category: String?
}

// MARK: - Bases
struct Bases: Codable {
    let binary, ternary, quaternary, quinary: Binary?
    let senary, octal, duodecimal, hexadecimal: Binary?
    let vigesimal: Binary?
}

// MARK: - Binary
struct Binary: Codable {
    let name, binaryDescription, value, display: String?

    enum CodingKeys: String, CodingKey {
        case name
        case binaryDescription = "description"
        case value, display
    }
}

// MARK: - GeneralFacts
struct GeneralFacts: Codable {
    let odd, even, palindrome, triangle: Even?
}

// MARK: - Even
struct Even: Codable {
    let name, evenDescription: String?
    let value: Bool?
    let display: String?

    enum CodingKeys: String, CodingKey {
        case name
        case evenDescription = "description"
        case value, display
    }
}

// MARK: - Names
struct Names: Codable {
    let nominal, cardinal, ordinal, usCurrency: Binary?

    enum CodingKeys: String, CodingKey {
        case nominal, cardinal, ordinal
        case usCurrency = "us_currency"
    }
}

// MARK: - Numerals
struct Numerals: Codable {
    let roman, chinese, egyptian, babylonian: Binary?
}

// MARK: - PrimeFacts
struct PrimeFacts: Codable {
    let prime, perfect, mersenne, fermat: Even?
    let fibonacci, partition, pell: Even?
}

// MARK: - Recreational
struct Recreational: Codable {
    let reverse: Binary?
    let digitssum, noofdigits: Digitssum?
}

// MARK: - Digitssum
struct Digitssum: Codable {
    let name, digitssumDescription: String?
    let value, display: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case digitssumDescription = "description"
        case value, display
    }
}

// MARK: - Copyright
struct Copyright: Codable {
    let copyright: String?
}

// MARK: - Success
struct Success: Codable {
    let total: Int?
}
