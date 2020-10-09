import Foundation
import RxSwift
import RxRelay
import RxCocoa

class MainViewModel: RxViewModel, RxViewModelProtocol {
    struct Input {
        var getNumberOfDay: AnyObserver<Void>
    }

    struct Output {
        var loadNumberOfDay: Observable<String>
        var error: Observable<String>
    }

    struct Dependency {
        var numberInteractor: NumberInteractorProtocol
    }

    var input: MainViewModel.Input!
    var output: MainViewModel.Output!
    var dependency: MainViewModel.Dependency!
    private var getNumberOfDaySubject = PublishSubject<Void>()
    private var loadNumberOfDaySubject = PublishRelay<String>()
    private var errorSubject = PublishRelay<String>()
    
    init(dependency: Dependency) {
        super.init()
        self.initialize()
        self.dependency = dependency
        self.bindInputs()
        self.bindOutputs()
    }
    
    override func initialize() {
        self.input = MainViewModel.Input(getNumberOfDay: self.getNumberOfDaySubject.asObserver())
        self.output = MainViewModel.Output(loadNumberOfDay: self.loadNumberOfDaySubject.asObservable(),
                                           error: self.errorSubject.asObservable())
    }
    
    func bindInputs() {
        self.getNumberOfDaySubject
            .flatMap{ self.dependency.numberInteractor.requestNumberOfDay(param: NumberParam()) }
            .compactMap{$0.contents?.nod?.numbers?.number}
            .subscribe(onNext: { [weak self] number in
                guard let self = self else { return}
                self.loadNumberOfDaySubject.accept(number)
            }, onError: { [weak self] error in
                guard let self = self else { return}
                self.errorSubject.accept(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindOutputs() {
    }
}
