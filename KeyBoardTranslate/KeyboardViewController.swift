
//
//  KeyboardViewController.swift
//  KeyBoardTranslate
//
//  Created by EinsteinDarwin on 27/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import UIKit
import ReSwift

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var mainStackView: UIStackView!
    var keyboardHeight: CGFloat = 250
    var KeyboardVCHeightConstraint: NSLayoutConstraint!
    var containerViewHeight: CGFloat = 0
    var translateViewController: UIViewController!
    
    lazy var mainKeyBoard: MainKeyBoardView = {
        let view = MainKeyBoardView()
        //view.delegate = self
       
        return view
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.subscribe(self) {
            $0.select {
                $0.keyState
            }
        }
        
        
        // Perform custom UI setup here
        self.KeyboardVCHeightConstraint = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: keyboardHeight+containerViewHeight)
        self.view.addConstraint(self.KeyboardVCHeightConstraint)
        
        self.loadMainVC()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.removeConstraint(KeyboardVCHeightConstraint)
        self.view.addConstraint(self.KeyboardVCHeightConstraint)
    }
    
    func loadMainVC(){
        
        let createMainKeyBoard = mainKeyBoard
        self.mainStackView = createMainKeyBoard.createMainKeyBoard()
        createMainKeyBoard.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        setStyleStackView()
        
    }
    
    func loadNumericKeys(){
        let createMainKeyBoard = mainKeyBoard
        self.mainStackView = createMainKeyBoard.displayNumericKeys()
        setStyleStackView()
        
    }
    
    func loadSelectIdioma(){
        let createMainKeyBoard = mainKeyBoard
        self.mainStackView = createMainKeyBoard.displaySelectIdioma()
        setStyleStackView()
    }
    
    func setStyleStackView(){
        mainStackView.axis = .vertical
        mainStackView.spacing = 4.0
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: keyboardHeight).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
      /*  var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])*/
    }
    
    func putNewKeyBoard(){
        
       
            for view in mainStackView.arrangedSubviews {
                view.removeFromSuperview()
            }
        
    }

}



extension KeyboardViewController: StoreSubscriber {
 
    
    func newState(state: KeyboardState) {
        
        switch  state.typeOfKeyState {
            case .num:
                putNewKeyBoard()
                state.num ? self.loadNumericKeys() : self.loadMainVC()
            case .selectIdioma:
                putNewKeyBoard()
                self.loadSelectIdioma()
            case .putNewIdioma:
                putNewKeyBoard()
                self.loadMainVC()
            case .writeKey:
                insertCharacter(state.valKey)
            case .deleteKey:
                textDocumentProxy.deleteBackward()
            case .getTextToTranslate:
                setTextToTranslate()
            case .setTextToTranslate:
                sendTextToTranslate()
            case .putTextTranslate:
                insertTraducion(text: state.textTranslate)
            default:
                break
        }
        
    }
    
    func insertCharacter(_ newCharacter: String) {
        self.inputView?.playInputClick​()
        textDocumentProxy.insertText(newCharacter)
    }
    
    func sendTextToTranslate(){
        store.dispatch(GoogleTranslateApi)
    }
    
    func setTextToTranslate(){
        guard let character = textDocumentProxy.documentContextBeforeInput else {
            return
        }
        
        var action : KeyboardState = KeyboardState()
        action.typeOfKeyState = .setTextToTranslate
        action.textTranslate = character
        
        store.dispatch(keyBoardAction(pressKey: action))
    }
    
    func deleteAllTextInput(){
        
        let length = textDocumentProxy.documentContextBeforeInput
        for _ in length! {
           textDocumentProxy.deleteBackward()
        }
    }
    
    func insertTraducion(text:String) {
        deleteAllTextInput()
        textDocumentProxy.insertText(text)
    }
    
}
