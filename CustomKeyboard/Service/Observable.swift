//
//  Observable.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/14.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)? {
        didSet {
            print("listener")
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
