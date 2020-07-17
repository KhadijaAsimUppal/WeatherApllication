//
//  Bindable.swift
//  LiveFreeFit
//
//  Created by Arslan Faisal on 29/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Provides and Bindable object for any generic type *<T>*
/// Every Bindable object has two properties, *value*  keeps the value for generic type *<T>* where as *listener* is a closure with *value* as its parameter and if listener is set it is called whenever *value* property for Bindable is set.
class Bindable<T>{
    typealias Listener = (T)->()
    
    var listener: [Listener?]? = [Listener?]()
    var value: T {
        didSet {
            fireListeners()
        }
    }
    
    /// initialises the Bindable object with value
    /// - Parameter val: value to be set for *value* property  of *Bindable* object
    init(_ val: T) {
        value = val
    }
    
    /// binds the passed listener to the class  listener property
    /// - Parameter listener: closure  of the type (T)->()
    func bind(_ listener: Listener?){
        self.listener?.append(listener)
    }
    
    /// Disposes listner
    func dispose() {
        listener = nil
    }
    
    /// binds the passed listener to the class  listener property and triggers it instantaneously
    /// - Parameter listener: closure  of the type (T)->()
    func bindAndTrigger(_ listener: Listener?){
        self.listener?.append(listener)
        fireListeners()
    }
    
    private func fireListeners() {
        guard let allListener = listener else { return }
        for listen in allListener {
            listen?(value)
        }
    }
}
