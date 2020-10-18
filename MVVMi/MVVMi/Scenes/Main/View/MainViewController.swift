import UIKit
import RxSwift

class MainViewController: RxViewController<MainViewModel> {
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindInputs()
        self.bindOutputs()
        
        self.viewModel.input.getRandomQuotes.onNext(())
    }

    func bindInputs() {
        self.nextBtn.rx.tap
            .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
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
                self.quotesLabel.text = quotes
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.error
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { errorMessage in
                print(errorMessage)
            })
            .disposed(by: self.disposeBag)

    }
}

