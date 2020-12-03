//
//  SMTransition.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMTransition: Hashable {
            
    public let sourceState: SMState
    public let event: SMEvent
    public let stateMachine: SMStateMachine
    public var userInfo: [AnyHashable: Any]?
    
    public var hashValue: Int {
        return self.event.name.hashValue
    }
    
    public init(_ event: SMEvent,
                sourceState: SMState,
                stateMachine: SMStateMachine,
                userInfo: [AnyHashable: Any]?) {
        self.event = event
        self.sourceState = sourceState
        self.stateMachine = stateMachine
        self.userInfo = userInfo
    }
}

extension SMTransition: Equatable {
    
    static public func == (lhs: SMTransition,
                         rhs: SMTransition) -> Bool {
        
        return lhs.event.name == rhs.event.name && lhs.sourceState == rhs.sourceState
    }
}
