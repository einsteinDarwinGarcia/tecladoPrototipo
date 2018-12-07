//
//  ToolbarReducer.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 29/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift

func toolbarReducer(action: Action, state: ToolBarTranslateState?) -> ToolBarTranslateState {
    var state = state ?? ToolBarTranslateState()
    
    switch action {
        
    case let keyAction as ToolBarAction:
        
        state.toolbarKeyPress = keyAction.toolBarPressKey.toolbarKeyPress
        
        
        switch keyAction.toolBarPressKey.toolbarKeyPress {
        case .change:
            
            let valTo = state.to
            let valFrom = state.from
            
            state.from = valTo
            state.to = valFrom
           
        case .translate:
            
            state.textTranslate = keyAction.toolBarPressKey.textTranslate
            
           // apiTranslate(to: state.to.typeIdAndDescription.id, from: state.from.typeIdAndDescription.id, text: state.textTranslate)
        case .putIdioma:
            switch state.buttonIdiomaSelected {
                case .changeIdiomaFrom:
                    state.from = keyAction.toolBarPressKey.idiomaSelected
                case .changeIdiomaTo:
                    state.to = keyAction.toolBarPressKey.idiomaSelected
                default: break
            }
        case .putStateButtonIdioma:
            state.buttonIdiomaSelected = keyAction.toolBarPressKey.buttonIdiomaSelected
            
            
        default: break
        }
        
        
        default: break
    }
    
    
    return state
}

func apiTranslate(to:String, from:String, text:String){
    let translator = GoogleTranslate()
    translator.apiKey = "" // Add your API Key here
    
    var params = GoogleTranslateParams()
    params.source =  to
    params.target =  from
    params.text = String(text)
    
    translator.translate(params: params) { (result) in
        
        //self.screenAfterTraduction(text: String(character))
        //self.textDocumentProxy.insertText(("mis polainas \(String(character))"))
        
        var actionKey : KeyboardState = KeyboardState()
        actionKey.typeOfKeyState = .putTextTranslate
        actionKey.textTranslate = String(result)
        
        //store.dispatch(keyBoardAction(pressKey:actionKey))
        
    }
    
}


