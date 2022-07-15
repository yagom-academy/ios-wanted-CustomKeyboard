//
//  KeyboardView_sungeo.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/12.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func keyboardViewTouch()
    func keyboardViewReturn()
}

class KeyboardView_sungeo: UIView {
    enum KeyboardConstants {
        static let NibName = "Keyboard_sungeo"
    }
    
    @IBOutlet var changeButtons: [UIButton]!
    @IBOutlet var allButtons: [UIButton]!
    
    weak var delegate: KeyboardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    @IBAction func touchKeyButtons(_ sender: UIButton) {
        var title = ""
        
        if sender.isSelected {
            title = sender.title(for: .selected) ?? ""
            changeButtonsIsSelectedToggle()
        } else {
            title = sender.currentTitle ?? ""
        }
        
        IOManager.shared.process(input: title)
        delegate?.keyboardViewTouch()
    }
    
    @IBAction func touchShiftButton(_ sender: UIButton) {
        changeButtonsIsSelectedToggle()
    }
    
    @IBAction func touchReturnButton(_ sender: UIButton) {
        delegate?.keyboardViewReturn()
    }
}

// MARK: - Private

extension KeyboardView_sungeo {
    private func configure() {
        customInit()
        changeAllButtonsCircle()
        changeButtonsSetTitleSelected()
    }
    
    private func customInit() {
        guard let view = Bundle.main.loadNibNamed(KeyboardConstants.NibName, owner: self, options: nil)?.first as? UIView else {
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
                button.setTitleColor(.black, for: .selected)
            }
    }
    
    private func changeAllButtonsCircle() {
        allButtons.forEach {
            $0.layer.cornerRadius = 5
        }
    }
    
    private func changeButtonsIsSelectedToggle() {
        changeButtons.forEach { $0.isSelected.toggle() }
    }
}
