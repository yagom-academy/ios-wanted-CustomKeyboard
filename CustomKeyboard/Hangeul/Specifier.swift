//
//  Specifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

class Specifier {
    
    static let shared = Specifier()
    private init() { }
    
    func specify(prev: Hangeul, new: Hangeul)  {
        
        let status = prev.getCombinationStatus()
        
        switch status {
        case .start:
            if new.isVowel() {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midOnly)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.midOnly)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .top:
            if new.isVowel() {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midWithTop)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.midWithTop)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case . midOnly:
            if new.isVowel() {
                if canBeDouble(prev: prev, new: new) {
                    let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .doubleMidOnly)
                    new.setUnicode(newUnicode)
                    new.setCombinationStatus(.doubleMidOnly)
                } else {
                    let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midOnly)
                    new.setUnicode(newUnicode)
                    new.setCombinationStatus(.midOnly)
                }
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .midWithTop:
            if new.isVowel() {
                if canBeDouble(prev: prev, new: new) {
                    let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .doubleMidWithTop)
                    new.setUnicode(newUnicode)
                    new.setCombinationStatus(.doubleMidWithTop)
                } else {
                    let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midOnly)
                    new.setUnicode(newUnicode)
                    new.setCombinationStatus(.midOnly)
                }
            } else if isEnd(chararcter: new.getUnicode(), unicodeType: .compatible){
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .endWithMid)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.endWithMid)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .doubleMidOnly:
            if new.isVowel() {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midOnly)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.midOnly)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .doubleMidWithTop:
            if new.isVowel() {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midOnly)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.midOnly)
            } else if isEnd(chararcter: new.getUnicode(), unicodeType: .compatible) {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .endWithDoubleMid)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.endWithDoubleMid)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .endWithMid, .endWithDoubleMid:
            if new.isVowel() {
                var newUnicode = getNewUnicode(from: prev, oldType: .fixed, newType: .fixed, newStatus: .top)
                prev.setUnicode(newUnicode)
                prev.setCombinationStatus(.top)
                newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midWithTop)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.midWithTop)
            } else if canBeDouble(prev: prev, new: new){
                let newStatus: HG.CombinationStatus = status == .endWithMid ? .doubleEndWithMid : .doubleEndWithDoubleMid
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: newStatus)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(newStatus)
            } else {
                let newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .top)
                new.setUnicode(newUnicode)
                new.setCombinationStatus(.top)
            }
        case .doubleEndWithMid, .doubleEndWithDoubleMid:
            if new.isVowel() {
                var newUnicode = getNewUnicode(from: prev, oldType: .fixed, newType: .fixed, newStatus: .top)
                prev.setUnicode(newUnicode)
                prev.setCombinationStatus(.top)
                newUnicode = getNewUnicode(from: new, oldType: .compatible, newType: .fixed, newStatus: .midWithTop)
                new.setCombinationStatus(.midWithTop)
            } else {
                new.setCombinationStatus(.top)
            }
        default:
            break
        }
    }
}
