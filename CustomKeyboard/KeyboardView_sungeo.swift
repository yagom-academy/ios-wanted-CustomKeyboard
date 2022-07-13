//
//  KeyboardView_sungeo.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/12.
//

import UIKit

class KeyboardView_sungeo: UIView {
    @IBOutlet var changeButtons: [UIButton]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        customInit()
        changeButtonsSetTitleSelected()
    }
    
    @IBAction func touchKeyButtons(_ sender: UIButton) {
        var title = ""
        
        if sender.isSelected {
            title = sender.title(for: .selected) ?? ""
            changeButtonsIsSelectedToggle()
        } else {
            title = sender.currentTitle ?? ""
        }
        
        print(title)
    }
    
    @IBAction func touchShiftButton(_ sender: UIButton) {
        changeButtonsIsSelectedToggle()
    }
    
}

// MARK: - Private

extension KeyboardView_sungeo {
    private func customInit() {
        guard let view = Bundle.main.loadNibNamed("Keyboard_sungeo", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)
    }
    
    private func changeButtonsSetTitleSelected() {
        let words = ["ㄲ", "ㄸ", "ㅃ", "ㅆ", "ㅉ", "ㅒ", "ㅖ"]
        changeButtons
            .sorted { $0.currentTitle ?? "" < $1.currentTitle ?? "" }
            .enumerated()
            .forEach { (index, button) in
                button.setTitle(words[index], for: .selected)
            }
    }
    
    private func changeButtonsIsSelectedToggle() {
        changeButtons.forEach { $0.isSelected.toggle() }
    }
}
