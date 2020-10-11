import UIKit

class MainViewController: RxViewController<MainViewModel> {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 외부에서 주입받아야 하지만 최초 화면이라 일단 자기스스로 생성
        self.viewModel = MainViewModel(dependency: MainViewModel.Dependency(quotesInteractor: QuotesInteractor(client: RestClient())))
        
        self.bindInputs()
        self.bindOutputs()
        
        self.viewModel.input.getRandomQuotes.onNext(())
    }

    func bindInputs() {
        self.nextBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.getRandomQuotes.onNext(())
            })
            .disposed(by: self.disposeBag)
    }

    func bindOutputs() {
        self.viewModel.output.getRandomQuotesResult
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] quotes in
                guard let self = self else { return }
                self.numberLabel.text = quotes
            })
            .disposed(by: self.disposeBag)
    }
}

