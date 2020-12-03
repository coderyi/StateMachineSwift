//
//  SMEvent.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMEvent: Hashable {
    
    var shouldFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?
    var willFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?
    var didFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?

    public let name: String
    public let destinationState: SMState
    public let sourceStates: [SMState]
    
    public var hashValue: Int {
        return self.name.hashValue
    }

    public init(_ name: String,
                sourceStates: [SMState],
                destinationState: SMState) {
        self.sourceStates = sourceStates
        self.name = name
        self.destinationState = destinationState
    }
    
    public func setShouldFireEventBlock(_ block: @escaping(_ event: SMEvent, _ transition: SMTransition?) -> Bool) {
        shouldFireEventBlock = block
    }
    
    public func setWillFireEventBlock(_ block: @escaping(_ event: SMEvent, _ transition: SMTransition?) -> Bool) {
        willFireEventBlock = block
    }
    
    public func setDidFireEventBlock(_ block: @escaping(_ event: SMEvent, _ transition: SMTransition?) -> Bool) {
        didFireEventBlock = block
    }

}

extension SMEvent: Equatable {
    
    static public func == (lhs: SMEvent,
                         rhs: SMEvent) -> Bool {
        
        return lhs.name == rhs.name && lhs.destinationState == rhs.destinationState
    }
}
