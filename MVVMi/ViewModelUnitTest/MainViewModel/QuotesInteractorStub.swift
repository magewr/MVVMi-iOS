import Foundation
import RxSwift

class QuotesInteractorStub: BaseInteractorStub, QuotesInteractorProtocol {
    func requestRandomQuotes(param: QuotesParam) -> Single<QuotesResultModel> {
        return super.request()
    }
}
