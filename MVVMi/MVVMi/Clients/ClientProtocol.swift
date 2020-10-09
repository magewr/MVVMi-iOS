import Foundation
import RxSwift

protocol ClientProtocol: class {
    func request(url: String, parameters: [String : Any]) -> Single<Data>
}
