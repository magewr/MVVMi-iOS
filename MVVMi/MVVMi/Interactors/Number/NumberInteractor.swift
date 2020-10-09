import Foundation
import RxSwift

protocol NumberInteractorProtocol : BaseInteractorProtocol {
    func requestNumberOfDay(param: NumberParam) -> Single<NumberResultModel>
}

class NumberInteractor: BaseInteractor, NumberInteractorProtocol {
    func requestNumberOfDay(param: NumberParam) -> Single<NumberResultModel> {
        return super.request(url: baseUrl + "/numbers/nod", param: param)
    }
}
