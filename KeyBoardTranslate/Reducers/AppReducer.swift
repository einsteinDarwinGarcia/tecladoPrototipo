//
//  AppReducer.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift
// MARK:- REDUCERS
func appReducer(action: Action, state: AppState?) -> AppState {
    
    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        keyState: KeyReducer(action: action, state: state?.keyState),
        tooBarState: toolbarReducer(action: action, state: state?.tooBarState),
        googleTranslateState: GoogleTranslateReducer(action: action, state: state?.googleTranslateState)
    )
    
}
