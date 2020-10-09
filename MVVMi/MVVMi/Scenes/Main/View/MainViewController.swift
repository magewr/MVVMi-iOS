import UIKit

class MainViewController: RxViewController<MainViewModel> {
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 외부에서 주입받아야 하지만 최초 화면이라 일단 자기스스로 생성
        self.viewModel = MainViewModel(dependency: MainViewModel.Dependency(numberInteractor: NumberInteractor(client: RestClient())))
        
        self.bindInputs()
        self.bindOutputs()
        
        self.viewModel.input.getNumberOfDay.onNext(())
    }

    func bindInputs() {
        
    }

    func bindOutputs() {
        self.viewModel.output.loadNumberOfDay
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] number in
                guard let self = self else { return }
                self.numberLabel.text = number
            })
            .disposed(by: self.disposeBag)
    }
}

