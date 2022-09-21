import Foundation
import RxSwift

protocol RxViewModelProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    var input: Input! { get }
    var output: Output! { get }
}

class RxViewModel: NSObject, Deinitializable {
    var disposeBag = DisposeBag()
    
    func deinitialize() {
        self.disposeBag = DisposeBag()
    }
    func initialize() {
        self.disposeBag = DisposeBag()
    }
}
