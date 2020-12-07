//
//  SMState.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMState: NSObject, NSCoding, NSCopying {
    
    var willEnterStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var didEnterStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var willExitStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var didExitStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    
    public let name: String

    public init(_ name: String) {
        self.name = name
    }
    
    public func setWillEnterStateBlock(_ block: @escaping(_ state: SMState, _ transition: SMTransition?) -> Void) {
        didEnterStateBlock = block
    }
    
    public func setDidEnterStateBlock(_ block: @escaping(_ state: SMState, _ transition: SMTransition?) -> Void) {
        didEnterStateBlock = block
    }
    
    public func setWillExitStateBlock(_ block: @escaping(_ state: SMState, _ transition: SMTransition?) -> Void) {
        didEnterStateBlock = block
    }
    
    public func setDidExitStateBlock(_ block: @escaping(_ state: SMState, _ transition: SMTransition?) -> Void) {
        didEnterStateBlock = block
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
    }

    public required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
    }
    
    open func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = SMState(name)
        copy.willEnterStateBlock = willEnterStateBlock
        copy.didEnterStateBlock = didEnterStateBlock
        copy.willExitStateBlock = willExitStateBlock
        copy.didExitStateBlock = didExitStateBlock

        return copy
    }

}
