//
//  DemoViewController.swift
//  StateMachine
//
//  Created by coderyi on 2020/11/29.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        let orderStateMachine: SMStateMachine = SMStateMachine()

        let normal: SMState = SMState("normal")
        normal.setDidEnterStateBlock { (state, transition) in
            print("normal DidEnterStateBlock \(transition?.userInfo)")
        }
        
        let purchase: SMState = SMState("purchase")
        purchase.setDidEnterStateBlock { (state, transition) in
            print("purchase DidEnterStateBlock \(transition?.userInfo)")
        }
        
        let cancel: SMState = SMState("cancel")
        cancel.setDidEnterStateBlock { (state, transition) in
            print("cancel didEnterStateBlock \(transition?.userInfo)")
        }

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
        print(orderStateMachine.canFireEvent(eventName: "cancelOrder"))

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
