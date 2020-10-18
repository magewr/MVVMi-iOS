import Foundation
import RxSwift
import RxRelay
import RxCocoa

class MainViewModel: RxViewModel, RxViewModelProtocol {
    struct Input {
        var getRandomQuotes: AnyObserver<Void>
    }

    struct Output {
        var getRandomQuotesResult: Observable<String>
        var error: Observable<String>
    }

    struct Dependency {
        var quotesInteractor: QuotesInteractorProtocol
    }

    var input: MainViewModel.Input!
    var output: MainViewModel.Output!
    var dependency: MainViewModel.Dependency!
    private var getRandomQuotesSubject = PublishSubject<Void>()
    private var getRandomQuotesResultSubject = PublishRelay<String>()
    private var errorSubject = PublishRelay<String>()
    
    init(dependency: Dependency) {
        super.init()
        self.initialize()
        self.dependency = dependency
        self.bindInputs()
        self.bindOutputs()
    }
    
    override func initialize() {
        self.input = MainViewModel.Input(getRandomQuotes: self.getRandomQuotesSubject.asObserver())
        self.output = MainViewModel.Output(getRandomQuotesResult: self.getRandomQuotesResultSubject.asObservable(),
                                           error: self.errorSubject.asObservable())
    }
    
    func bindInputs() {
        self.getRandomQuotesSubject
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap{ self.dependency.quotesInteractor.requestRandomQuotes(param: QuotesParam()) }
            .compactMap{ $0.en }
            .subscribe(onNext: { [weak self] quotes in
                guard let self = self else { return}
                self.getRandomQuotesResultSubject.accept(quotes)
            }, onError: { [weak self] error in
                guard let self = self else { return}
                self.errorSubject.accept(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindOutputs() {
    }
}
