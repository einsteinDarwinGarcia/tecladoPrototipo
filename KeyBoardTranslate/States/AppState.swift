//
//  AppState.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//


import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    let keyState: KeyboardState
    let tooBarState: ToolBarTranslateState
    let googleTranslateState: GoogleTranslateState
}
