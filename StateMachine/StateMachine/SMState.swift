//
//  SMState.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMState: Hashable {
    
    var willEnterStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var didEnterStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var willExitStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    var didExitStateBlock: ((_ state: SMState, _ transition: SMTransition?) -> Void)?
    
    public let name: String
    
    public var hashValue: Int {
        return name.hashValue
    }
    
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

}

extension SMState: Equatable {
    public static func == (lhs: SMState, rhs: SMState) -> Bool {
        return lhs.name == rhs.name
    }
}
