# 원티드 iOS 프리온보딩(with 야곰아카데미) -  ⌨ CustomKeyboard App

## 개발 환경
  - xcode : Version 13.4.1 (13F100)
  - deployment Target : 14.0
 
# 목차
  1. [Team](#Team)
     1. [팀원 소개](#팀원-소개)
     2. [기여한 부분](#기여한-부분)
  2. [프로젝트 소개](#프로젝트-소개)
     1. [목표](#목표)
     2. [사용한 기술](#사용한-기술)
     3. [기능 소개](#기능-소개)
        - [App Flow](#App-Flow)
        - [Demo gif](#Demo-gif)
     4. [사용한 Pattern 소개](#사용한-Pattern-소개)
        - [MVVM Pattern](#MVVM-Pattern)
        - [Delegate Pattern](#Delegate-Pattern)
     5. [객체 역할 소개](#객체-역할-소개)
        - [View 관련](#View-관련)
        - [Manger 관련](#Manger-관련)
  3. [고민한 부분](#고민한-부분)
  4. [회고](회고)
  
---

# Team
## 팀원 소개 

| 오얏                       | 커킴                            | 
| ---------------------------- | -------------------------------- |
| [<img src="https://github.com/iclxxud.png" width="200">](https://github.com/iclxxud)|[<img src="https://github.com/kirkim.png" width="200">](https://github.com/kirkim)|
| 개발 | 개발 |

## 기여한 부분

| 팀원 | 기여한 내용|
| ---------------------------- | -------------------------------- |
| 오얏 |- 개발1 <br />- 개발2 <br />|
| 커킴 |- 개발1 <br />- 개발2 <br />|

# 프로젝트 소개

## 목표
> 서버 API를 이용하여 리뷰 목록을 가져오고, 새로운 리뷰를 작성하는 커스텀 키보드 App    
> 화면에 키보드 자판 버튼들을 배치해서, 누르면 한글 키보드처럼 조합되는 한글 쿼티 화면을 구현합니다.
> 아이폰, 세로 모드만 지원하는 앱입니다.

## 사용한 기술
`MVVM Pattern` `Delegate Pattern` `Code-based UI`
  
## 기능 소개

### App Flow
  - all Flow
  <p float="none">
  <img src= "./images/AppFlow001.jpg" width="500" />
  </p>

### Demo Gif
  - ReviewList
  
   <p float="left">
  <img src= "./images/gif/home.gif" width="300"/>
</p>

  - ReviewWrite
  
   <p float="left">
  <img src= "./images/gif/record.gif" width="300"/>
</p>

## 사용한 Pattern 소개
### MVVM Pattern

<p float="none">
  <img src= "./images/CoordinatorPattern.png" width="1000" />
  </p>

### 1. MVVM 패턴을 사용한 이유
> 입력

### 2. 어떤 장점이 존재할까?
> 입력

### Delegate Pattern

<p float="none">
  <img src= "./images/DelegatePattern.png" width="1000" />
  </p>

### 1. 딜리게이트 패턴을 사용한 이유
> 입력
### 2. 어떤 장점이 존재할까?
> 입력

## 객체 역할 소개

### View 관련

| class / struct               | 역할                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| `SceneDelegate`         | - 입력  |
| `ReviewListView`           | - 입력1 <br />- 입력2 <br />- 입력3 |
| `ReviewWriteView`            | - 입력1 <br />- 입력2 <br />- 입력3 |

### Manger 관련

| class / struct               | 역할                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| `NetworkManager`         | - 어떤 객체인지 입력 <br />- 기능 입력 |
| `KeyboardEngine`      | - 어떤 객체인지 입력 <br />- 기능 입력 |

# 고민한 부분
## 오얏
- 
## 커킴
- 

# 회고
## 오얏
### 전체 회고
- 
### git 관련 회고
- 
### 기술 관련 회고
- 
### 협업 관련 회고
- 

## 커킴
### 전체 회고
- 
### git 관련 회고
- 
### 기술 관련 회고
- 
### 협업 관련 회고
- 
