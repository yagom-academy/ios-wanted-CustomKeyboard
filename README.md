
# 팀원 소개
||콩벌레|JMin|Kei|
|----|----|----|----|
|팀원|<img src = "https://avatars.githubusercontent.com/u/58679737?v=4" height="150px">| <img src = "https://avatars.githubusercontent.com/u/87932687?v=4" height="150px">| <img src = "https://i.pinimg.com/564x/ab/77/b6/ab77b685812966df28f059748d354ec2.jpg" height="150px">|
|담당기술|- 한글 오토마타 구현<br/>- 공백/삭제/shift키 기능 구현<br/>- Code refactoring|- API 통신 기능 구현<br/>- Keyboard extension 구현<br/>- Code refactoring|- Keyboard layout 구현<br/>- XCTest 작성<br/>- Code refactoring|

&nbsp;

# 프로젝트 소개
- 서버 API를 이용하여 리뷰 목록을 가져오고, 새로운 리뷰를 작성할 수 있습니다
- 한글 오토마타 알고리즘을 활용하여 custom keyboard를 구현하였습니다
- Keyboard extension을 이용하여 custom keyboard를 safari나 iMessage 등에서 사용할 수 있습니다
<img src = "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/9b6fb980-1aa5-4694-b07a-96452875f995/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220720%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220720T063849Z&X-Amz-Expires=86400&X-Amz-Signature=2a172177cb8a0d7facb13dba52560c2c956079b0c3749f730919c890826f6c66&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject">


&nbsp;

# 구현화면
- 첫번째 화면
  - 서버 API에서 상품 리뷰 목록을 가져온 후 화면에 표시합니다
  - 댓글 작성 시간에 따라 1시간 이내: 분 단위 / 하루 이내 : 시간 단위 / 하루 이상 : 년월일을 표시합니다
  - 사용자가 리뷰를 작성한 후 작성 버튼을 누르면 서버 API로 POST 요청을 보내서 서버에 추가합니다
  - 리뷰 목록에 위에서 작성한 리뷰를 최상단에 표시합니다
  
  |목록에 서버 데이터 표시|새로 작성한 리뷰 목록에 업데이트|
  |:----:|:----:|
  |<img src ="https://user-images.githubusercontent.com/87932687/179905296-ff8d6479-072b-4215-b2df-143f00c8cbf7.gif" height="400px">|<img src = "https://user-images.githubusercontent.com/87932687/179905666-6b847a1e-7abf-40ec-9ec3-84da93356f8a.gif" height="400px">|
  
- 두번째 화면
  - 화면 하단에 배치된 키 버튼을 누르면 상단에 한글이 조립되어 표시됩니다
  - Shift 버튼을 눌러 쌍자음, 복합모음을 입력할 수 있습니다
  - Back 버튼을 눌러 조합중인 글자 중 한 음소만 지울 수 있습니다
  - Space 버튼을 눌러 공백을 추가할 수 있습니다 
  
  |한글조합/Shift/Back/Space 버튼 기능 구현|
  |:----:|
  |<img src = "https://user-images.githubusercontent.com/87932687/179907319-783d373d-a8ba-4233-af43-9f72702b7080.gif" height="400px">|
  
- 추가 기능
  - Keyboard extension을 활용하여 custom keyboard를 Safari, iMessage 앱에서 사용할 수 있습니다

|Custom Keyboard 사용하기|
|:----:|
|<img src = "https://user-images.githubusercontent.com/87932687/179905136-7becb0a3-ec36-41d9-ae15-9e00aeb9c480.gif" height="400px">|
