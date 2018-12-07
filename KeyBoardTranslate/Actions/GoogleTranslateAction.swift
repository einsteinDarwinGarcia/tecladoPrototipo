//
//  GoogleTranslateAction.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 06/12/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//



import ReSwift

func GoogleTranslateApi(state: AppState, store: Store<AppState>) -> keyBoardAction {
    
   /* iTunesAPI.searchFor(category: state.categoriesState.currentCategorySelected.rawValue) { imageUrls in
        store.dispatch(SetCardsAction(cardImageUrls: imageUrls))
    }*/
    
     var actionKey : KeyboardState = KeyboardState()
     actionKey.typeOfKeyState = .none
    
    let translator = GoogleTranslate()
    translator.apiKey = "" // Add your API Key here
    
    var params = GoogleTranslateParams()
    params.source =  state.tooBarState.from.typeIdAndDescription.id
    params.target =  state.tooBarState.to.typeIdAndDescription.id
    params.text = String(state.keyState.textTranslate)
    
    
    translator.translate(params: params) { (result) in
        
        var action : KeyboardState = KeyboardState()
        action.typeOfKeyState = .putTextTranslate
        action.textTranslate = result
        
        store.dispatch(keyBoardAction(pressKey: action))
        
    }
 
    return keyBoardAction(pressKey: actionKey)
   // return GoogleTranslateAction()
}

struct GoogleTranslateAction: Action {
}
