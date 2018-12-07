//
//  SelectIdiomaView.swift
//  KeyBoardTranslateRedux
//
//  Created by EinsteinDarwin on 30/11/2018.
//  Copyright © 2018 EinsteinDarwin. All rights reserved.
//

import UIKit

class SelectIdiomaView: UIView,  UIPickerViewDataSource, UIPickerViewDelegate  {

    
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [idiomasToolBarState] = [idiomasToolBarState]()
    var indexPickerView:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setColorScheme(.light)
        //setNextKeyboardVisible(false)
        // Connect data:
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // translateText.text = text
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // setColorScheme(.light)
        // setNextKeyboardVisible(false)
         self.picker.delegate = self
         self.picker.dataSource = self
         pickerData = [.english,.italian,.spanish]
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let idioma = pickerData[row]
        
        return idioma.typeIdAndDescription.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexPickerView = row
        
        //store.dispatch(ToolBarAction(pu:.change))
    }
    
}

// MARK: - Actions
extension SelectIdiomaView {
    
    
    @IBAction func doneButton(_ sender: Any) {
        
        var action : ToolBarTranslateState = ToolBarTranslateState()
        action.toolbarKeyPress = .putIdioma
        action.idiomaSelected = pickerData[indexPickerView]
        
        store.dispatch(ToolBarAction(toolBarPressKey:action))
        
        var actionKey : KeyboardState = KeyboardState()
        actionKey.typeOfKeyState = .putNewIdioma
        
        store.dispatch(keyBoardAction(pressKey:actionKey))
        
    }
    
}
