StateMachineSwift, supports an arbitrary number of States and Events.

### CocoaPods

```
pod 'StateMachineSwift'
```

### Features

* Supports an arbitrary number of States and Events.
* States and Events support a thorough set of callbacks for responding to state transitions.
* Transitions support the inclusion of arbitrary user data via a userInfo dictionary, making it easy to broadcast metadata across callbacks.
* Lightweight.

### Example

```
let orderStateMachine: SMStateMachine = SMStateMachine()

let normal: SMState = SMState("normal")
let purchase: SMState = SMState("purchase")
let cancel: SMState = SMState("cancel")

orderStateMachine.addStates(arrayOfStates: [normal, purchase, cancel])
orderStateMachine.initialState = normal

let confirmOrder: SMEvent = SMEvent("confirmOrder", sourceStates: [normal], destinationState: purchase)
let cancelOrder: SMEvent = SMEvent("cancelOrder", sourceStates: [purchase, normal], destinationState: cancel)

orderStateMachine.addEvents(arrayOfEvents: [confirmOrder, cancelOrder])

orderStateMachine.activate()
orderStateMachine.isInState("normal")

let userInfo = ["hello": "world"]
orderStateMachine.fireEvent(eventName: "confirmOrder", userInfo: userInfo)
orderStateMachine.fireEvent(eventName: "cancelOrder", userInfo: userInfo)
```
## License
Released under [MIT License](LICENSE).
