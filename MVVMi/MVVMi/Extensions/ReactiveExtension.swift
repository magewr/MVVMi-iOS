import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIButton {
    /// 버튼에 쓰로틀 추가한 버전의 탭 이벤트 핸들링
    public var throttleTap: Observable<ControlEvent<()>.Element> {
        return self.controlEvent(.touchUpInside)
            .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
    }
}
