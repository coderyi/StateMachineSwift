//
//  SMStateMachine.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit

open class SMStateMachine {
    
    public let SMStateMachineDidChangeStateNotification: String = "SMStateMachineDidChangeStateNotification"
    public let SMStateMachineDidChangeStateOldStateUserInfoKey: String = "old"
    public let SMStateMachineDidChangeStateNewStateUserInfoKey: String = "new"
    public let SMStateMachineDidChangeStateEventUserInfoKey: String = "event"
    public let SMStateMachineDidChangeStateTransitionUserInfoKey: String = "transition"

    private lazy var states: [SMState] = [SMState]()
    public var initialState: SMState?
    private var currentState: SMState?
    private lazy var events: [SMEvent] = [SMEvent]()
    private var active: Bool?
    private let lock = NSRecursiveLock()
    
    public init() {
    }
    
    public func addState(state: SMState) {
        if active == true {
            return
        }
        if state == nil || stateNamed(state.name) != nil {
            return
        }
        if (initialState == nil) {
            initialState = state
        }
        states.append(state)
    }
    
    public func addStates(arrayOfStates: [SMState]) {
        for state in arrayOfStates {
            addState(state: state)
        }
    }
    
    public func stateNamed(_ stateName: String) -> SMState? {
        for state in states {
            if state.name == stateName {
                return state
            }
        }
        return nil
    }

    public func isInState(_ stateName: String) -> Bool {
        var state: SMState? = stateNamed(stateName)
        if state != nil {
            return currentState == state
        }
        return false
    }

    private func addEvent(event: SMEvent) {
        if active == true {
            return
        }
        if event == nil {
            return
        }
        if event.sourceStates.count > 0 {
            for state in event.sourceStates {
                if states.contains(state) == false {
                    return
                }

            }
        }
        if states.contains(event.destinationState) == false {
            return
        }
        events.append(event)
    }
    
    public func addEvents(arrayOfEvents: [SMEvent]) {
        for event in arrayOfEvents {
            addEvent(event: event)
        }
    }

    public func eventNamed(_ eventName: String) -> SMEvent? {
        for event in events {
            if event.name == eventName {
                return event
            }
        }
        return nil
    }
    
    public func activate() {
        if active == true {
            return
        }
        guard let initialState = initialState else {
            return
        }
        lock.lock()
        defer { lock.unlock() }
        active = true
        if let willEnterStateBlock = initialState.willEnterStateBlock {
            willEnterStateBlock(initialState, nil)
        }
        currentState = initialState
        if let didEnterStateBlock = initialState.didEnterStateBlock {
            didEnterStateBlock(initialState, nil)
        }
    }

    public func canFireEvent(eventName: String) -> Bool {
        guard let currentState = currentState else {
            return false
        }
        var event: SMEvent? = eventNamed(eventName)
        if event != nil {
            var isContain: Bool? = event?.sourceStates.contains(currentState)
            return isContain ?? false
        }
        return false
    }

    public func fireEvent(eventName: String,
                     userInfo: [AnyHashable: Any]?) -> Bool{
        lock.lock()
        defer { lock.unlock() }
        guard let event: SMEvent = eventNamed(eventName) else {
            return false
        }
        guard var currentState = currentState else {
            return false
        }

        if active == false {
            activate()
        }
        if canFireEvent(eventName: eventName) == false {
            return false
        }
        var transition: SMTransition = SMTransition(event, sourceState: currentState, stateMachine: self, userInfo: userInfo)
        if let shouldFireEventBlock = event.shouldFireEventBlock {
            if shouldFireEventBlock(event, transition) == false {
                return false
            }
        }

        var oldState: SMState = currentState
        var newState: SMState = event.destinationState
        if let willFireEventBlock = event.willFireEventBlock {
            willFireEventBlock(event, transition)
        }
        if let willExitStateBlock = oldState.willExitStateBlock {
            willExitStateBlock(oldState, transition)
        }
        if let willEnterStateBlock = newState.willEnterStateBlock {
            willEnterStateBlock(newState, transition)
        }

        currentState = newState
        
        var notificationInfo = userInfo ?? [AnyHashable: Any]();
        notificationInfo[SMStateMachineDidChangeStateOldStateUserInfoKey] = oldState
        notificationInfo[SMStateMachineDidChangeStateNewStateUserInfoKey] = newState
        notificationInfo[SMStateMachineDidChangeStateEventUserInfoKey] = event
        notificationInfo[SMStateMachineDidChangeStateTransitionUserInfoKey] = transition
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SMStateMachineDidChangeStateNotification), object: self, userInfo: notificationInfo)
        if let didExitStateBlock = oldState.didExitStateBlock {
            didExitStateBlock(oldState, transition)
        }

        if let didEnterStateBlock = newState.didEnterStateBlock {
            didEnterStateBlock(newState, transition)
        }
        if let didFireEventBlock = event.didFireEventBlock {
            didFireEventBlock(event, transition)
        }

        return true
    }

}
