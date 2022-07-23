# ⌨️ Custom Keyboard


# 목차
  1. [팀원 소개 및 기여한 부분](#팀원-소개-및-기여한-부분)
  2. [프로젝트 소개](#프로젝트-소개)
     1. [목표](#목표)
     2. [사용한 기술](#사용한-기술)
     3. [기능 소개](#기능-소개)
        - Demo gif
     4. [객체 역할 소개](#객체-역할-소개)
        - 앱 설계 모식도
        - View 관련
        - Manger 관련
  3. [고민한 부분](#고민한-부분)
  4. [회고](회고)
  
---


# 팀원 소개 및 기여한 부분
|Downey|Peppo|Nala|
|:--:|:--:|:--:|
|[<img src = "https://user-images.githubusercontent.com/78457093/180595623-2eae40c6-9a35-491b-ad9d-a6cc2ee59817.jpeg" width = "200" height = "200">](https://github.com/dahun-lee-daji)|[<img src = "https://user-images.githubusercontent.com/78457093/180595896-1ae6c1a5-4ebe-48da-9d7d-8246046ec12e.jpg" width = "200" height = "200">](https://github.com/Bhoon-coding)|[<img src = "https://user-images.githubusercontent.com/78457093/180595624-861a7ee3-6831-4cd2-ad36-8a740dba04ab.png" width = "200" height = "200">](https://github.com/jazz-ing)|
|- Keyboard Automata 알고리즘 고안 <br />- Keyboard Automata의 글자 조합 분해 등 기초 기능 구현<br />- 각 뷰의 화면 전환 구현 <br />- 리뷰 업로드 기능 구현<br />- 작성한 시간과 현재시간을 비교하여 시간표기 기능 구현<br />- keyboardView UI 및 AutoLayout 구현|- Keyboard Automata 글자 조합 고도화<br>- Network Layer 구현<br>- API호출 (GET, POST) <br>- 리뷰 데이터 표시<br>- KeyboardView UI 하단 구현 |- Keyboard Automata 글자 조합 구현 <br> - Network Layer 구현 <br> - ReviewListView UI 구현|


---
# 프로젝트 소개


## 목표
> Apple Keyboard와 유사한 기능을 제공하는 customKeyboard를 사용하여 review의 내용을 가져오고, upload하는 기능을 수행하는 App

## 사용한 기술
`Observer Pattern` `Delegate Pattern` `Code-based UI` `MVC` `Dependency inversion`
<details markdown="1">
<summary>사용된 KeyboardAutomata 알고리즘 모식도</summary>

<img src = "https://user-images.githubusercontent.com/68788135/180596431-88fa2bf7-af35-4746-88ba-f9385c227ac8.png" width = "700">

</details>

## 기능 소개

### ReviewListPage
|Review 표시, 작성, 등록|
|:--:|
|<img src = "https://i.imgur.com/Ieo9jTH.gif" width = "300">

### KeyboardPage
|중성조합 <br /> `(ㅗ,ㅏ,ㅣ = ㅙ)`|종성조합 <br />`ㄱㅅ = ㄳ` <br /> 종성->중성|음절 단위삭제|단어 단위삭제|
|:--:|:--:|:--:|:--:|
|<img src = "https://i.imgur.com/DdcHeAE.gif" width = "220">|<img src = "https://i.imgur.com/B9DDH5L.gif" width = "220">|<img src = "https://i.imgur.com/clNjQqU.gif" width = "220">|<img src = "https://i.imgur.com/zqavRmj.gif" width = "220">|

## 객체 역할 소개
### 앱 설계 모식도
<img src = "https://user-images.githubusercontent.com/78457093/180602270-694ede2f-01cd-4b98-b2c2-5356eeaf92ce.png" width = "800">

### View 관련

| class / struct               | 역할                                                         |
| ---------------------------- | ----------------------------------------------------------- |
| `ReviewListView`             | - ReviewListViewController의 RootView.     |
| `ReviewTableViewCell`        | - Review의 내용과 작성자를 표시하는 Cell |
| `ReviewListViewController`   | - 각 Review와 작성자를 볼 수 있다. <br />- 현재 User의 Review를 POST 할 수 있다. <br />- KeyboardView로 이동 할 수 있다. |
| `KeyboardView`               | - KeyboardViewController의 RootView |
| `KeyboardViewController`     | - KeyboardAutomata를 사용하여 한글을 조합 할 수 있다. <br />- 작성한 한글을 ReviewListView로 전달한다. |
### Manger 관련

| class / struct               | 역할                                                         |
| ---------------------------- | ----------------------------------------------------------- |
| `KeyboardAutomata`           | - 순차적으로 얻어진 자모를 사용하여 한글을 조합하여 반환한다. |
| `EndPointType`               | - URLRequest를 반환하는데 필요한 정보를 정의하는 Protocol |
| `ReviewEndPoint`             | - EndPointType채택, URLRequest를 반환하는데 필요한 정보를 담고있는 객체 |
| `NetworkRequester`           | - EndPointType 혹은 URLRequest를 매개변수로 전달받아, 통신을 수행하는 객체 |
| `ReviewAPIProvider`          | - ReviewEndPoint, NetworkRequester를 사용하여 API통신을 수행하는 객체 <br />- 반환된 data를 Decode한다.|
| `ProfileImageProvider`       | - 이미지의 URL을 사용하여 Image data를 얻어오는 객체. <br />- image caching기능을 수행한다. |

---
# 고민한 부분

## Downey
- loadView에서 self.view를 변경하는 방식의 장점과 단점.
    - ViewController로 부터 View를 분리하여 VC내부 코드가 간소화 됨.
    - 개방 폐쇄를 위해 VC내 view insatnce를 소유하지 않는다면, view내부의 UIComponent에 접근이 어려움. 
    - 또한, action으로 present를 추가하고 싶을 경우, Delegate pattern을 사용해야 함. 
    - protocol을 이용한 delegate pattern을 사용함으로써, 코드 구조를 읽기 어려운 단점이 발생함.
- 오토마타 알고리즘
    - 오토마타 알고리즘은 유한 상태 머신과 같이 State를 Modeling한 점에서 착안하여 실제 한글을 조합 할 때의 경우를 Enum State로 모델링하였음. 
    - 이를 기반으로, 이전 글자와 새로 입력된 글자, 이전의 State를 비교하여 다음 State를 결정하고, State에 따라 글자를 조합하는 과정을 반복하는 것으로 구현.
## Peppo
- **Network Layer**


    - 개인적으로 싱글톤 패턴을 이용하여 NetworkManager에 URL, URLSession, dataTask 등 모두 한곳에서 네트워크를 호출.

    - **문제점**

        - HTTPMethod 별로 요청해야하는 URL도 달라지고, 고정되어있는 URL주소도 불필요하게 반복해서 써야하는 문제 발생.

    - **개선**

    - **EndPoint**

        - 각 상황에 맞게 baseURL, path, HTTPMethod, query를 나누어 값을 return 후 return값들을 조합한 requestURL 구현

    - **NetworkRequester**

        - 공통적으로 사용할 수 있는 dataTask 메서드 구현 및
필요에 따른 request 메서드 구현

    - **ReviewAPIProvider**

        - EndPoint -> NetworkRequester에 메서드를 사용하여 
상황에 맞게 fetchReview, upload 메서드를 활용해 네트워크 처리 

- **키보드 AutoLayout (spacing 문제)**

    - **문제점**
        - stackView로 키보드 레이아웃을 잡으면서 비율에 맞게 계산을해도 키보드 끝쪽이 찌그러지게 나옴


    - **개선**

        - 비율은 맞게 계산됐지만 StackView 자체의 spacing을 고려하지 않았던점이 문제가 되었고, spacing값을 고려해 재조정 후 시뮬레이터 별로 잘 나오지 않았던 키보드 레이아웃 해결

- **ViewLifeCycle (Modal)**

    - 1VC -> 2VC (modal) 로 이동할때 마다 2VC의 viewDidLoad()가 호출되는점 

    - **고민했던점** 

        - 처음 띄워졌을때’만’ viewDidLoad()가 호출되야 하지 않나..?

    - **해결**

        - 1VC에서 적용되는 상황과 헷갈렸었다. 
2VC가 dismiss 되면 2VC가 메모리에서 삭제되니까 
다시 2VC가 불려지면 viewDidLoad()가 호출되는게 맞다.





## Nala
- Cell에 있는 ProfileImageView의 cornerRadius가 적용되지 않는 문제
    - **문제상황** : 
        - ProfileImageView를 원으로 만들어주기 위해서는 cornerRadius의 값을 imageView의 width frame 값의 1/2로 줘야한다. 따라서 뷰의 frame 값이 정해진 시점에서 cornerRadius 값을 할당해줘야하므로 `layoutSubviews()`에서 이미지뷰의 cornerRadius값을 할당해줬다. 일반적인 ReviewListView에서는 해당 방식으로 이미지뷰를 원으로 만들어줄 수 있었는데, Cell에 있는 이미지뷰는 cornerRadius 값이 적용되지 않는 문제가 발생했다.
        - <img src = "https://user-images.githubusercontent.com/78457093/180603724-29019473-fef3-48c1-a707-0ecf08cff725.png" width = "200">
        - 위의 이미지에서 볼 수 있는 것처럼, Cell의 `layoutSubviews()`가 처음 불릴 때는 정확한 subview의 frame값을 얻을 수 없다. 일정 시간이 지나야 정확한 frame값을 찾아오는데 확실한 이유에 대해서는 아직 찾지 못했다.
    - **해결방법** :
        - 정확한 frame값이 이미 정해져있는 상태, 즉 `layoutSubviews()`가 호출된 후에 불리는 `draw(_:)`에서 cornerRadius 값을 할당해주는 방식으로 해결하였다.
- 키보드에서 'ㅃ'버튼을 누를 때 잠시 'ㅂ'이 보이는 문제
    - **문제상황** : 
        - shift버튼이 터치되면 쌍자음과 이중모음으로 버튼이 바뀌어야하므로 `button.setTitle(doubleCharacter, for: .selected)`와 같이 버튼의 상태가 selected인 경우에는 `doubleCharacter`를 title로 설정해주었다. 그런데 해당 버튼을 클릭할 때마다 잠깐씩 단자음, 단모음이 보이는 문제가 생겼다.
        - 알고보니 UIControl의 state가 어떻게 변하는지에 대한 이해가 부족해 생겼던 문제였다. UIControl은 기본적으로 비트로 관리된다. 왜 굳이 비트로 관리를 할까 고민을 해보았는데 실험 과정에서 한 번에 여러가지 상태를 가질 수 있기 때문에, 해당 상태를 비트 연산을 통해 비트 값으로 관리하기 위한 목적일 것이라고 추측했다. 
        - 예를 들어 우리가 겪은 문제 상황의 경우, shift버튼이 눌리면 특정 버튼들의 `isSelected`를 true로 바꿔줬음에도 버튼이 터치되는 순간에는 highlighted 상태가 추가가 돼 `button.setTitle(doubleCharacter, for: .selected)`의 코드가 적용되지 않아 생기는 문제였다. 즉 `.selected`만 있는 비트값과 `.selected`와 `.highlighted`를 둘 다 갖는 비트값이 달랐기 때문이다. 
    - **해결방법** :
        - `.selected`와 `.highlighted` 둘다가 선택된 상황에서도 쌍자음, 이중모음을 보여줄 수 있도록 비트 연산을 해서 아래와 같이 코드를 변경했다.
        ```swift=
        button.setTitle(doubleCharacter, for: Style.selectedAndHighlighted)

        enum Style {
            static let selectedAndHighlighted: UIControl.State = .init(
                rawValue: UIControl.State.selected.rawValue | 
                UIControl.State.highlighted.rawValue
            )
        }
        ```


---
# 회고

## Downey
- 이번 프로젝트의 리드는 하기 힘들것이라 생각했다. 직전 프로젝트를 리드했기 때문에, 심력적으로 좀 힘들었달까... 그래서 팀원 중 활발한 누군가가 있다는점이 매우 기꺼웠다! 심지어 자신이 하고싶은 개발방향도 있었다! 그래서 매우 안심되었다.... 날라 리드를 해줘서 고맙습니다.

- 나는 어떤 지식을 많이 풀이해서 설명하는 것을 잘 못 한다. 아는 것을 설명하는 것을 못하는 것이 아니라, 연결된 기반 지식까지 다 끌어와서 얘기를 구성하지 못한다는 것. 매우 배우고 싶은 점이었다.

- 프리온보딩 코스는 개인적으로 힘든 과정이라고 생각한다. WorkTime이 9to21이란 점에서 매우 그러하다. 나는 기본적으로 이러한 프로젝트와 엮여있으면, 휴식과정에도 지속적으로 프로젝트에 대한 생각을 하는데, 이는 휴식 효율이 좋지않다. 나의 비효율적인 휴식과 9to21이 엮여, 스트레스의 해소가 매우 어려웠다. 이러한 스트레스로 인해 오토마타를 어떻게 만들어야 하는지 떠오르지 않음, Reference 코드를 읽어도 구조가 이해되지 않음 등의 문제가 빈발하여, 프로젝트가 매우 지연되었다. 휴식을 충분히 취하는 것이 매우 중요하다고 다시 한 번 배우게 된 계기.

- `충분한 휴식을 취하는데 실패함`, `외출을 안함`, `운동을 안함`, `식사를 대충 함`, `수면이 부족함`의 시너지로 강한 두통과, 대상포진이 다시 올 뻔 했다. 자신에게 인권을 부여하자...

- 프로젝트 와중, 면접을 보게 되었다. 이로 인하여, 팀원의 협조아래 프로젝트에 할애하는 시간을 줄였다. 프로젝트가 원활하지 않았던 사유 중 하나이다. 한번에 여러가지 일을 하는 것은 역시 바람직하지 않다.
## Peppo
- 이번 프로젝트엔 다우니, 날라가 정말 잘 이끌어줬다. 개발에 대한 지식도 차이가 나는게 느껴졌고, 부족한점을 한번 더 돌아보게 되는 좋은계기가 되었던것 같다. 조곤조곤 논리적으로 설명해줬던 다우니, 이해가 안되던 부분을 알때 까지 알려주고 활발한 성격으로 팀 분위기를 잘 이끌어줬던 날라. 덕분에 잘 마무리 할 수 있었습니다. 고맙습니다.😄 
- 벌써 두번째 프로젝트가 끝났다. 조원분들의 속도에 못 따라갔던 점이 심적으로 많이 힘들었던것 같다. 괜히 조심스러워지고 하다보니 저절로 말 수 도 줄어들게 되는 내가 보였다. 멘토 우디에게도 상담을 받았었던 날이 있었는데, `나에게 부족한게 어떤건지를 파악하고 채우는자세가 중요하다`라는 말에 많이 공감됐고 힘이됐었다. 처음보는 구조와 기술들이 다 낯설었지만 정말 기술적으로, 인간적으로 배워가는게 많았었다. 

- 키보드 오토마타에서 다우니가 짜놓은 알고리즘의 흐름을 파악하고 덧붙이는 작업을 하는게 어려웠지만, 이걸 구상한거 자체가 더 어려웠을것으로 보인다.  로직을 이해 될때까지 읽어보고 분석하고 배워가는점도 많았다. 
- 하루 12시간동안 프로젝트를 진행하다보니 체력적으로 많이 힘들었던것 같다. 활동량도 많이 줄어 일부러 새벽에 운동을 하러가서 부족한 활동량과 체력을 길렀다. 기간이 그래도 짧다면 짧고 길다면 길지만 5주라서 참고 견딜 수 있는것 같다.
## Nala
- 첫번째 프로젝트와 두번째 프로젝트 모두 토요일까지 알차게 시간을 써서 프로젝트를 마무리했다. 다른 팀들은 대부분 금요일이면 모두 리드미정리까지 어느정도 마쳐두는 것 같았는데 나는 두 프로젝트 모두 마감기한인 토요일 12시 전까지 시간을 꽉 채워 사용했다. 여러 생각들을 하다가 결국은 나에게 문제가 있다는 결론에 다다랐다.   
    특히나 리드 실력에 처참한 부족함이 있었다고 생각한다. 모든 팀원은 프로젝트에서 특정 부분을 리드하게 된다. 나의 경우도 일정 부분의 리드를 맡게 되었는데, 그 상황에서 프로젝트 전체에 대한 그림과 각 기능 구현에 걸릴 시간, 지금 구현하고 있는 기능을 마쳐야할 데드라인 등 구체적인 계획을 세우는 데 실패하였다.  
    리더란 무엇이며, 리드란 무엇인가에 대해 생각해보았을 때 나는 좋은 리더, 훌륭한 리드란 전체를 보는 눈과 큰 틀에 대한 계획을 통해 팀원 전체가 올바른 방향으로 나아갈 수 있도록 돕는 것이라고 생각한다. 하지만 아직 나에겐 그런 자질이 부족한 것 같다.   
    하지만 위에서 말했던 것처럼 나는 모든 팀원이 특정 부분에서는 리드를 하게 된다고 생각하며 특히나 소프트웨어를 만드는 곳이라면 더더욱 그렇다고 생각한다. 그렇기 때문에!! 계속해서 리드 실력을 키워나가야지. 전체를 보는 눈, 구체적인 계획을 세워 스프린트를 실천할 수 있는 능력을 키우자.  

- 프로젝트를 진행하는 과정에서 여러가지 부침이 있었다고는 해도, 나는 이번 프로젝트의 팀원 합이 참 잘 맞았다고 생각한다. 다우니는 5년차 개발자를 구하는 회사에 들어갈만큼ㅋㅋㅋ 실력이 출중해 정말 배울 것이 많았고, 어려우셨을텐데도 꾸준하게 계속해서 노력하고 발전하고 성장하는 페포를 보며 개발자에게 중요한 자질이 무엇인지 많이 느낄 수 있었다. 키보드 뷰 구현과 오토마타라는 특수성이 짙은 프로젝트라는 점에서 큰 흥미를 느끼지 못하며 프로젝트를 시작했는데, 팀원들덕분에 생각보다 26배정도는 재미있게 진행했던 것 같아 뿌듯하다. 정말 정말 즐거운 시간이었다!
