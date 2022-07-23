
# 👨‍👩‍👦‍👦 팀원 소개

| <center>UY</center>   | <center>우지</center> |
| -------------------------------------------------------- | --------------------------------------------------------- |
| [<img src="https://github.com/ScutiUY.png" width="200">](https://github.com/ScutiUY) |  [<img src="https://github.com/wooooozin.png" width="200">](https://github.com/wooooozin) 

<br>

* * *

# 🖥 프로젝트 소개
### **애플리케이션 설명**
- 서버 API를 이용하여 리뷰 목록을 가져오고, 새로운 리뷰를 작성이 가능합니다.
- 화면에 키보드 자판 버튼들을 배치해서, 누르면 한글 키보드처럼 조합되는 한글 쿼티 화면을 구현했습니다.
- Keyboard Extension을 이용하여 실제 한글 키보드를 만들어봅니다.

<br>

### 실행 화면
| <center> 앱 진입과 리뷰 목록 </center> | <center> 리뷰 작성 </center> | <center> 키보드 입력 </center> | <center> 리뷰 작성 완료와 포스팅 </center> | <center> 비어 있는 리뷰 경고 </center> |
| -------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| ![Simulator Screen Recording - iPhone 11 - 2022-07-23 at 12 24 23](https://user-images.githubusercontent.com/36326157/180588961-d7e1af82-85d4-4e90-bedd-b84729e0e0cc.gif) | ![Simulator Screen Recording - iPhone 11 - 2022-07-23 at 12 24 39](https://user-images.githubusercontent.com/36326157/180588975-ed485fac-46ea-48b2-adaa-c18d01e0c1d5.gif) | ![Simulator Screen Recording - iPhone 11 - 2022-07-23 at 12 25 12](https://user-images.githubusercontent.com/36326157/180588980-7cb18e71-4124-47c2-b599-463b62caf2c0.gif) | ![Simulator Screen Recording - iPhone 11 - 2022-07-23 at 12 59 06](https://user-images.githubusercontent.com/36326157/180589684-4344f094-fc45-4aa8-8180-9cbee13cdbcd.gif) | ![Simulator Screen Recording - iPhone 11 - 2022-07-23 at 12 34 43](https://user-images.githubusercontent.com/36326157/180589078-7a1f37a1-b506-43c3-a0e5-bb9ae3bba113.gif)
<br>

* * *

# ⏱️ 개발 기간 및 사용 기술

- 개발 기간: 2022.07.11 ~ 2022.07.23 (2주)
- 사용 기술:  `UIKit`, `URLSession`, `ExtensionKeyboard`, `NSCache`,  `MVC`

<br>

* * *

# 🖼 디자인 패턴
### MVVM? MVC?

- MVC를 선택한 이유

1. 규모가 크지 않은 프로젝트에서 보여줄 뷰의 수가 많지 않음

2. 기능의 직관적인 분리

3. 모듈화를 통한 VC의 책임 분산 -> 기존 MVC의 단점 해소

<br>

* * *

# 📌 핵심 기술

- ### 한글 키보드?

	영어와 한글의 차이 - 조합형인가 나열형인가?  
	=> 알고리즘을 만들어 조합하자!!


- ### Keyboard Automata
	핵심 - stage에 따른 조합
	

```Swift
struct HangulKeyboardData {
    
    enum HangulState: Int {
        case empty = 0
        case cho = 1
        case doubleCho = 2
        case jung = 3
        case doubleJung = 4
        case jong = 5
        case doubleJong = 6
    }
    
    var hangul: String = ""
    var unicode: Int = 0
    var bornState: HangulState = .empty
    
    ...
}
```
```Swift


switch processingBuffer.currentState {
        case .empty:
            processingBuffer = emptyStage(status: processingBuffer, input: inputData)
        case .cho:
            processingBuffer = singleChoStage(status: processingBuffer, input: inputData)
        case .doubleCho:
            processingBuffer = doubleChoStage(status: processingBuffer, input: inputData)
        case .jung:
            processingBuffer = singleJungStage(status: processingBuffer, input: inputData)
        case .doubleJung:
            processingBuffer = doubleJungStage(status: processingBuffer, input: inputData)
        case .jong:
            processingBuffer = singleJongStage(status: processingBuffer, input: inputData)
        case .doubleJong:
            processingBuffer = doubleJongStage(status: processingBuffer, input: inputData)
        }
```

```Swift

 func [음소별 스테이지] (현재 스테이지, 키보드 입력) -> 상태값[현재상태, 글자배열, 모드] {
 
 	...
 
        alphaRepository.append(들어온 키보드 데이터 추가)

        if 입력값이 초성인지 중성인지 종성인지 {
	
	...
	
	상태.모드 = 이중 자모 or 완료여부
	상태.스테이지 = 들어온 키보드 데이터에 따라 다음 이동 할 stage가 결정된다
	
	...
	
	}
            
        if 삭제 인지 {
	모드 = 삭제
	}
        return currentStatus
    }

```

<br>

* * *

# 📖 DataFlow

![CustomKeyboard](https://user-images.githubusercontent.com/36326157/180591790-8a0e5138-953d-4d5f-8340-706dfbdc0683.jpg) 

<br>

* * *

# ⚠️ 이슈

- ### URLSession Network Layer에 관한 고민
    
```Text
→ 네트워크 관련 라이브러리를 사용하지 않을 때 효율적인 network layer를 만들 수 있을지에 대한 고민과 에러 및 예외 처리에 대한 고민
→ 여러 시도 후 URL, NetworkError, HTTPMethod, URLSession, URLRequest, API, Resource 등으로 나누어 구현
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

- ### Data(contentsOf: url?)에 관한 고민

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

- ### Cell 재사용 문제
    - TableView Cell 재사용으로 인해 스크롤 시 이미지가 맞지 않는 경우 발생
    - prepareForReuse() 메소드를 사용해 수정

```swift
override func prepareForReuse() {
		profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
}
```
<br>

- ### 키보드 익스텐션 - textDocumentProxy
```Text
대부분의 외국어는 글자를 조합하는게 아닌 나열 하는 형식이다. 
UIInputViewContoller의 textDocumentProxy는 키보드의 글자를 입력 받아 UIKeyInput 프로토콜에서 제공하는 inserText 메서드를 통해 저장한다.
이 때문에 직접적인 text저장소에 접근은 불가하며, 오로지 insert 또는 delete만 가능하다.
때문에 기존 text를 새로 만든 text로 대체하던 방식의 오토마타로 keyboard extension을 구현할 경우 text가 중복되어 쌓이는 현상이 발생 했다.

- 해결

오토마타를 이에 맞게 수정하여 키보드를 입력 받을때 마다 이에 맞게 기존에 있는 글자를 지우고 새로운 글자를 삽입 해줄 수도 있지만, 
textDocumentProxt의 hasText를 통해 글자를 지운후 출력 되는 text를 다시 삽입해주는 방식을 채택했다.
```
```swift
while textDocumentProxy.hasText {
            textDocumentProxy.deleteBackward()
        }
```

![Simulator Screen Recording - iPhone 11 Pro - 2022-07-22 at 17 48 37](https://user-images.githubusercontent.com/36326157/180401710-8c08d463-f788-4a96-9a70-f86ea4b109e7.gif)   ![Simulator Screen Recording - iPhone 11 Pro - 2022-07-22 at 17 52 29](https://user-images.githubusercontent.com/36326157/180402430-19b534ff-845f-498c-b73e-d082a13bbf02.gif)

<br>

- ### 키보드 오토마타 : 삭제 기능
```Text
오토마타의 기존 배열에서의 종성과 이중종성을 구별할 수 없어 삭제에 어려움을 겪고 있던 도중 모든 음소를 저장 할 배열을 하나 더 추가하여
완성된 한글을 분해하여 비교를 통해 해결 하였다.
```  
[한글 오토마타 구현 코드] [https://github.com/ScutiUY/ios-wanted-CustomKeyboard/blob/fix/automata/CustomKeyboard/Hangul/KeyboardMaker.swift](https://github.com/ScutiUY/ios-wanted-CustomKeyboard/blob/develope/CustomKeyboard/Hangul/KeyboardMaker.swift)



<br>

* * *

# 💼 리팩토링

- 이미지로더 Data(contentsOf: url?) → URLsession 으로 변경

```swift
// 변경 전
if let data = try? Data(contentsOf: imageUrl) {
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: imageUrl.lastPathComponent as NSString)
                DispatchQueue.main.async {
                    complition(.success(image))
								} else {
                DispatchQueue.main.async {
                    complition(.failure(ImageLoaderError.noImage))
								}
```

```swift
// 변경 후
guard let imageUrl = URL(string: url) else { return }
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: imageUrl) { data, response, error in
                if let error = error {
                    completion(.failure(NetworkError.networkError(error)))
                } else {
								guard let httpResponse = response as? HTTPURLResponse else { return }
                guard 200..<300 ~= httpResponse.statusCode else { completion(.failure(SevericeError.noReponseError))
                    return
                }
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    ImageLoder.imageCache.setObject(image, forKey: url as NSString)
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.invalidData))
                    }
                }
```

<br>

- UIImage 관련 string → enum Type 으로 관리 및 변경

```swift
// 변경 전
profileImageVIew.image = UIImage(systemName: "person.crop.circle.fill")
// 변경 후
profileImageVIew.image = Icon.personFill.image
```

<br>

- 리뷰 시간변환 Cell에서 구현 → Class 객체 및 데이터모델에서 변경

```swift
// 변경 전
// ReviewTableViewCell.swift
guard let reviewDate = data.createdAt.stringToDate else { return }
        if reviewDate > Date(timeIntervalSinceNow: -86400) {
            timeLabel.text = reviewDate.dateToRelativeTimeString
        } else {
            timeLabel.text = reviewDate.dateToOverTimeString
        }

```

```swift
// 변경 후
// ReviewDateConverter.swift
class ReviewDateConverter {
    
    func convertReviewDate(rawData: String) -> String {
        if rawData.stringToDate ?? Date() > Date(timeIntervalSinceNow: -86400) {
            return rawData.stringToDate?.dateToRelativeTimeString ?? rawData
        } else {
            return rawData.stringToDate?.dateToOverTimeString ?? rawData
        }
    }
}

// ReviewData.swift
let date = try values.decode(String.self, forKey: .createdAt)
createdAt = ReviewDateConverter().convertReviewDate(rawData: date)
```

