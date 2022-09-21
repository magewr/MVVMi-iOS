import UIKit
import RxSwift
import Then
import SnapKit

class MainViewController: RxViewController<MainViewModel> {
    private var quotesLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    private var nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemGray5
        $0.setTitleColor(.label, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.bindInputs()
        self.bindOutputs()
        
        self.viewModel.input.getRandomQuotes.accept(())
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.systemBackground
        self.view.add(
            self.quotesLabel,
            self.nextBtn
        )
        
        self.quotesLabel.snp.makeConstraints { target in
            target.centerX.centerY.equalToSuperview()
            target.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.nextBtn.snp.makeConstraints { target in
            target.bottom.equalToSuperview().inset(64)
            target.leading.trailing.equalToSuperview().inset(24)
            target.height.equalTo(48)
        }
    }

    func bindInputs() {
        self.nextBtn.rx.throttleTap
            .withUnretained(self)
            .subscribe(onNext: { (self, _) in
                self.viewModel.input.getRandomQuotes.accept(())
            })
            .disposed(by: self.disposeBag)
    }

    func bindOutputs() {
        self.viewModel.output.getRandomQuotesResult
            .withUnretained(self)
            .emit(onNext: { (self, quotes) in
                self.quotesLabel.text = quotes
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.error
            .withUnretained(self)
            .emit(onNext: { (self, errorMessage) in
                print(errorMessage)
            })
            .disposed(by: self.disposeBag)

    }
}

