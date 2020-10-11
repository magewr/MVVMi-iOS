import Foundation
import Alamofire
import RxSwift

class RestClient: ClientProtocol {
    func request(url: String, parameters: [String : Any]) -> Single<Data> {
        let param: [String : String] = parameters.mapValues { value -> String in
            if let value = value as? String {
                return value
            }
            return String(describing: value)
        }

        return Single<Data>.create { single in
            AF.request(url, method: .get, parameters: param).responseData { responseData -> Void in
                switch responseData.result {
                case .success(_) where responseData.response?.statusCode == 200:
                    if let value = responseData.data {
                        if let _ = try? JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments) {
                            single(.success(value))
                        } else {
                            single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidParse.rawValue, userInfo: nil)))
                        }
                    }
                default:
                    if let errorCode = responseData.response?.statusCode {
                        single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidRequest.rawValue, userInfo: ["code" : errorCode])))
                    }
                    else {
                        single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.unknownCode.rawValue)))
                    }
                }
            }
            return Disposables.create()
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
