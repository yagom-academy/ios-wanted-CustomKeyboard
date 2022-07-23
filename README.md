# iOS-CustomKeyboard
- 원티드 프리온보딩 1기 두 번째 과제
- 서버 API를 활용한 리뷰 목록 가져오기 및 새로운 리뷰 작성
- 한글 오토마타 알고리즘을 활용한 한글 쿼티 키보드 구현
- Custom Keyboard Extension을 Custom Keyboard를 Safari, Message 등에서 사용 가능



# 팀원
|monica|숭어|
|--|--|
|[<img src="https://user-images.githubusercontent.com/66169740/177245353-2c07bcd1-ffee-4d2d-923b-f1867aba606d.png" width="200">](https://github.com/3dots3craters)|[<img src="https://avatars.githubusercontent.com/u/31765530?v=4" width="200">](https://github.com/hhhan0315)|
|한글 오토마타 구현|API 통신 및 Keyboard Extension 구현|



# 개발환경
![개발1](https://img.shields.io/badge/iOS-13.0+-silver)



# 다이어그램
<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/diagram.png">

# 한글 입력 처리 방식
![무제6](https://user-images.githubusercontent.com/66169740/180589919-5d9604db-5a9d-476e-91bc-eb93d20fc1a7.png)



# 기능
## 첫 번째 화면
|리뷰 목록 표시|리뷰 작성|
|--|--|
|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면1_1.gif" width="220">|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면1_2.gif" width="220">|
## 두 번째 화면
|한글 조합, Shift, Back, Space|겹받침, 이중모음, ㅠ + ㅣ|
|--|--|
|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면2_1.gif" width="220">|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면2_2.gif" width="220">|
## 추가 기능
|Custom Keyboard (홈버튼 모델)|Custom Keyboard|
|--|--|
|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면3_1.gif" width="220">|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/화면3_2.gif" width="220">|



# 회고
## monica
### 한글 오토마타 리팩토링
#### 초기 버전 
- 초기에는 다른 블로그의 한글 오토마타 설명을 참고하여 단일 클래스로만 한글 오토마타를 구현
- 클래스 내 메서드 간 의존성이 높아 일부분을 수정하려고 해도 전체적인 수정이 필요
#### 1차 리팩토링 
- 기존 클래스가 가졌던 프로퍼티를 분리하여 각각의 프로퍼티를 관리하는 Manager 클래스 생성
- 기존 프로퍼티 목록 
	- 지금까지 입력된 문자들의 유니코드값을 저장하는 배열
	- 지금까지 입력된 문자들의 상태(ex. 초성, 중성, 종성 등)를 저장하는 배열
	- 지금까지 입력된 문자들 중 당장 조합을 위해 필요한 문자들을 저장하는 배열
	- 조합된 문자들을 저장하는 배열
- 다른 클래스로 흩어진 프로퍼티들을 여전히 모든 메서드가 필요로 해서 클래스 분리의 효과가 미미
- `ㅗ` + `ㅏ` + `ㅣ` → `ㅙ` 와 같은 특이케이스를 기존의 방식을 고수하여 처리할 경우, 코드의 복잡도가 너무 높아질 것으로 예상
#### 2차 리팩토링
입력 문자와 관련된 정보 저장 방식 변경
|기존 방식|새로운 방식|
|---|---|
|한 `배열`에 유니코드값만 저장, 다른 배열에 상태값만 저장|하나의 `연결리스트`에 유니코드값, 상태값 등의 정보를 가진 Hangeul 인스턴스로 저장|
- 메서드 중에는 앞서 입력된 문자와 현재 입력된 문자가 어떤 상태, 유니코드값을 가졌는지 필요로 하는 메서드가 많다. 
- 경우에 따라 필요로 하는 문자의 수가 달라져 메서드 파리미터를 정하는 데 어려움이 있다. 
- 때문에 기존 방식에서 이를 처리하는 것은 상당히 복잡한 코드를 초래했다. 
- 하지만 새 방식으로는 현재 입력된 Hangeul 인스턴스 하나만 파라미터로 넘김으로써 손쉽게 이전 입력 문자의 정보를 확인할 수 있게 되었다.

문자의 조합 상태
|기존 상태 목록|새로운 상태 목록|
|---|---|
<br>

## 숭어
### 테이블뷰 셀에 올바른 이미지가 나타나지 않는 문제
|원인|해결|
|--|--|
|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/숭어_이미지뷰_원인.gif" width="220">|<img src="https://github.com/hhhan0315/ios-wanted-CustomKeyboard/blob/main/스크린샷/숭어_이미지뷰_해결.gif" width="220">|
- 빠르게 스크롤할 경우 해당 cell에 알맞는 이미지가 나타나지 않는 문제 발생
- 지나간 cell 부분의 작업은 취소 기능 구현 필요
- LazyImageView인 custom UIImageView 구현 및 변수로 URLSessionDataTask를 가지고 있으며 cell 재사용 중 해당 부분 작업이 존재한다면 cancel 처리
- 빠르게 스크롤 -> 작업 존재 여부 확인 -> 있다면 작업 취소 -> 캐시에 이미지 존재 여부 확인 -> 없다면 작업 할당 및 시작

### 네트워크 파일 분리
- 기존에는 네트워크 매니저 하나의 파일에 구현
- 네트워크 요청에 따라 알맞는 메서드를 매번 따로 구현

```swift
class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func downloadReview(completion: @escaping (ReviewResponse) -> Void) {
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {
	    return
	}

	URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
	    guard let data = data else {
	        return
	    }
	    
	    do {
	        let result : ReviewResponse = try JSONDecoder().decode(ReviewResponse.self, from: data)
		completion(result)
	    } catch(let error) {
		print(error.localizedDescription)
	    }
	}.resume()
    }
}
```

- 4개의 파일로 분리
- `HTTPMethod` : HTTP Method 문자열 관리해주는 객체
- `Endpoint` : 호스트명과 path를 가지는 urlString, header parameter, query parameter, body를 가지며 URLRequest를 return해주는 객체
- `APIEndpoints` : 필요한 API 주소에 따라 Endpoint 생성
- `NetworkManager` : URLRequest와 Generic dataType을 이용해 네트워크 요청 후 해당 데이터를 dataType에 맞게 decode한 후에 리턴
- 필요한 주소를 APIEndpoints에서 메서드로 정의한 이후에 해당 Endpoint를 NetworkManager에서 활용해 네트워크 처리할 수 있도록 처리

### Mock을 이용한 Network Test
- 참고
  - https://techblog.woowahan.com/2704/
  - https://sujinnaljin.medium.com/swift-mock-을-이용한-network-unit-test-하기-a69570defb41
- `Mock` : 호출에 대해 예상하는 결과를 받을 수 있을도록 미리 정의한 객체
- 실제 네트워크를 호출해야 하는 테스트는 네트워크 상황에 따라 달라질 수 있고 시간이 많이 걸릴 수도 있다.
- Swift protocol을 사용해 MockURLSession을 이용해 테스트 진행
- `URLSessionProtocol` : URLSession의 dataTask와 동일한 메서드 선언
- `URLSessionDataTaskProtocol` : resume 메서드
- `NetworkManager` : 생성 시 URLSessionProtocol 주입
```swift
func test_fetchData_Data가_존재하며_statusCode가_200일때() {
    // MockURLSession에서 테스트하기 위해 data, statusCode 지정
    let mockURLSession = MockURLSession.make(url: endpoint.url()!, data: data, statusCode: 200)
    
    // sut(systemUnderTest) : 테스트할 클래스
    // URLSessionProtocol 주입할 수 있어서 mockURLSession으로 초기화 가능
    let sut = NetworkManager(session: mockURLSession)
    
    // data가 존재하고 dataType도 올바르기 때문에 성공할 것이고 decode 이후 ReviewResponse return
    var result: ReviewResponse?
    sut.fetchData(endpoint: endpoint, dataType: ReviewResponse.self) { response in
        if case let .success(reviewResponse) = response {
            result = reviewResponse
        }
    }
    
    // 예상값은 미리 저장해둔 data를 ReviewReponse로 decode
    let expectation: ReviewResponse? = try? JSONDecoder().decode(ReviewResponse.self, from: data)
    
    // 결과와 예상값 비교
    XCTAssertEqual(result?.data.count, expectation?.data.count)
    XCTAssertEqual(result?.data.first?.content, result?.data.first?.content)
}
```
- MOCKURLSession.make()를 통해 원하는 네트워크 상태를 정의하고 에러가 발생할 때도 확인해볼 수 있다.
- 테스트코드를 한번 경험해본다는 의미로 작성해봤으며 protocol을 사용해 테스트할 Mock, 실제 URLSession도 가능하다는 것이 신기했다.


# 개발 과정
- [노션 주소](https://broken-redcurrant-2ce.notion.site/315a86cbbca5496aa26fe869fad87ec0)
