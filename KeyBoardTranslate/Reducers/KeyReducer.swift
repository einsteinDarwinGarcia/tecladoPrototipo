//
//  KeyReducer.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 28/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift


func KeyReducer(action: Action, state: KeyboardState?) -> KeyboardState {
    var state = state ?? KeyboardState()
    
    switch action {
    case let keyAction as keyBoardAction:
        
        state.typeOfKeyState = keyAction.pressKey.typeOfKeyState
        
        switch keyAction.pressKey.typeOfKeyState {
            case .mayus:
                state.mayus = !state.mayus
            case .num:
                state.num = !state.num
            case .writeKey:
                state.valKey = keyAction.pressKey.valKey
            case .putTextTranslate:
                state.textTranslate = keyAction.pressKey.textTranslate
            case .setTextToTranslate:
                 state.textTranslate = keyAction.pressKey.textTranslate
                 state.typeOfKeyState = .setTextToTranslate
           
            default: break
        }
        
        
    default: break
    }
    
    return state
    
}


