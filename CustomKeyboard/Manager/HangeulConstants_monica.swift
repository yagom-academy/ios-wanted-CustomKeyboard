//
//  HangeulConstants.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/13.
//

import Foundation

//struct HG {
//
//    enum Kind {
//        case consonant, vowel
//    }
//
//    enum Status {
//        case start // combinedBuffer에 아무 글자도 없을 때 == 지금까지 입력된 값이 없을 때
//        case top
//        case mid
//        case doubleMid
//        case end
//        case doubleEnd
//        case finishPassOne
//        case finishPassTwo
//        case space
//    }
//
//    static let baseCode = 44032
//    static let midCount = 21
//    static let endCount = 28
//
//    struct compatible {
//        static let topList: [Int] = [0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314A, 0x314B, 0x314C, 0x314D, 0x314E]
//        static let midList: [Int] = [0x314F, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158, 0x3159, 0x315A, 0x315B, 0x315C, 0x315D, 0x315E, 0x315F, 0x3160, 0x3161, 0x3162, 0x3163]
//        static let endList: [Int] = [0x3130, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313A, 0x313B, 0x313C, 0x313D, 0x313E, 0x313F, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314A, 0x314B, 0x314C, 0x314D, 0x314E]
//    }
//
//    struct fixed {
//        struct top {
//            static let kiyeok = 0x1100
//            static let sssangKiyeok = 0x1101
//            static let nieun = 0x1102
//            static let digeud = 0x1103
//            static let ssangDigeud = 0x1104
//            static let rieul = 0x1105
//            static let mieum = 0x1106
//            static let bieub = 0x1107
//            static let ssangBieub = 0x1108
//            static let sios = 0x1109
//            static let ssangSios = 0x110A
//            static let ieung = 0x110B
//            static let jieuj = 0x110C
//            static let ssangJieuj = 0x110D
//            static let chieuch = 0x110E
//            static let kieuk = 0x110F
//            static let tieut = 0x1110
//            static let pieup = 0x1111
//            static let hieuh = 0x1112
//
//            static let list: [Int] = [kiyeok, sssangKiyeok, nieun, digeud, ssangDigeud, rieul, mieum, bieub, ssangBieub, sios, ssangSios, ieung, jieuj, ssangJieuj, chieuch, kieuk, tieut, pieup, hieuh]
//        }
//
//        struct mid {
//            static let a = 0x1161
//            static let ae = 0x1162
//            static let ya = 0x1163
//            static let yae = 0x1164
//            static let eo = 0x1165
//            static let e = 0x1166
//            static let yeo = 0x1167
//            static let ye = 0x1168
//            static let o = 0x1169
//            static let wa = 0x116A
//            static let wae = 0x116B
//            static let oe = 0x116C
//            static let yo = 0x116D
//            static let u = 0x116E
//            static let wo = 0x116F
//            static let we = 0x1170
//            static let wi = 0x1171
//            static let yu = 0x1172
//            static let eu = 0x1173
//            static let eui = 0x1174
//            static let i = 0x1175
//
//            static let list: [Int] = [a, ae, ya, yae, eo, e, yeo, ye, o, wa, wae, oe, yo, u, wo, we, wi, yu, eu, eui, i]
//            static let double: [Int: [Int: Int]] = [o: [a: wa, ae: wae, i: oe], u: [eo: wo, e: we, i: wi], eu: [i: eui]]
//            static let split: [Int: [Int]] = [wa: [o, a], wae: [o, ae], oe: [o, i], wo: [u, eo], we: [u, e], wi: [u, i], eui: [eu, i]]
//
//        }
//
//        struct end {
//            static let blank = 0x11A7
//            static let kiyeok = 0x11A8
//            static let sssangKiyeok = 0x11A9
//            static let kiyeokSios = 0x11AA
//            static let nieun = 0x11AB
//            static let nieunJieuj = 0x11AC
//            static let nieunHieuh = 0x11AD
//            static let digeud = 0x11AE
//            static let rieul = 0x11AF
//            static let rieulKiyeok = 0x11B0
//            static let rieulMieum = 0x11B1
//            static let rieulBieub = 0x11B2
//            static let rieulSios = 0x11B3
//            static let rieulTieut = 0x11B4
//            static let rieulPieup = 0x11B5
//            static let rieulHieuh = 0x11B6
//            static let mieum = 0x11B7
//            static let bieub = 0x11B8
//            static let bieubSios = 0x11B9
//            static let sios = 0x11BA
//            static let ssangSios = 0x11BB
//            static let ieung = 0x11BC
//            static let jieuj = 0x11BD
//            static let chieuch = 0x11BE
//            static let kieuk = 0x11BF
//            static let tieut = 0x11C0
//            static let pieup = 0x11C1
//            static let hieuh = 0x11C2
//
//            static let list: [Int] = [blank, kiyeok, sssangKiyeok, kiyeokSios, nieun, nieunJieuj, nieunHieuh, digeud, rieul, rieulKiyeok, rieulMieum, rieulBieub, rieulSios, rieulTieut, rieulPieup, rieulHieuh, mieum, bieub, bieubSios, sios, ssangSios, ieung, jieuj, chieuch, kieuk, tieut, pieup, hieuh]
//            static let double: [Int: [Int: Int]] = [kiyeok: [sios: kiyeokSios], nieun: [jieuj: nieunJieuj, hieuh: nieunHieuh], rieul: [kiyeok: rieulKiyeok, mieum: rieulMieum, bieub: rieulBieub, sios: rieulSios, tieut: rieulTieut, pieup: rieulPieup, hieuh: rieulHieuh]]
//            static let split: [Int: [Int]] = [kiyeokSios: [kiyeok, sios], nieunJieuj: [nieun, jieuj], nieunHieuh: [nieun, hieuh], rieulKiyeok: [rieul, kiyeok], rieulMieum: [rieul, mieum], rieulBieub: [rieul, bieub], rieulSios: [rieul, sios], rieulTieut: [rieul, tieut], rieulPieup: [rieul, pieup], rieulHieuh: [rieul, hieuh]]
//
//        }
//    }
//}
