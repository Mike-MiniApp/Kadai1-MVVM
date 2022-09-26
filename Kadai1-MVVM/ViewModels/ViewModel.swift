//
//  ViewModel.swift
//  Kadai1-MVVM
//
//  Created by 近藤米功 on 2022/09/23.
//

import Foundation
import RxSwift

protocol ViewModelInputs {
    var number1TextFieldObservable: Observable<String> { get }
    var number2TextFieldObservable: Observable<String> { get }
    var number3TextFieldObservable: Observable<String> { get }
    var calculateButtonObservable: Observable<Void> { get }
}

protocol ViewModelOutputs {
    var resultNumberPublishSubject: PublishSubject<Int> { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    // MARK: Inputs
    var number1TextFieldObservable: Observable<String>
    var number2TextFieldObservable: Observable<String>
    var number3TextFieldObservable: Observable<String>
    var calculateButtonObservable: Observable<Void>

    // MARK: Outputs
    var resultNumberPublishSubject = PublishSubject<Int>()

    // MARK: Model Connect
    let calculator = Calculator()

    private let disposeBag = DisposeBag()
    private var number1 = 0
    private var number2 = 0
    private var number3 = 0

    init(number1TextFieldObservable: Observable<String>,
         number2TextFieldObservable: Observable<String>,
         number3TextFieldObservable: Observable<String>,
         calculateButtonObservable: Observable<Void>){
        self.number1TextFieldObservable = number1TextFieldObservable
        self.number2TextFieldObservable = number2TextFieldObservable
        self.number3TextFieldObservable = number3TextFieldObservable
        self.calculateButtonObservable = calculateButtonObservable
    }

    func setupBindings() {

        let sumInput = Observable.combineLatest(number1TextFieldObservable, number2TextFieldObservable, number3TextFieldObservable)

        sumInput.subscribe { number1,number2,number3 in
            self.number1 = Int(number1) ?? 0
            self.number2 = Int(number2) ?? 0
            self.number3 = Int(number3) ?? 0
        }.disposed(by: disposeBag)
        
        calculateButtonObservable.subscribe(onNext: {
            [weak self] in
            self?.calculator.addition(number1: self?.number1 ?? 0,
                                      number2: self?.number2 ?? 0,
                                      number3: self?.number3 ?? 0)
            self?.resultNumberPublishSubject.onNext(self?.calculator.sum ?? 0)
        })
        .disposed(by: disposeBag)
    }

}
