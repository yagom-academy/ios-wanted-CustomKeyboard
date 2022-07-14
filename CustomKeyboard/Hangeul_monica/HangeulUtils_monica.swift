//
//  HangeulUtils_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/14.
//

import Foundation

func toUnicode(from word: String) -> Int {
    return Int(UnicodeScalar(word)!.value)
}

func isMid(_ letter: Int, _ kind: HG.Kind) -> Bool {
    switch kind {
    case .fixed:
        return HG.fixed.mid.list.contains(letter)
    case .compatible:
        return HG.compatible.midList.contains(letter)
    default:
        return false
    }
}

func isEnd(_ letter: Int, _ kind: HG.Kind) -> Bool {
    switch kind {
    case .fixed:
        return HG.fixed.end.list.contains(letter)
    case .compatible:
        return HG.compatible.endList.contains(letter)
    default:
        return false
    }
}

func isTop(_ letter: Int, _ kind: HG.Kind) -> Bool {
    switch kind {
    case .fixed:
        return HG.fixed.top.list.contains(letter)
    case .compatible:
        return HG.compatible.topList.contains(letter)
    default:
        return false
    }
}

func getIndex(of letter: Int, _ kind: HG.Kind, _ status: HG.Status) -> Int {
    switch status {
    case .top:
        if kind == .fixed {
            return HG.fixed.top.list.firstIndex(of: letter) ?? 0
        } else {
            return HG.compatible.topList.firstIndex(of: letter) ?? 0
        }
    case .mid, .doubleMid:
        if kind == .fixed {
            return HG.fixed.mid.list.firstIndex(of: letter) ?? 0
        } else {
            return HG.compatible.midList.firstIndex(of: letter) ?? 0
        }
    case .end, .doubleEnd:
        if kind == .fixed {
            return HG.fixed.end.list.firstIndex(of: letter) ?? 0
        } else {
            return HG.compatible.endList.firstIndex(of: letter) ?? 0
        }
    default:
        return 0
    }
}

func getUnicode(of index: Int, _ kind: HG.Kind, _ status: HG.Status) -> Int {
    switch status {
    case .top:
        if kind == .fixed {
            return HG.fixed.top.list[index]
        } else {
            return HG.compatible.topList[index]
        }
    case .mid, .doubleMid:
        if kind == .fixed {
            return HG.fixed.mid.list[index]
        } else {
            return HG.compatible.midList[index]
        }
    case .end, .doubleEnd:
        if kind == .fixed {
            return HG.fixed.end.list[index]
        } else {
            return HG.compatible.endList[index]
        }
    default:
        return 0
    }
}

func canBeDouble(_ prev: Int, _ new: Int , _ status: HG.Status) -> Bool {
    if status == .mid {
        if isMid(new, .compatible) {
            let index = getIndex(of: new, .compatible, .mid)
            let fixedUnicode = getUnicode(of: index, .fixed, .mid)
            if HG.fixed.mid.double[prev]?[fixedUnicode] != nil {
                return true
            } else {
                return false
            }
        }
    } else if status == .end || status == .finishPassTwo {
        let index = getIndex(of: new, .compatible, .end)
        let fixedUnicode = getUnicode(of: index, .fixed, .end)
        if HG.fixed.end.double[prev]?[fixedUnicode] != nil {
            return true
        } else {
            return false
        }
    }
    return false
}

func getDouble(_ a: Int, _ b: Int, _ status: HG.Status) -> Int {
    switch status {
    case .doubleMid:
        return HG.fixed.mid.double[a]?[b] ?? 0
    case .doubleEnd:
        return HG.fixed.end.double[a]?[b] ?? 0
    default:
        return 0
    }
}

func getSplit(from word: Int,_ status: HG.Status, _ mode: HG.Mode) -> [Int] {
    if status == .mid && mode == .normal {
        return [word, 0, 0]
    }
    
    let unicode = word - HG.baseCode
    
    let top = (((unicode - (unicode % HG.endCount)) / HG.endCount) / HG.midCount) + HG.fixed.top.list.first!
    let mid = (((unicode - (unicode % HG.endCount)) / HG.endCount) % HG.midCount) + HG.fixed.mid.list.first!
    let end = (unicode % HG.endCount) + HG.fixed.end.list.first!
    
    return [top, mid, end]
}

func getCombine(_ top: Int, _ mid: Int, _ end: Int, _ isDoubleEnd: Bool) -> Int {
    var topIndex : Int!
    
    if isDoubleEnd {
        let splitEndSecondIndex = getIndex(of: top, .fixed, .end)
        let compatible = getUnicode(of: splitEndSecondIndex, .compatible, .end)
        topIndex = getIndex(of: compatible, .compatible, .top)
    } else {
        topIndex = getIndex(of: top, .fixed, .top)
    }
    let midIndex = getIndex(of: mid, .fixed, .mid)
    let endIndex = getIndex(of: end, .fixed, .end)
    
    let combinedWord = (topIndex * HG.midCount * HG.endCount) + (midIndex * HG.endCount) + endIndex + HG.baseCode
    
    return combinedWord
}

func isDouble(_ letter: Int, _ status: HG.Status) -> Bool {
    switch status {
    case .mid, .doubleMid:
        if HG.fixed.mid.split[letter] != nil {
            return true
        } else {
            return false
        }
    case .end, .doubleEnd:
        if HG.fixed.end.split[letter] != nil {
            return true
        } else {
            return false
        }
    default:
        return false
    }
}

func getSplitPair(_ letter: Int, _ status: HG.Status) -> [Int] {
    switch status {
    case .doubleMid:
        return HG.fixed.mid.split[letter]!
    case .doubleEnd:
        return HG.fixed.end.split[letter]!
    default:
        return []
    }
}

func getString(from val: Int) -> String {
    return String(UnicodeScalar(val)!)
}
