import Foundation
import UIKit
import RxSwift

class RxViewController<T>: UIViewController, Deinitializable {
    typealias ViewModel = T
    var viewModel: ViewModel!
    var disposeBag = DisposeBag()
    func deinitialize() {
        self.disposeBag = DisposeBag()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.parent == nil) {
            deinitialize()
        }
    }
}
