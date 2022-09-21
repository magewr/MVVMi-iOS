import Foundation
import RxSwift
import RxRelay
import RxCocoa

class MainViewModel: RxViewModel, RxViewModelProtocol {
    struct Input {
        var getRandomQuotes: PublishRelay<Void>
    }

    struct Output {
        var getRandomQuotesResult: Signal<String>
        var error: Signal<String>
    }

    struct Dependency {
        var quotesInteractor: QuotesInteractorProtocol
    }

    var input: MainViewModel.Input!
    var output: MainViewModel.Output!
    var dependency: MainViewModel.Dependency!
    private var getRandomQuotesRelay = PublishRelay<Void>()
    private var getRandomQuotesResultRelay = PublishRelay<String>()
    private var errorSubject = PublishRelay<String>()
    
    init(dependency: Dependency) {
        super.init()
        self.initialize()
        self.dependency = dependency
        self.bindInputs()
        self.bindOutputs()
    }
    
    override func initialize() {
        self.input = MainViewModel.Input(getRandomQuotes: self.getRandomQuotesRelay)
        self.output = MainViewModel.Output(getRandomQuotesResult: self.getRandomQuotesResultRelay.asSignal(),
                                           error: self.errorSubject.asSignal())
    }
    
    func bindInputs() {
        self.getRandomQuotesRelay
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap{ self.dependency.quotesInteractor.requestRandomQuotes(param: QuotesParam()) }
            .compactMap{ $0.en }
            .withUnretained(self)
            .subscribe(onNext: {(self, quotes) in
                self.getRandomQuotesResultRelay.accept(quotes)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.errorSubject.accept(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindOutputs() {
    }
}
