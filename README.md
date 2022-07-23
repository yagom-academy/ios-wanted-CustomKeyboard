# Custom Keyboard
- 서버 API를 이용하여 리뷰 목록을 가져오고, 새로운 리뷰를 작성하는 기능
- 화면에 키보드 자판 버튼들을 배치해서, 누르면 한글 키보드처럼 조합되는 한글 쿼티 화면을 구현
- Keyboard Extension을 이용하여 실제 한글 키보드 구현

## 팀원

mini|cobugi
:-:|:-:
<img src="\Previews\mini.jpeg" alt="mini" />|<img src="\Previews\cobugi.png" alt="cobugi" />


## 한글 오토마타 로직 Flow Chart

<img src="\Previews\CustomKeyboardFlowChart.svg" alt="CustomKeyboardFlowChart" />

## 이슈
### 키보드 입력시 긴 글자가 다음 줄로 안넘어 가는 현상

- ex) ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ...
- 참고 [http://www.unicode.org/charts/](http://www.unicode.org/charts/)
- 💡한글 유니코드에는 초성, 중성, 종성 뿐만 아니라 호환형(Compatibility)도 존재한다.  
- 초성, 중성, 종성은 하나의 Character로 인식해서 다음 줄로 안넘어 갔었다. 마우스로 문자를 드래그 해보면 하나의 글자로 드래그 된다.  
- 호환형으로 입력하면 더이상 조합이 되지 않으므로 이 문제를 해결할 수 있었다.

### 키보드 익스텐션에서 직접 구현한 오토마타 사용하기

- 작성된 로직은 음소를 지우는 방법을 사용했지만, 키보드 익스텐션에서는 음소를 지우는 기능을 제공하지 않음
- 처음에 생각한 방법은 documentProxy에 있는 모든 글자를 지우고, 완성된 글자를 모두 insert하는 방법을 활용하였다.
- 이에 대한 속도를 테스트하는 과정에서 글자의 개수가 많아지면, 속도가 느려지는 것을 확인했다.
    ``` swift
    // 처음에 생각한 방법
    keyboardView.viewModel.result.bind { value in
        if let documentCount = proxy.documentContextBeforeInput?.count {
            for i in 0..<documentCount {
                proxy.deleteBackward()
            }
        }
        proxy.insertText(value)
    }
    ```

- 로직에서 조합된 마지막 글자를 가져와서 유니코드의 개수와 documentProxy에 작성된 것과 개수를 비교하여 로직을 작성

    ``` swift
    // 개수를 비교하는 과정에서 확인한 규칙
    // documentProxy : result
     0("") : 1(ㅇ)
     1(아) : 2(ㅇ ㅏ)
     2(아) : 3(안)
     3(앉) : 2(자)
     3(안) : 3(앉)
    ```

### 리뷰 TableView를 스크롤할 때, 이미지를 받아올 수 없는 리뷰의 프로필 ImageView에 다른 리뷰의 프로필 이미지가 들어오는 현상
- URLSession을 이용한 이미지 다운로드는 비동기로 진행되므로 셀에서 이미지를 받아오려고 호출했을 때 다른 셀에 적용되는 것이였다.  
- `prepareForReuse` 메서드를 이용하여 DataTask를 Cancel하고 ImageView도 초기화 해주어 해결했다.

### 오토마타 로직을 테스트할 때 shift, back, space 버튼들을 테스트 할 수 없던 현상
- 처음에 작성한 로직은 사람이 직접 shift, back, space  버튼을 눌렀는지를 판단했었다.
- 그래서 유닛 테스트를 진행할 때는 shift, back, space 를 눌러줄 수 없어서 테스트 진행이 어려웠다.
- 사람이 직접 눌렀는지를 판별하는게 아니라 `쌍자음(+ ㅒ, ㅖ)`, `" "`이 입력 됐는지를 판별하여 좀 더 테스트 하기 쉽도록 해결하였다.

## 기술
- Code based UI
- MVVM
- Data Binding(Observable)
- URLSession
- NSCache, FileManager (이미지 캐싱)
- XCTest

## 결과
이미지1|이미지2|이미지3
-|-|-
![](https://i.picsum.photos/id/682/2560/1440.jpg?hmac=6CnDAyJ4sqM6r-Ue0NIGazspfqpqsFGAInkNYGfUXuk)|![](https://i.picsum.photos/id/682/2560/1440.jpg?hmac=6CnDAyJ4sqM6r-Ue0NIGazspfqpqsFGAInkNYGfUXuk)|![](https://i.picsum.photos/id/682/2560/1440.jpg?hmac=6CnDAyJ4sqM6r-Ue0NIGazspfqpqsFGAInkNYGfUXuk)
