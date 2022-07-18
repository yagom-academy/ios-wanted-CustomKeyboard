//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
//

import UIKit

protocol KeyboardViewControllerDelegate {
    func updateLabelText(_ reviewText : String?)
}

class KeyboardViewController: BaseViewController {
    
    let initial = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    let neuter = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ",
                  "ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ",
                  "ㅡ","ㅢ","ㅣ"]

    let neuterForSearch = ["ㅏ","ㅏㅣ","ㅑ","ㅑㅣ","ㅓ","ㅓㅣ","ㅕ","ㅕㅣ","ㅗ",
                  "ㅗㅏ","ㅗㅐ","ㅗㅣ","ㅛ","ㅜ","ㅜㅓ","ㅜㅔ","ㅜㅣ","ㅠ",
                  "ㅡ","ㅡㅣ","ㅣ"]

    let final = ["", "ㄱ", "ㄲ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    let consonant = [
        "ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ",
        "ㅔ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","up","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]

    let doubleConsonant = [
        "ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ",
        "ㅖ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","up","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]

    var isShift : Int = 0
    var buffer : [String] = []
    var count : Int = 0
    
    var delegate : KeyboardViewControllerDelegate?
    
    private let keyboardView = KeyboardView()
    
    override func loadView() {
        super.loadView()
        self.view = keyboardView
        keyboardView.collectionView.dataSource = self
        keyboardView.collectionView.delegate = self
    }
}

extension KeyboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboadCollectionViewCell.identifier, for: indexPath) as? KeyboadCollectionViewCell else { return UICollectionViewCell() }
        if isShift == 0 {
            cell.letter.text = consonant[indexPath.row]
        } else {
            cell.letter.text = doubleConsonant[indexPath.row]
        }
        return cell
    }
}

