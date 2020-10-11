import Foundation
import RxSwift

protocol QuotesInteractorProtocol : BaseInteractorProtocol {
    func requestRandomQuotes(param: QuotesParam) -> Single<QuotesResultModel>
}

class QuotesInteractor: BaseInteractor, QuotesInteractorProtocol {
    func requestRandomQuotes(param: QuotesParam) -> Single<QuotesResultModel> {
        return super.request(url: baseUrl + "/quotes/random", param: param)
    }
}
