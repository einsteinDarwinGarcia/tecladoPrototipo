//
//  KeyboardState.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 28/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift

enum typeOfKey: String {
    case mayus = "mayus"
    case num = "num"
    case writeKey = "writeKey"
    case deleteKey = "deleteKey"
    case selectIdioma = "selectIdioma"
    case putNewIdioma = "putNewIdioma"
    case getTextToTranslate = "getTextToTranslate"
    case setTextToTranslate = "setTextToTranslate"
    case putTextTranslate = "putTextTranslate"
    case none = "none"
}

struct KeyboardState: StateType {
    var typeOfKeyState: typeOfKey
    var mayus : Bool
    var num : Bool
    var valKey : String
    var textTranslate: String
    init() {
        self.typeOfKeyState = .writeKey
        self.mayus = true
        self.num = false
        self.valKey = ""
        self.textTranslate = ""
    }
}
