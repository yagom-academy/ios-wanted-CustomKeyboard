# iOS-CustomKeyboard
- 원티드 프리온보딩 1기 두 번째 과제
- 서버 API를 활용한 리뷰 목록 가져오기 및 새로운 리뷰 작성
- 한글 오토마타 알고리즘을 활용한 한글 쿼티 키보드 구현
- Custom Keyboard Extension을 Custom Keyboard를 Safari, Message 등에서 사용 가능

<br>

# 팀원
|monica|숭어|
|--|--|
|[<img src="https://user-images.githubusercontent.com/66169740/177245353-2c07bcd1-ffee-4d2d-923b-f1867aba606d.png" width="200">](https://github.com/3dots3craters)|[<img src="https://avatars.githubusercontent.com/u/31765530?v=4" width="200">](https://github.com/hhhan0315)|

<br>

# 개발환경
![개발1](https://img.shields.io/badge/iOS-13.0+-silver)

<br>

# 다이어그램
- 사진

<br>

# 기능
## 첫 번째 화면
|리뷰 목록 표시|리뷰 작성|
|--|--|
|||
## 두 번째 화면
|한글 조합, Shift, Back, Space|특수한 경우|
|--|--|
|||
## 추가 기능
|Custom Keyboard (홈버튼 모델)|Custom Keyboard|
|--|--|
|사진|사진|

<br>

# 담당

<br>

# 회고
## monica

<br>

## 숭어
### 테이블뷰 셀에 올바른 이미지가 나타나지 않는 문제
|원인|해결|
|--|--|
|gif|gif|
- 빠르게 스크롤할 경우 해당 cell에 알맞는 이미지가 나타나지 않는 문제 발생
- 지나간 cell 부분의 작업은 취소 기능 구현 필요
- LazyImageView인 custom UIImageView 구현 및 변수로 URLSessionDataTask를 가지고 있으며 cell 재사용 중 해당 부분 작업이 존재한다면 cancel 처리
- 빠르게 스크롤 -> 작업 존재 여부 확인 -> 있다면 작업 취소 -> 캐시에 이미지 존재 여부 확인 -> 없다면 작업 할당 및 시작

### 네트워크 파일 분리
- 기존에는 네트워크 매니저 하나의 파일에 구현
- 네트워크 요청에 따라 알맞는 메서드를 따로 구현

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

- 이후에 5개의 파일로 분리
- `HTTPMethod` : HTTP Method 문자열 관리해주는 객체
- `Endpoint` : 호스트명과 path를 가지는 urlString, header parameter, query parameter, body를 가지며 URLRequest를 return해주는 객체
- `APIEndpoints` : 필요한 API 주소에 따라 Endpoint 생성
- `Provider` : Endpoint를 활용해 URLRequest를 만들고 NetworkManager에 요청 후 해당 Data를 decode한 이후 return
- `NetworkManager` : URLRequest를 이용해 Result<Data, Error> return
- 필요한 주소를 APIEndpoints에서 메서드로 정의한 이후에 해당 Endpoint를 Provider에서 활용해 네트워크 처리할 수 있도록 처리

# 개발 과정
- 노션 주소
