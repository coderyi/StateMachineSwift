//
//  SMEvent.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMEvent: NSObject, NSCoding, NSCopying {
    
    var shouldFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?
    var willFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?
    var didFireEventBlock: ((_ event: SMEvent, _ transition: SMTransition?) -> Bool)?

    public let name: String
    public let destinationState: SMState
    public let sourceStates: [SMState]

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
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.sourceStates, forKey: "sourceStates")
        aCoder.encode(self.destinationState, forKey: "destinationState")

    }

    public required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.sourceStates = aDecoder.decodeObject(forKey: "sourceStates") as! [SMState]
        self.destinationState = aDecoder.decodeObject(forKey: "destinationState") as! SMState
    }
    
    open func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = SMEvent(name, sourceStates: sourceStates, destinationState: destinationState)
        copy.shouldFireEventBlock = shouldFireEventBlock
        copy.willFireEventBlock = willFireEventBlock
        copy.didFireEventBlock = didFireEventBlock

        return copy
    }

}
