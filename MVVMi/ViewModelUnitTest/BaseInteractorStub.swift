import Foundation
import RxSwift

class BaseInteractorStub: BaseInteractorProtocol {
    var resultData: Data!
    
    func deinitialize() {
        self.resultData = nil
    }
    
    init(resultData: Data) {
        self.resultData = resultData
    }
    
    func request<R>() -> Single<R> where R : Decodable {
        return request(url: "url", param: "param")
    }
    
    func request<T, R>(url: String, param: T) -> Single<R> where R : Decodable {
        return Single<R>.create { [weak self] single in
            guard let self = self else {
                single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.systemDeallocated.rawValue, userInfo: nil)))
                return Disposables.create()
            }
            
            do {
                let responseModel = try JSONDecoder().decode(R.self, from: self.resultData)
                single(.success(responseModel))
            }
            catch {
                single(.error(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidParse.rawValue, userInfo: nil)))
            }

            return Disposables.create()
        }
    }
    
    
}
