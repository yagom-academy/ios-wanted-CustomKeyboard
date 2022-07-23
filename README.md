
# CustomKeyBoard 
![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-orange) ![Xcode 13.3](https://img.shields.io/badge/Xcode-13.3-blue)

- 커스텀으로 키보드 UI 를 만들고, 한글입력 로직을 구현했습니다. 
- 커스텀 키보드 를 사용하여 리뷰를 남기고, 확인할수 있는 앱 입니다.

## 팀원 소개 
| [@호이](https://github.com/JangJuMyeong)| [@Kai](https://github.com/TaeKyeongKim)|
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | 
| <img src="https://cphoto.asiae.co.kr/listimglink/6/2013051007205672589_1.jpg" width="100" height="100"/> | <img src="https://avatars.githubusercontent.com/u/36659877?v=4" width="100" height="100"/> |

<details>
<summary> [팀 그라운드룰]</summary>
<div markdown="1">
🗣️ 스크럼
`9:00~ 10:00`

- 어제 작업내용 (간략하게)
- 오늘 할일 (간략하게)
- 그외 협의 사항
- 컨디션 공유도 가능

---

📏 그라운드 룰

- 코어 타임 : 9:00 ~ 21:00
- 코어타임 외 급한 용무시 : Discoard DM

---

👥 Team Member 

- 호이
    - GitHub ID : 1. JangJuMyeong [https://github.com/JangJuMyeong](https://github.com/JangJuMyeong)
- Kai
    - GitHub ID : TaeKyeongKim [https://github.com/TaeKyeongKim](https://github.com/TaeKyeongKim)

---

📄Convention
- Git
- 브랜치 컨밴션 : -b feature/{issue이름}
- Commit
    - `feat`: 새로운 기능을 추가할 경우
    - `fix`: 버그를 고친 경우
    - `docs`: 문서 수정한 경우
    - `style`: 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우
    - `refactor`: 프로덕션 코드 리팩터링
    - `test`: 테스트 추가, 테스트 리팩터링 (프로덕션 코드 변경 없음)
    - `chore`: 빌드 테스크 업데이트, 패키지 매니저 설정할 경우 (프로덕션 코드 변경 없음)]
    - `build` : 프로젝트 빌드관련 설정 수정
    - `move` : 코드나 파일의 이동
</div>
</details>


### 담당 화면 및 기술 
-  호이: Main Home 화면, CustomKeyboard 한글 타자 로직 구현
-  Kai: 리뷰 작성 화면, 네트워크 레이어 구현

## 🛠 기능 구현 
### Home 화면
| **로드 완료 된 홈화면**|**리뷰 작성 화면 전환**|
|---|---|
|<img src="https://user-images.githubusercontent.com/36659877/180597166-d1f60403-40d2-4ef1-8adb-40a13e26901c.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180597193-76ddc9e9-a0f0-405a-8971-f60fb7ae050c.gif" width="200" height="400"/>

- [x] 서버 API에서 상품 리뷰 목록을 가져온 후 화면에 표시합니다.
- [x] 사용자의 이름, 리뷰 내용, 프로필 이미지가 표시합니다.
- [x] 댓글을 작성한 시간이 1시간 이내일 경우 분 단위로 표시, 하루 이내일 경우 시간 단위로 표시, 하루 이상일 경우 년월일만 표시 합니다.

### Keyboard 

|**Return 버튼**|**Back 버튼**|**Shift 버튼**|
|---|---|---|
|<img src="https://user-images.githubusercontent.com/36659877/180597818-ff77a7b9-55ab-43dc-aa4e-0c2cffdda05e.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180597877-285bf9e0-53d6-4265-b357-4f19db16dd6d.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180597961-90462f48-7a49-4cf3-b4a4-3687ea259642.gif" width="200" height="400"/>|

|**Space 버튼**|**한글 완성**|
|---|---|
|<img src="https://user-images.githubusercontent.com/36659877/180598047-93446269-9ef8-4b2b-8efb-ac70dd440bc3.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180598066-fddb2feb-4c83-4762-99ef-cd7cd51280fe.gif" width="200" height="400"/>|


- [x] 화면 하단에 키보드 자판 버튼들을 배치하고, 누르면 한글 키보드처럼 조합되며, 조합되는 내용이 화면 상단에 표시되는 한글 쿼티 화면을 구현.
- [x] 뒤로가기를 누를 경우, 조합중인 글자 중 한 음소만이 사라져야합니다.
- [x] 쉬프트 키를 눌렀을 때 쉬프트 버튼의 모습이 바뀌고, ㅂㅈㄷㄱㅅㅐㅖ 가 ㅃㅉㄸㄲㅆㅒㅖ 로 변하며 이 키들을 누르면 바뀐 글자로 입력할 수 있습니다.
- [x] return 버튼을 눌렀을 때 첫 번째 화면으로 이동하며, 첫 번째 화면의 리뷰 입력 칸에 입력한 텍스트가 표시됩니다. (Text 가 아무것도 없을시, 키보드만 내려갑니다) 




### Review 남기기 화면

|**취소 버튼**|**게시 버튼**|**키보드 Return 버튼**|
|---|---|---|
|<img src="https://user-images.githubusercontent.com/36659877/180598437-4bde5388-f69a-4998-a824-b7f4d0223277.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180598516-76ffc820-c70e-4979-a8fd-3589f3faa4dd.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/36659877/180598439-2d44899c-d0bb-431c-a38c-d99a8c119f0e.gif" width="200" height="400"/>|


- [x] 사용자가 리뷰를 작성한 후 작성 버튼을 누르면 서버 API로 POST 요청을 보내서 서버에 추가한 뒤, 리뷰 목록에 사용자가 작성한 댓글을 추가합니다.
리뷰 작성 칸을 누르면 두 번째 화면으로 이동합니다.
- [x] 두 번째 화면에서 리뷰를 작성한 후, return하면 첫 번째 화면의 리뷰 작성 칸에 작성한 내용이 표시됩니다.
- [x] 게시 버튼은 사용자가 아무것도 입력을 하지 않을시 비활성화 됩니다. 
- [x] 사용자가 아무것도 입력을 하지 않을시 리턴 버튼을 누르면 키보드만 내려갑니다. 


## 설계 

### 네트워크 Layer 

  <p align="center">
   <img src="https://user-images.githubusercontent.com/36659877/180599495-02eed3b1-0141-460c-a8ed-656b2e86f5fa.png" width="300" height="200"> 
   </p>

- Endpoint
> 특정 API 주소 를 갖는 ServerPath 와, queryItem 들을 가지고 있습니다. 
> URLComponents 를 사용하여 request 보낼 특정 url 를 계산할수 있습니다. 

- Request 
> HTTP 요청타입, body 에 담을 데이터, endPoint 를 가지고 있습니다. 
> 이 정보들을 사용하여 `URLRequest` 를 만들수 있습니다.

- NetworkService
> 서버에 요청하고, response 를 받아오는 핵심로직을 가지고 있습니다. 

### 아키텍쳐 



