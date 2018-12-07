//
//  MainKeyBoardView.swift
//  KeyBoardTranslate
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import UIKit
import ReSwift

class MainKeyBoardView: UIStackView  {
    
    var capButton: KeyboardButton!
    var numericButton: KeyboardButton!
    var deleteButton: KeyboardButton!
    var nextKeyboardButton: KeyboardButton!
    var rupeSoButton: KeyboardButton!
    var returnButton: KeyboardButton!
    
    var allTextButtons = [KeyboardButton]()
    
    lazy var actionsTranslateView: ToolBarTranslateView = {
        let nibKey = UINib(nibName: "ToolBarTranslateView", bundle: nil)
        let objectsKey = nibKey.instantiate(withOwner: nil, options: nil)
        var view = objectsKey.first as! ToolBarTranslateView
        //view.idiomaTo = idiomaTo
        //view.idiomaFrom = idiomaFrom
        
        return view
    }()
    
    lazy var selectionIdiomaView: SelectIdiomaView = {
        let nibKey = UINib(nibName: "SelectIdiomaView", bundle: nil)
        let objectsKey = nibKey.instantiate(withOwner: nil, options: nil)
        var view = objectsKey.first as! SelectIdiomaView
        return view
    }()
    
    func createMainKeyBoard() -> UIStackView{
        
        store.subscribe(self) {
            $0.select {
                $0.keyState
            }
        }
  
        let ceroRowView = addSubviewActionsTranslate()
        let firstRowView = addRowsOnKeyboard(kbKeys: ["q","w","e","r","t","y","u","i","o","p"])
        let secondRowView = addRowsOnKeyboard(kbKeys: ["a","s","d","f","g","h","j","k","l","ñ"])
        
        let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["z","x","c","v","b","n","m"])
        
        let (thirdRowSV,fourthRowSV) = serveiceKeys(midRow: thirdRowkeysView)
        
        // Add Row Views on Keyboard View... With a Single Stack View..
        
        let mainKeyboard = UIStackView(arrangedSubviews: [ceroRowView,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        
        return mainKeyboard
    }
    
    func displayNumericKeys()-> UIStackView {
        
        let ceroRowView = addSubviewActionsTranslate()
        let nums = ["1","2","3","4","5","6","7","8","9","0"]
        let splChars1 = ["-","/",":",";","(",")","\u{20B9}","&","@","*"]
        let splChars2 = [".",",","?","!","#"]
        
        let numsRow = self.addRowsOnKeyboard(kbKeys: nums)
        let splChars1Row = self.addRowsOnKeyboard(kbKeys: splChars1)
        let splChars2Row = self.addRowsOnKeyboard(kbKeys: splChars2)
        
        let (thirdRowSV,fourthRowSV) = serveiceKeys(midRow: splChars2Row)
        
        let mainKeyboard = UIStackView(arrangedSubviews: [ceroRowView,numsRow,splChars1Row,thirdRowSV,fourthRowSV])
        
        return mainKeyboard
        
    }
    
    func displaySelectIdioma() -> UIStackView {
        let mainKeyboard = UIStackView(arrangedSubviews: [addSelectIdioma()])
        return mainKeyboard
    }
    
    
    func addRowsOnKeyboard(kbKeys: [String]) -> UIView {
        
        let RowStackView = UIStackView.init()
        RowStackView.spacing = 5
        RowStackView.axis = .horizontal
        RowStackView.alignment = .fill
        RowStackView.distribution = .fillEqually
        
        for key in kbKeys {
            RowStackView.addArrangedSubview(createButtonWithTitle(title: key))
        }
        
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        return keysView
    }
    
    func addSubviewActionsTranslate() -> UIView {
        
        let RowStackView = actionsTranslateView
        
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        return keysView
        
    }
    
    func addSelectIdioma() -> UIView {
        
        let RowStackView = selectionIdiomaView
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        return keysView
        
    }
    
    func createButtonWithTitle(title: String) -> KeyboardButton {
        
        let button = KeyboardButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        // button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        allTextButtons.append(button)
        
        return button
    }
    
    func serveiceKeys(midRow: UIView)->(UIStackView, UIStackView) {
        self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial1"), tag: 1)
        self.deleteButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "Backspace"), tag: 2)
        
        let thirdRowSV = UIStackView(arrangedSubviews: [self.capButton,midRow,self.deleteButton])
        thirdRowSV.distribution = .fillProportionally
        thirdRowSV.spacing = 5
        
