//
//  ToolBarTranslateView.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 28/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import UIKit
import ReSwift

class ToolBarTranslateView: UIView {
    
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setColorScheme(.light)
        //setNextKeyboardVisible(false)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // setColorScheme(.light)
        // setNextKeyboardVisible(false)
        store.subscribe(self) {
            $0.select {
                $0.tooBarState
            }
        }
    }
}

extension ToolBarTranslateView: StoreSubscriber {
    
    @IBAction func changeIdioma(_ sender: Any) {
        
        store.dispatch(ToolBarAction(toolBarPressKey:createToolBarState(toolbarKeyPress: .change)))
    }
    
    @IBAction func selectIdiomaFrom(_ sender: Any) {
    store.dispatch(ToolBarAction(toolBarPressKey:createToolBarState(toolbarKeyPress: .putStateButtonIdioma, buttonIdiomaSelected: .changeIdiomaFrom)))
 
        
        store.dispatch(keyBoardAction(pressKey: MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .selectIdioma)))
    }
    
    @IBAction func selectIdiomaTo(_ sender: Any) {
        store.dispatch(ToolBarAction(toolBarPressKey: createToolBarState(toolbarKeyPress: .putStateButtonIdioma, buttonIdiomaSelected: .changeIdiomaTo)))
        
        store.dispatch(keyBoardAction(pressKey: MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .selectIdioma)))
    }
    
    @IBAction func buttonTranslate(_ sender: Any) {
        
        store.dispatch(keyBoardAction(pressKey: MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .getTextToTranslate)))
        
    }
    
    
    func createToolBarState(toolbarKeyPress: ToolBarStateKey, buttonIdiomaSelected: ToolBarStateKey = .none) -> ToolBarTranslateState {
        
         var action : ToolBarTranslateState = ToolBarTranslateState()
        action.toolbarKeyPress = toolbarKeyPress
        action.buttonIdiomaSelected = buttonIdiomaSelected
        
        return action
    }
    
    func newState(state: ToolBarTranslateState) {
        //print("mis polainas")
        
        switch  state.toolbarKeyPress {
        case .change:
            fromButton.setTitle(state.from.typeIdAndDescription.description, for: .normal)
            toButton.setTitle(state.to.typeIdAndDescription.description, for: .normal)
        case .translate:
            store.dispatch(GoogleTranslateApi)
            
        default:
            fromButton.setTitle(state.from.typeIdAndDescription.description, for: .normal)
            toButton.setTitle(state.to.typeIdAndDescription.description, for: .normal)
            
        }
        
    }
}
