//
//  ViewModel.swift
//  RxLoginTest
//
//  Created by JINHONG AN on 2022/01/18.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel {
    struct Input {
        let id = PublishRelay<String>()
        let password = PublishRelay<String>()
        let buttonTap = PublishRelay<Void>()
    }
    
    struct Output {
        let buttonEnabled = BehaviorRelay<Bool>(value: false)
    }
    
    private var input = Input()
    private let output = Output()
    private let disposeBag = DisposeBag()
    
    func bind(input: Input) {
        self.input = input
        
        Observable.combineLatest(input.id, input.password)
            .map { (id: String, password: String) in
                !(id.isEmpty || password.isEmpty)
            }
            .bind(to: output.buttonEnabled)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() -> Output {
        return output
    }
}
