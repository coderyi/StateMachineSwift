//
//  SMTransition.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit
open class SMTransition: NSObject {
            
    public let sourceState: SMState
    public let event: SMEvent
    public let stateMachine: SMStateMachine
    public var userInfo: [AnyHashable: Any]?
    
    public init(_ event: SMEvent,
                sourceState: SMState,
                stateMachine: SMStateMachine,
                userInfo: [AnyHashable: Any]?) {
        self.event = event
        self.sourceState = sourceState
        self.stateMachine = stateMachine
        self.userInfo = userInfo
    }
    
    public func destinationState() -> SMState {
        return event.destinationState
    }
}
