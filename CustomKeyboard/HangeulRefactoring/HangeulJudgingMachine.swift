////
////  HangeulJudgingMachine.swift
////  CustomKeyboard
////
////  Created by hayeon on 2022/07/16.
////
//
//import Foundation
//
//
//
//class HangeulJudgingMachine {
//
//    func isMid(unicode: Int) -> Bool {
//        for hangeul in HangeulDictionary.compatible.mid.allCases {
//            if hangeul.rawValue == unicode {
//                return true
//            }
//        }
//        return false
//    }
//
//    func isEnd(unicode: Int) -> Bool {
//        for hangeul in HangeulDictionary.compatible.end.allCases {
//            if hangeul.rawValue == unicode {
//                return true
//            }
//        }
//        return false
//    }
//
//
//    func isDoubleMid(unicode: Int) -> Bool {
//        for hangeul in HangeulDictionary.compatible.doubleMid.allCases {
//            if hangeul.rawValue == unicode {
//                return true
//            }
//        }
//        return false
//    }
//
//    func cannotHaveEnd(_ curr: Hangeul) -> Bool {
//        if curr.prev?.prev == nil {
//            return true
//        } else if curr.prev?.prev?.status == .finished {
//            return true
//        } else if curr.prev?.position.last! == .mid2 {
//            if curr.prev?.prev?.prev == nil {
//                return true
//            } else if curr.prev?.prev?.position.last! == .mid1 && curr.prev?.prev?.prev?.status == .finished {
//                return true
//            }
//        }
//
//        return false
//    }
//
//    deinit {
//        print("close judgingMachine")
//    }
//}
