//
//  ActivityIndicator.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping () -> ()) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }
    
    func dispose() {
        _dispose.dispose()
    }
    
    func asObservable() -> Observable<E> {
        return _source
    }
}

public class ActivityIndicator: ObservableConvertibleType {
    
 
    
    public typealias E = Bool
    
    private let _lock = NSRecursiveLock()
    private let _variable = Variable(0)
    private let _loading: Driver<Bool>
    
    public init(){
        
        _loading = _variable.asDriver().map({ $0>0
        }).distinctUntilChanged()
    }
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E>{
        
        return Observable.using({ () -> ActivityToken<O.E> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { t in
            return t.asObservable()
        }
    }
    private func increment() {
        _lock.lock()
        _variable.value = _variable.value + 1
        _lock.unlock()
    }
    
    private func decrement() {
        _lock.lock()
        _variable.value = _variable.value - 1
        _lock.unlock()
    }
    
    public func asDriver() -> Driver<E> {
        return _loading
    }
    
    public func asObservable() -> Observable<Bool> {
        return _loading.asObservable()
    }
}
public extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
        print(self)
        
        return activityIndicator.trackActivityOfObservable(self)
    }
}
