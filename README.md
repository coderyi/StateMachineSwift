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
var orderStateMachine: SMStateMachine = SMStateMachine()

var normal: SMState = SMState("normal")
var purchase: SMState = SMState("purchase")
var cancel: SMState = SMState("cancel")

orderStateMachine.addStates(arrayOfStates: [normal, purchase, cancel])
orderStateMachine.initialState = normal

var confirmOrder: SMEvent = SMEvent("confirmOrder", sourceStates: [normal], destinationState: purchase)
var cancelOrder: SMEvent = SMEvent("cancelOrder", sourceStates: [purchase, normal], destinationState: cancel)

orderStateMachine.addEvents(arrayOfEvents: [confirmOrder, cancelOrder])

orderStateMachine.activate()
orderStateMachine.isInState("normal")

var userInfo = ["hello": "world"]
var success: Bool = orderStateMachine.fireEvent(eventName: "confirmOrder", userInfo: userInfo)
success = orderStateMachine.fireEvent(eventName: "cancelOrder", userInfo: userInfo)
```
## License
Released under [MIT License](LICENSE).
