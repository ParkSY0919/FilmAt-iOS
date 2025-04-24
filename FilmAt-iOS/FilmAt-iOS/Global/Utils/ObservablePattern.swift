//
//  ObservablePattern.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

final class ObservablePattern<T: Equatable> {
    
    var value: T? {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
    
    func lazyBind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
    }
    
}

final class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /// Bind the closure with value. The closure was called when the value did set and this method was called.
    func bind(_ closure: @escaping ((T) -> Void)) {
        closure(value)
        self.closure = closure
    }
    
    /// Bind the closure with value. The closure calls lazily, so that the closure was called when the value did set only.
    func lazyBind(_ closure: @escaping ((T) -> Void)) {
        self.closure = closure
    }
    
    /// Sets the value to the received value.
    func send(_ value: T) {
        self.value = value
    }
    
    func send() where T == Void {
        self.value = ()
    }
    
}
