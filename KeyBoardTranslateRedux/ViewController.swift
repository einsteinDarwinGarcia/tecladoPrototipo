//
//  ViewController.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift

class ViewController: UIViewController {

    @IBOutlet weak var boton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        store.subscribe(self) {
            $0.select {
                $0.tooBarState
            }
        }
        
        //store.dispatch(RoutingAction(destination: .menu))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func elboton(_ sender: Any) {
        //store.dispatch(ToolBarAction(toolBarPressKey:.change))
    }
}

/*
extension ViewController: StoreSubscriber {
    
    func newState(state: KeyboardState) {
        //print("mis polainas")
        
        switch  state.typeOfKeyState {
        case .mayus:
            break
           
        case .num:
            break
            
        default:break
            
        }
        
    }
}*/


extension ViewController: StoreSubscriber {
    
    
    
    func newState(state: ToolBarTranslateState) {
        //print("mis polainas")
        
        switch  state.toolbarKeyPress {
        case .change:
           boton.setTitle(state.from.typeIdAndDescription.description, for: .normal)
        case .translate: break
            
        default:
             print("mis polainas \(state.from.typeIdAndDescription.description)")
             boton.setTitle(state.from.typeIdAndDescription.description, for: .normal)
        }
        
    }
}

