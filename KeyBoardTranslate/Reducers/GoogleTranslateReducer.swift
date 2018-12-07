//
//  GoogleTranslateReducer.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 06/12/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift

func GoogleTranslateReducer(action: Action, state: GoogleTranslateState?) -> GoogleTranslateState {
    var state = state ?? GoogleTranslateState(showLoading: false, textTranslate: "")
    
    switch(action) {
    case _ as GoogleTranslateAction:
        state = GoogleTranslateState(showLoading: true, textTranslate: "")
    case let setTranslationAction as SetTranslateAction:
        state.textTranslate = setTranslationAction.textTranslate
        state.showLoading = false
        
      /*  var actionKey : KeyboardState = KeyboardState()
        actionKey.typeOfKeyState = .putTextTranslate
        actionKey.textTranslate = String(state.textTranslate)
        
        store.dispatch(keyBoardAction(pressKey:actionKey))*/
        
    default: break
    }
    
    return state
}
