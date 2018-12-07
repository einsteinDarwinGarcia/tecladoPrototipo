//
//  RoutingReducer.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    
    switch action {
    case let routingAction as RoutingAction:
        
        state.navigationState = routingAction.destination
        
       /* switch routingAction.destination {
            case .mayus:
                state.mayus = !state.mayus
            
            default: break
        }*/
        
       
    default: break
    }
    
    return state
    
}
