//
//  ToolBarTranslateState.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 29/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift


enum idiomasToolBarState {
    case english
    case spanish
    case italian
    
    var typeIdAndDescription: (id: String, description: String) {
        switch self {
        case .english:
            return ("en", "English")
        case .spanish:
            return ("es", "Spanish")
        case .italian:
            return ("it", "Italian")
        }
    }
    
    var stringRepresentation:String {
        switch self{
            case .english: return "my_case"
            case .spanish: return "my_other_case"
            case .italian: return "my_other_case"
        }
    }
   
    
}

enum ToolBarStateKey: String {
    case change = "change"
    case translate = "translate"
    case putIdioma = "putIdioma"
    case putStateButtonIdioma = "putStateButtonIdioma"
    case changeIdiomaFrom = "changeIdiomaFrom"
    case changeIdiomaTo = "changeIdiomaTo"
    case none = "initial"
}

struct ToolBarTranslateState: StateType {
    var toolbarKeyPress: ToolBarStateKey
    var buttonIdiomaSelected: ToolBarStateKey
    var idiomaSelected: idiomasToolBarState
    var from : idiomasToolBarState
    var to : idiomasToolBarState
    var textTranslate: String
    
    
    init() {
        self.toolbarKeyPress = .none
        self.from = idiomasToolBarState.english
        self.to = idiomasToolBarState.spanish
        self.buttonIdiomaSelected = .none
        self.idiomaSelected = idiomasToolBarState.english
        self.textTranslate = ""
    }
}
