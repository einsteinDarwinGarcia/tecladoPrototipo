//
//  RoutingState.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//


import ReSwift

enum RoutingDestination: String {
    case numericKeyBoard = "loadNumericKeys"
    case alphaKeyBoard = "loadMainVC"
    case selectIdiomaBoard = "selectIdiomaBoard"
}

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    //var mayus : Bool
    init( mayus: Bool = false) {
        self.navigationState = .alphaKeyBoard
        //self.mayus = mayus
    }
}