extension KeyboardViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //cell의 크기를 지정해주는 함수 sizeForItemAt
        return CGSize(width: 35, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {// 옆 간격을 지정해 줄 수 있는 함수 minimumInteritemSpacingForSectionAt
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 세로 간격을 지정해주는
        return 6
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        
        //Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(2/5)
            ),
            subitem: item,
            count: 2
        )
        
        //Sections
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension KeyboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        keyboardView.reviewTextLabel.text! += letters[indexPath.row]
        
        // Save in buffer
        if isShift == 0 {
            if consonant[indexPath.row] != "지움", consonant[indexPath.row] != "up", consonant[indexPath.row] != "엔터" {
                if consonant[indexPath.row] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(consonant[indexPath.row])
                }
            }
        } else {
            if doubleConsonant[indexPath.row] != "지움", doubleConsonant[indexPath.row] != "up", doubleConsonant[indexPath.row] != "엔터" {
                if doubleConsonant[indexPath.row] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(doubleConsonant[indexPath.row])
                }
            }
        }
        
        print("buffer : \(buffer)")
        if consonant[indexPath.row] == "지움" || doubleConsonant[indexPath.row] == "지움" {
            erase()
        } else if consonant[indexPath.row] == "up" || doubleConsonant[indexPath.row] == "up" {
            pressUp()
        } else if consonant[indexPath.row] == "엔터" || doubleConsonant[indexPath.row] == "엔터" {
            // 첫번째 화면의 label에 내용 담고 모달 닫기
            pressEnter()
        }
        keyboardView.reviewTextLabel.text = automata().joined(separator: "") // convert array to string
    }
    
    func pressEnter() {
        delegate?.updateLabelText(keyboardView.reviewTextLabel.text)
        dismiss(animated: true)
    }
    
    func pressUp() {
        print("in?")
        if isShift == 0 {
            isShift = 1
        } else {
            isShift = 0
        }
        keyboardView.collectionView.reloadData()
    }
    
    func automata() -> [String] {
        
        // 라벨에 표시할 글자
        var finish : [String] = []
        
        // 초기화 (유무)
        var initialFlag = 0
        var neuterFlag = 0
        var finalFlag = 0
        var secondFinalFlag = 0
        
        // 초기화 (Index)
        var initialIndex = -1
        var neuterIndex = -1
        var finalIndex = -1
        var secondFinalIndex = -1
        
        var i = 0
        while i < buffer.count {
            // space
            if buffer[i] == " " {
                var makeWord : Int = 0
                // 초성, 중성, 종성 있을 때
                if initialIndex != -1, neuterIndex != -1, finalIndex != -1 {
                    makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성, 중성 있을 때
                } else if initialIndex != -1, neuterIndex != -1 {
                    makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성만 있을 때
                } else if initialIndex != -1 {
                    finish.append(initial[initialIndex])
                }
                finish.append(" ")
                
                // 초기화
                initialFlag = 0
                neuterFlag = 0
                finalFlag = 0
                secondFinalFlag = 0
                
                initialIndex = -1
                neuterIndex = -1
                finalIndex = -1
                secondFinalIndex = -1
                i += 1
                continue
            }
            
            // 글자의 시작일 때
            if initialFlag == 0, neuterFlag == 0 {
                // 처음에 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 다음 모음이랑 합쳐질 수 없다면
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                    neuterFlag = 1
                    i += 1
                    continue
                    // 처음에 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    initialFlag = 1
                    i += 1
                    continue
                }
            } else if initialFlag == 0, neuterFlag == 1 {
                // 다음에 모음이 왔을 때 합쳐질 수 잇다면
                if neuterForSearch.contains(neuter[neuterIndex] + buffer[i]) {
                    finish.append(neuter[neuterForSearch.firstIndex(of: neuter[neuterIndex] + buffer[i]) ?? -1])
                    neuterFlag = 0
                    neuterIndex = -1
                }
                // 다음에 모음이 왔을 때 합쳐질 수 없다면
                else if !neuter.contains(neuter[neuterIndex] + buffer[i]), !initial.contains(buffer[i]) {
                    finish.append(neuter[neuterIndex])
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                }
                // 다음에 자음이 왔을 때
                else if initial.contains(buffer[i]) {
                    finish.append(neuter[neuterIndex])
                    neuterFlag = 0
                    neuterIndex = -1
                    continue
                }
                i += 1
                continue

            } else if initialFlag == 1, neuterFlag == 0, finalFlag == 0 {
                // 초성이 있는 상태에서 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // 기존에 있던 초성을 finish에 append
                    finish.append(initial[initialIndex])
                    // 이것을 initialIndex에 할당
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    i += 1
                    continue
                } else if neuter.contains(buffer[i]) {
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                    neuterFlag = 1
                    i += 1
                    continue
                }
            } else if initialFlag == 1, neuterFlag == 1, finalFlag == 0 {
                // 종성으로 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 기존에 완성되었던 것들 조합해서 finish에 append (모음끼리 합쳐질 수 없을 때)
                    if !neuterForSearch.contains(neuter[neuterIndex] + buffer[i]) {
                        let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                        finish.append(String(UnicodeScalar(makeWord)!))
                        neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                        // 글자가 다시 시작될 수 있도록 전부 초기화
                        initialFlag = 0
                        finalFlag = 0
                        initialIndex = -1
                        finalIndex = -1
                    } else {
                        neuterIndex = neuterForSearch.firstIndex(of: neuter[neuterIndex] + buffer[i]) ?? -1
                    }
                    
                    
                    i += 1
                    continue
                    // 종성으로 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    if final.contains(buffer[i]) {
                        finalIndex = final.firstIndex(of: buffer[i]) ?? -1
                        finalFlag = 1
                    } else {
                        let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                        finish.append(String(UnicodeScalar(makeWord)!))
                        
                        initialFlag = 0
                        initialIndex = -1
                        neuterFlag = 0
                        neuterIndex = -1
                        continue
                    }
                    i += 1
                    continue
                }
            } else if initialFlag == 1, neuterFlag == 1, finalFlag == 1, secondFinalFlag == 0 {
                // 자음이 또 왔을 때 기존의 종성이랑 합쳐질 수 있으면
                if final.contains(final[finalIndex] + buffer[i]) {
                    secondFinalIndex = final.firstIndex(of: buffer[i]) ?? -1 //
                    secondFinalFlag = 1
                    i += 1
                    continue
                }
                // 자음이 또 왔을 때 기존의 종성과 함쳐질 수 없으면
                else if initial.contains(buffer[i]), !final.contains(final[finalIndex] + buffer[i]) {
                    // 기존에 완성된 글자 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // initialIndex에 value 저장
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    initialFlag = 1
                    
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    i += 1
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 제외한 기존 글자 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 종성 글자를 초성으로 변경, value를 모음 index에 저장
                    initialIndex = initial.firstIndex(of: final[finalIndex]) ?? -1
                    
                    initialFlag = 1
                    
                    // 나머지는 초기화
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    continue
                }
                // 종성에 ㄴㅈ 이런게 있을 때
            } else if secondFinalFlag == 1 {
                // 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // ㄴ, ㅈ 합쳐서 새로운 인덱스로 넣고
                    finalIndex = final.firstIndex(of: final[finalIndex] + final[secondFinalIndex]) ?? -1
                    // 기존에 완성된거 출력
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    
                    initialFlag = 0
                    initialIndex = -1
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    secondFinalFlag = 0
                    secondFinalIndex = -1
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 ㄴ으로 선택하고 앞에 글자 완성시킨다음 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // ㅈ 은 initialIndex에 할당
                    initialIndex = initial.firstIndex(of: final[secondFinalIndex]) ?? -1
                    initialFlag = 1
                    
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    secondFinalFlag = 0
                    secondFinalIndex = -1
                    continue
                }
            }
        }
        
        // 찌꺼기 처리
        var makeWord : Int = 0
        // 초성, 중성, 종성 있을 때
        if initialFlag == 0, neuterFlag == 1 {
            finish.append(neuter[neuterIndex])
        }
        if secondFinalIndex != -1 {
            finalIndex = final.firstIndex(of: final[finalIndex] + final[secondFinalIndex]) ?? -1
        }
        if initialIndex != -1, neuterIndex != -1, finalIndex != -1 {
            makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
            finish.append(String(UnicodeScalar(makeWord)!))
            // 초성, 중성 있을 때
        } else if initialIndex != -1, neuterIndex != -1 {
            makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
            finish.append(String(UnicodeScalar(makeWord)!))
            // 초성만 있을 때
        } else if initialIndex != -1 {
            finish.append(initial[initialIndex])
        }
        
        print(finish)
        return finish
    }
    
    func erase() {
        if buffer.isEmpty == false {
            buffer.removeLast()
        }
    }
    
}
