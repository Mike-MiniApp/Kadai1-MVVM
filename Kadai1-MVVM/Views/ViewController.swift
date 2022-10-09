//
//  ViewController.swift
//  Kadai1-MVVM
//
//  Created by 近藤米功 on 2022/09/23.
//
// issue
// Bindで書きたい

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var number1TextField: UITextField!
    @IBOutlet private weak var number2TextField: UITextField!
    @IBOutlet private weak var number3TextField: UITextField!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var numberLabel: UILabel!

    // MARK: - ViewModel Connect
    private lazy var viewModel = ViewModel(number1TextFieldObservable: number1TextField.rx.text.map{ $0 ?? ""}.asObservable(),
        number2TextFieldObservable: number2TextField.rx.text.map{ $0 ?? ""}.asObservable(),
        number3TextFieldObservable: number3TextField.rx.text.map{ $0 ?? ""}.asObservable(),
        calculateButtonObservable: calculateButton.rx.tap.asObservable())

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.outputs.resultNumberPublishSubject.bind(to: numberLabel.rx.text).disposed(by: disposeBag)
    }
}

