import Foundation

public enum ClientError: Int {
    case success = 0
    case networkTooManyRequest = 429
    case networkInvalidUrl = 40000
    case networkInvalidResponseData
    case networkInvalidParameter
    case networkInvalidStatus
    case networkInvalidParse
    case networkInvalidRequest

    case systemDeallocated = 44444
    case unknownCode = 55555

    static func messageKey(value: Int) -> String {
        switch value {
        case Self.success.rawValue: return "success"
        case Self.networkTooManyRequest.rawValue: return "networkTooManyRequest"
        case Self.networkInvalidUrl.rawValue: return "networkInvalidUrl"
        case Self.networkInvalidResponseData.rawValue: return "networkInvalidResponseData"
        case Self.networkInvalidParameter.rawValue: return "networkInvalidParameter"
        case Self.networkInvalidStatus.rawValue: return "networkInvalidStatus"
        case Self.networkInvalidParse.rawValue: return "networkInvalidParse"
        case Self.networkInvalidRequest.rawValue: return "networkInvalidRequest"
        case Self.systemDeallocated.rawValue: return "systemDeallocated"
        default:
            return "unknownCode"
        }
    }
}