        self.numericButton = accessoryButtons(title: "123", img: nil, tag: 3)
        self.nextKeyboardButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "globe"), tag: 4)
        let spaceKey = accessoryButtons(title: "space", img: nil, tag: 6)
        self.returnButton = accessoryButtons(title: "return", img: nil, tag: 7)
        
        let fourthRowSV = UIStackView(arrangedSubviews: [self.numericButton,self.nextKeyboardButton,spaceKey,self.returnButton])
        fourthRowSV.distribution = .fillProportionally
        fourthRowSV.spacing = 5
        
        return (thirdRowSV,fourthRowSV)
    }
    
    func accessoryButtons(title: String?, img: UIImage?, tag: Int) -> KeyboardButton {
        
        let button = KeyboardButton.init(type: .system)
        
        if let buttonTitle = title {
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        if let buttonImage = img {
            button.setImage(buttonImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        
        //For Capitals...
        if button.tag == 1 {
            button.addTarget(self, action: #selector(handleCapitalsAndLowerCase(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            return button
        }
        //For BackDelete Key // Install Once Only..
        if button.tag == 2 {
           // let longPrssRcngr = UILongPressGestureRecognizer.init(target: self, action: #selector(onLongPressOfBackSpaceKey(longGestr:)))
            
            //if !(button.gestureRecognizers?.contains(longPrssRcngr))! {
           // longPrssRcngr.minimumPressDuration = 0.5
           // longPrssRcngr.numberOfTouchesRequired = 1
           // longPrssRcngr.allowableMovement = 0.1
           // button.addGestureRecognizer(longPrssRcngr)
            //}
            
            button.addTarget(self, action: #selector(handleReturnKey(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        }
        //Switch to and From Letters & Numeric Keys
        if button.tag == 3 {
            button.addTarget(self, action: #selector(handleSwitchingNumericsAndLetters(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return button
        }
        //Next Keyboard Button... Globe Button Usually...
        if button.tag == 4 {
            
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return button
        }
        //Handle Rupee Button// For Showing Payment Container...
        if button.tag == 5 {
            
            //  button.addTarget(self, action: #selector(HandlePaymentContainer), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            return button
        }
        //White Space Button...
        if button.tag == 6 {
            
            button.addTarget(self, action: #selector(insertWhiteSpace), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            return button
        }
        //Handle return Button...//Usually depends on Texyfiled'd return Type...
        if button.tag == 7 {
            button.addTarget(self, action: #selector(handleIntroKey(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 70).isActive = true
            return button
        }
        //Else Case... For Others
        // button.addTarget(self, action: #selector(manualAction(sender:)), for: .touchUpInside)
        return button
        
    }
    
    @objc func didTapButton(sender: UIButton) {
        
        let button = sender as UIButton
        guard let title = button.titleLabel?.text else { return }
        
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .writeKey, withValueKey: title)))
        
    }
    
    @objc func handleIntroKey(sender: UIButton) {
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .writeKey, withValueKey: "\n")))
    }
    
    @objc func handleReturnKey(sender: UIButton) {
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .deleteKey)))
    }
    
    @objc func insertWhiteSpace(sender: UIButton) {
        
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .writeKey, withValueKey: " ")))
    }
    
    @objc func handleCapitalsAndLowerCase(sender: UIButton) {
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .mayus)))
    }
  
    @objc func handleSwitchingNumericsAndLetters(sender: UIButton) {
        store.dispatch(keyBoardAction(pressKey:MainKeyBoardView.createActionKeyBoardState(typeOfKeyState: .num)))
    }
    
    func changeMayusKey(state:Bool){
        for button in allTextButtons {
            if let title = button.currentTitle {
                button.setTitle(state ? title.lowercased() : title.uppercased(), for: .normal)
            }
        }
        
    }
    
   static func createActionKeyBoardState(typeOfKeyState:typeOfKey, withValueKey: String = "") -> KeyboardState {
        
        var actionKey : KeyboardState = KeyboardState()
         actionKey.typeOfKeyState = typeOfKeyState
         actionKey.valKey = withValueKey
        
        return actionKey
    }
    
}

extension MainKeyBoardView: StoreSubscriber {
    
    func newState(state: KeyboardState) {
        //print("mis polainas")
        
        switch  state.typeOfKeyState {
        case .mayus:
            changeMayusKey(state: state.mayus)
        case .num: break
            
        default:break
            
        }
 
    }
}
