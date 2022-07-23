# ⌨️ CustomKeyboard

## 👨‍👩‍👦‍👦 팀원 소개

| <center>**Ravi**</center>   | <center>**에리얼**</center> |
| -------------------------------------------------------- | --------------------------------------------------------- |
| [<img src="https://github.com/zoa0945.png" width="200">](https://github.com/zoa0945) |  [<img src="https://github.com/BAEKYUJEONG.png" width="200">](https://github.com/BAEKYUJEONG)| 

<br>

## 🖥 프로젝트 소개
### **상품 리뷰를 확인하고, 한글 오토마타 구현 키보드로 리뷰를 입력하는 APP** 

- 첫 화면에서 상품 Review List 확인
- 리뷰 작성칸을 눌러 리뷰 작성 페이지로 진입
- 리뷰 작성 페이지에서 작성 후, return 버튼을 누르면 첫 화면의 리뷰 작성칸에 작성 내용 표기
- 작성 버튼을 누르면 Review List에 추가
- 한글 오토마타 구현의 Custom Keyboard
- 어느 페이지에서나 쓸 수 있는 Custom Keyboard Extension


<br>

## ⏱️ 개발 기간 및 사용 기술

- 개발 기간: 2022.07.11 ~ 2022.07.23 (2주)
- 사용 기술:  `UIKit`, `URLSession`, `NSCache`, `Custom Keyboard Extension`, `delegatePattern`, `MVVM`

<br>

## 📌 핵심 기술

- 리뷰 목록 리스트 구현

- 리뷰 작성 시간 구현

- Network Layer 분리

- 한글 입력 오토마타

- 한글 삭제 오토마타

- Shift 기능 구현

- Space 기능 구현 및 지움 로직 

- Keyboard Extension 구현

<br>

## ✏️ 한글 입력, 삭제 로직

- 한글 입력
  TextView의 마지막 텍스트와 그 텍스트의 상태를 받아와 입력된 텍스트를 합치거나 이어붙여 완성된 텍스트와 그 상태를 반환
  -> 반환된 텍스트를 뷰컨트롤러에서 TextView에 이어붙여 완성
  -> space가 입력되면 이전 상태와 상관없이 공백을 반환하여 이어붙임

- 텍스트의 상태 (state)

      0: 아무것도 입력되어있지 않거나 space가 입력된 이후의 상태
      	-> 입력된 텍스트와 그 상태를 그대로 반환
  

      1: 초성(자음)만 입력되어 있는 상태
      	-> 입력된 텍스트가 자음인 경우 쌍자음으로 변환 가능한지 확인 후
      		변환 가능하다면 쌍자음을 반환 (ex ㄱ + ㄱ = ㄲ, ㅂ + ㅂ = ㅃ, ㅅ + ㅅ = ㅆ),
      		변환 불가능하면 입력된 텍스트를 이어붙여 반환 (ex ㅇ + ㅇ, ㅁ + ㅅ)
      	-> 입력된 텍스트가 모음인 경우 자음 + 모음으로 완성된 텍스트와 그 상태를
      		반환 (ex ㅇ + ㅑ, ㅎ + ㅗ)
  
  
      2: 중성(모음)만 입력되어 있는 상태
        -> 입력된 텍스트가 자음인 경우 입력된 텍스트를 이어붙여 반환
        (ex ㅗ + ㅎ, ㅑ + ㅇ)
        -> 입력된 텍스트가 모음인 경우 모음이 합쳐질 수 있는지 확인 후 합칠 수
      		있다면 합친 모음을 반환 (ex ㅏ + ㅣ = ㅐ, ㅗ + ㅐ = ㅙ), 합칠 수 없다면
      		입력된 텍스트를 이어 붙여 반환 (ex ㅏ + ㅗ, ㅐ + ㅣ)

  
      3: 초성 + 중성이 입력되어 있는 상태
      	-> 입력된 텍스트가 자음인 경우 자음 + 모음 + 자음으로 완성된 텍스트와 그
      		 상태를 반환 (ex 아 + ㄴ, 왜 + ㅇ)
      	-> 입력된 텍스트가 모음인 경우 이전 텍스트의 모음과 합쳐질 수 있는지 확인
       		 후 합칠 수 있다면 합친 텍스트를 반환 (ex 와 + ㅣ = 왜, 도 + ㅣ = 되), 합칠 수
       		 없다면 입력된 텍스트를 이어붙여 반환 (ex 이 + ㅗ, 하 + ㅜ)

  
      4: 초성 + 중성 + 종성이 입력되어 있는 상태
        -> 입력된 텍스트가 자음인 경우 종성이 겹받침 또는 쌍자음받침이 될 수
       		 있는지 확인 후 가능하면 수정된 글자를 반환 (ex 발 + ㅂ = 밟, 일 + ㄱ = 읽),
       		 불가능 하다면 입력된 텍스트를 이어 붙여 반환 (ex 앆 + ㄱ, 밥 + ㅁ)
        -> 입력된 텍스트가 모음인 경우 종성을 초성으로 이동시킨 후 완성된 글자를
       		 이전 텍스트와 이어붙여 반환 (ex 얗 + ㅗ = 야호, 멜 + ㅗ = 메로)


- 한글 삭제
TextView의 마지막 텍스트와 그 상태를 받아와 가장 마지막에 입력된 텍스트를 삭제 후 해당 텍스트와 그 상태를 반환
-> 반환된 텍스트를 뷰컨트롤러에서 TextView에 이어붙여 완성
-> space를 입력한 후 삭제하면 한 글자씩 삭제

- 텍스트의 상태 (state)

      0: 아무것도 입력되어있지 않거나 space가 입력된 이후의 상태
      	-> 아무것도 입력되어 있지 않은 경우 빈 문자열을 반환
  

      1: 초성(자음)만 입력되어 있는 상태
      	-> 쌍자음이 아닌경우 해당 문자를 삭제 후 반환
      	-> 쌍자음의 경우 입력할때 자음을 두번 입력했는지 shift + 자음으로
       		 입력했는지 확인 후 자음을 두번 입력한 경우 자음 하나만 삭제 후 반환
       		 (ex ㄲ (ㄱ+ㄱ) -> ㄱ, ㅃ (ㅂ+ㅂ) -> ㅂ)
  
  
      2: 중성(모음)만 입력되어 있는 상태
      	-> 두개의 모음이 합쳐진 것인지 확인 후 합쳐졌다면 마지막에 입력된 모음만
       		 삭제 후 반환 (ex ㅐ(ㅏ+ㅣ) -> ㅏ, ㅙ (ㅘ +ㅣ) -> ㅘ)
      	-> 합쳐져있지 않다면 해당 텍스만 삭제 후 반환
  
  
      3: 초성 + 중성이 입력되어 있는 상태
      	-> state가 3인 경우에만 TextView의 마지막 두글자를 받아와 진행
      	-> 중성 삭제 후 초성이 앞글자의 종성으로 들어갈 수 있는지 확인 후
       		 가능하다면 앞글자의 종성으로 넣은 뒤 해당 글자를 반환
       		 (ex 아니 -> 안, 이게 -> 익), 불가능 하다면 앞글자에 남은 초성을 이어붙여 반환 (ex 홓호 -> 홓ㅎ, 싫다 -> 싫ㄷ)
  
  
      4: 초성 + 중성 + 종성이 입력되어 있는 상태
      	-> 종성이 겹받침이거나 따로 입력된 쌍자음 받침(“ㄱㄱ”, “ㅂㅂ”)의 경우
       		 마지막에 입력된 자음만 삭제 후 반환 (ex 읽 -> 일, 겠 -> 겟), shift + 자음으로
       		 입력된 쌍자음 받침 또는 일반 자음받침의 경우 종성을 삭제 후 반환
       		 (ex 일 -> 이, 겟-> 게, 했 -> 해)


<br>

## 💼 리팩토링

- Network Layer 나누기- HTTPMethod, EndPoint, Request, APIError, URLSession+
  \- URLSession+에서 dataTask와 uploadTask를 func으로 재정의해주고 사용 

```swift
extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    // ...
}
```

```swift
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(Result<T, APIError>) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.failed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(.failure(.unexpectedStatusCode(statusCode: "\(response.statusCode)")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(.success(userData))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
```

<br>

- Generic을 이용한 POP(Protocol Oriented Programming)
  

```swift
protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type) where T: ReusableCell {
        self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: headerFooterType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}
```

```swift
extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
  // ...
  
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: ReviewTableViewCell.self, indexPath: indexPath)
        // ...
   }
}
```

```swift
extension ReviewViewController {
    private func attribute() {
        // ...
        reviewTableView.register(cellType: ReviewTableViewCell.self)
        reviewTableView.register(headerFooterType: ReviewTableViewHeader.self)
    }
    // ...
}
```

<br>

## 📱 UI

| 리뷰 리스트 | 작성 뷰 진입 및 키보드 입력 | 키보드 삭제 | 리턴 및 작성 |
| :----: | :----: | :----: | :----: |
| ![Simulator Screen Recording - iPhone 12 mini - 2022-07-23 at 12 00 48](https://user-images.githubusercontent.com/48586081/180588374-f95fb996-8f16-4c4c-a8bb-20f86637baa0.gif) | ![Simulator Screen Recording - iPhone 12 mini - 2022-07-23 at 12 03 00](https://user-images.githubusercontent.com/48586081/180588384-482901bc-1ac5-4f64-8afa-b431357ec847.gif) | ![Simulator Screen Recording - iPhone 12 mini - 2022-07-23 at 12 06 40](https://user-images.githubusercontent.com/48586081/180588391-994b6396-58ac-4a7d-a1b6-1cb58ec73ab8.gif) | ![Simulator Screen Recording - iPhone 12 mini - 2022-07-23 at 12 25 03](https://user-images.githubusercontent.com/48586081/180588910-3ba4bcdf-a802-4851-b58c-b08b6918699d.gif) |
