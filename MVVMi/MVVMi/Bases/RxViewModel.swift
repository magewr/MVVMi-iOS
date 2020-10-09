//
//  RxViewModel.swift
//  WeddingBell
//
//  Created by jinwoo.park on 2020/04/22.
//  Copyright © 2020 How To Marry. All rights reserved.
//

import Foundation
import RxSwift

protocol RxViewModelProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    var input: Input! { get }
    var output: Output! { get }
    func deinitialize()
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
