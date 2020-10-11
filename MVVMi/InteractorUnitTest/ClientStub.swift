import Foundation
import RxSwift

class ClientStub: ClientProtocol{
    let data: Data
    init(data: Data) {
        self.data = data
    }
    
    func request(url: String, parameters: [String : Any]) -> Single<Data> {
        return Single<Data>.create { single in
            if let json = ((try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]) as [String : AnyObject]??) {
                if let msg = json?["msg"] as? String, let code = json?["code"] as? String {
                    single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidRequest.rawValue, userInfo: ["msg" : msg, "code" : code])))
                    return Disposables.create()
                }
            }

            single(.success(self.data))
            return Disposables.create()
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
