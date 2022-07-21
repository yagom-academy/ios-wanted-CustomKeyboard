
## 👨‍👩‍👦‍👦 팀원 소개

| <center>UY</center>   | <center>우지</center> |
| -------------------------------------------------------- | --------------------------------------------------------- |
| [<img src="https://github.com/ScutiUY.png" width="200">](https://github.com/ScutiUY) |  [<img src="https://github.com/wooooozin.png" width="200">](https://github.com/wooooozin) 

<br>

## 🖥 프로젝트 소개
### **애플리케이션 설명**
- 서버 API를 이용하여 리뷰 목록을 가져오고, 새로운 리뷰를 작성이 가능합니다.
- 화면에 키보드 자판 버튼들을 배치해서, 누르면 한글 키보드처럼 조합되는 한글 쿼티 화면을 구현했습니다.
- Keyboard Extension을 이용하여 실제 한글 키보드를 만들어봅니다.

<br>

## ⏱️ 개발 기간 및 사용 기술

- 개발 기간: 2022.07.11 ~ 2022.07.23 (2주)
- 사용 기술:  `UIKit`, `URLSession`, `ExtensionKeyboard`, `NSCache`,  `MVC`

<br>

## 🖼 디자인 패턴
### MVVM? MVC?

- MVC를 선택한 이유

1. 규모가 크지 않은 프로젝트에서 보여줄 뷰의 수가 많지 않음 ✅

2. 기능의 직관적인 분리

3. Model과 View가 다른 곳에 종속되지 않음 → 확장의 편리성

<br>

## 📌 핵심 기술

- 


<br>

## ⭐ 새로 배운 것

-  


<br>

## 📖 DataFlow

<br>

## ⚠️ 이슈

- URLSession Network Layer에 관한 고민
    
```Text
→ 네트워크 관련 라이브러리를 사용하지 않을 때 효율적인 network layer를 만들 수 있을지에 대한 고민과 에러 및 예외 처리에 대한 고민

→  여러 시도 후 URL, NetworkError, HTTPMethod, URLSession, URLRequest, API, Resource 등으로 나누어 구현

→ ConstanURL : “GET”, “POST” 통신을 하는 URL 등을 지정하는 별도 파일

→ NetworkError : 네트워크 및 서비스 관련 설정한 에러를 처리할 수 있도록 생성

→ Resource : Encodable, Decodable type을 Generic하게 입력받을 수 있도록 생성

→ HTTPMethod : HTTPMethod를 enum type 으로 전달

→ URLSession : URLSession의 request를 Resource에 맞춰 request할 수 있도록, upload, load 함수 생성

→ API : Singleton 방식으로 API 객체를 생성하여 관리하고 통신을 시도하는 객체

→ 현재 URL이 적어 URL주소 전체를 적용했으나 추후 많은 양의 URL주소가 있을 시 
  URL을 scheme, host, path, parameter(questyString) 등으로 나누어 구현하는 방법도 적용해보는 것도 좋을 것 같음
```

<br>

- Data(contentsOf: url?)에 관한 고민

```Text
→ 처음 네트워크 구현 시 init(contesntsOf: url)메소드 사용

→ init(contesntsOf: url) 메소드는 동기적으로 작동해 현재 작업중인 스레드의 모든 작업을 해당 작업을 수행하는 동안 멈추게할 위험이 있어 
  DispatchQueue.global().async를 통해 스레드 문제를 해결해도 GCD의 제한된 작업스레드 중 하나를 묶는 것이 되어 직접적이진 않아도 
  간접적으로 성능에 영향을 줄 수 있어 권장하지 않음

→ URLSession에서는 오류가 네트워크 오류인지, HTTP 오류인지, contents 오류 인지 등을 판할 수 있는 반면 
  init(contentsOf:)에서는 이를 확인할 수 없음

→ URLSession으로 변경
```

<br>

- Cell 재사용 문제
    - TableView Cell 재사용으로 인해 스크롤 시 이미지가 맞지 않는 경우 발생
    - prepareForReuse() 메소드를 사용해 수정

```swift
override func prepareForReuse() {
		profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
}
```
<br>

## 💼 리팩토링

- 

```swift

```

```swift

```

<br>

- 

```swift

```
