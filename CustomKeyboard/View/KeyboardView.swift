//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/12.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func keyboardViewTouch(text: String)
    func keyboardViewReturn()
}

class KeyboardView: UIView {
    enum KeyboardConstants {
        static let NibName = "KeyboardView"
    }
    
    @IBOutlet var changeButtons: [UIButton]!
    @IBOutlet var allButtons: [UIButton]!
    
    weak var delegate: KeyboardViewDelegate?
    let IOManager = HangeulIOManger()
    
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
        
        IOManager.process(input: title)
        delegate?.keyboardViewTouch(text: IOManager.getOutput())
    }
    
    @IBAction func touchShiftButton(_ sender: UIButton) {
        changeButtonsIsSelectedToggle()
    }
    
    @IBAction func touchReturnButton(_ sender: UIButton) {
        delegate?.keyboardViewReturn()
    }
}

// MARK: - Private

extension KeyboardView {
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
