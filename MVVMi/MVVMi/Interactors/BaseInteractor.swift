import Foundation
import RxSwift

protocol BaseInteractorProtocol: AnyObject, Deinitializable {
    func request<T, R : Decodable>(url: String, param: T) -> Single<R>
    func deinitialize()
}

class BaseInteractor: BaseInteractorProtocol {
    private lazy var jsonDecoder = JSONDecoder()
    let client: ClientProtocol!
    var disposeBag = DisposeBag()
    func deinitialize() {
        self.disposeBag = DisposeBag()
    }

    public init(client: ClientProtocol) {
        self.client = client
    }
    
    func paramValidateCheck<T>(param: T, url: String) -> Bool {
        return true
    }
    
    func request<T, R : Decodable>(url: String, param: T) -> Single<R> {
        return Single<R>.create { [weak self] single in
            guard let self = self else {
                single(.failure(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.systemDeallocated.rawValue, userInfo: nil)))
                return Disposables.create()
            }

            guard self.paramValidateCheck(param: param, url: url) else {
                single(.failure(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidParameter.rawValue, userInfo: nil)))
                return Disposables.create()
            }
            
            let paramDictionary = self.paramToDictionary(param: param)
            
            self.client.request(url: url, parameters: paramDictionary)
                .subscribe(onSuccess: { data in
                    do {
                        let responseModel = try self.jsonDecoder.decode(R.self, from: data)
                        single(.success(responseModel))
                    }
                    catch {
                        single(.failure(NSError(domain: "\(#file):\(#function):\(#line):\(#column)", code: ClientError.networkInvalidParse.rawValue, userInfo: nil)))
                    }
                }, onFailure: { error in
                    single(.failure(error))
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    private func paramToDictionary<T>(param: T) -> [String : Any] {
        let mirror = Mirror(reflecting: param)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            if label.contains("path_") { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
}
