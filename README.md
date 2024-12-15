# ✏️ 24-25 App Assignment 09

### 📑  API 이용해 게시판 만들기

### 🗣️ 과제 설명

9차시에 학습한 로그인 및 기본 CRUD 관련 과제입니다. 강의자료에 첨부되어있는 Swagger를 이용해 , 간단한 게시판을 만들어봅니다. 강의 자료를 참고하여, 구현하시면 됩니다. 

⇒ 민감한 정보를 담고 있는 데이터들은(ex. accessToken) .gitignore에 등록해 관리해주세요.

> UI는 예시 자료와 동일하지 않게 하여도 됩니다. 아래 필수 요구 사항만 만족해주세요. 아래 필수 요구 사항, 선택 요구 사항에 맞춰 구현해주시면 됩니다. API 문서에 들어가 해당 API, Response body 값 확인 가능합니다. 추가적으로 App 부가자료실에 확인 관련으로 올려두겠습니다. 과제하다 모르시는 분들은 참고하시길 바랍니다. 

*cf.  통신 URL은 세션 자료를 참고하면 됩니다.*
> 








### ✔️ 필수 요구 기능

- Login / Signup
    - 회원가입 기능
        - ID(본인 이름), Password을 입력해 회원가입 로직을 구현
    - 로그인 기능
        - 세션 자료 참고해 로그인 기능 구현
        
        → validation도 같이 구현
        
        [](url)![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 04 58 09](https://github.com/user-attachments/assets/d644aea5-2eff-449b-aba0-8bf698cf75f8)
        
- Board
    - BoardList
        - 기능
            - 게시판의 전체 조회 기능
            ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 05 01 23](https://github.com/user-attachments/assets/7037b420-2f1c-4d04-96ef-8e5418a24607)
            - 게시물 추가 기능
            
            ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 04 59 55](https://github.com/user-attachments/assets/e4a2709c-a1f7-458a-b3c0-9d63504b46ef)
            
    - BoardDetails
        - 기능
            - 게시물의 상세 조회 기능
                
            
          


            - 게시물 수정 기능
                ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 05 01 14](https://github.com/user-attachments/assets/7df217b5-8a4b-464e-acac-dced0ecd6e45)
            
            - 게시물 삭제 기능

### 👏🏻 선택 요구 사항

- 폴더 구조 나누기
    - MVC, MVVM  패턴에 대해 알아보세요 ! 그리고 해당 프로젝트에 MVC, MVVM을 적용시켜 구조화 해보세요 😊
- `Navigator`가 아닌 `goRouter` 사용

---

### ‼️ 과제 제출 관련

레포지토리 `fork`를 통해 과제를 수행하셔야 합니다. (AIOS 때 진행한 fork 방식과 동일 노션에 추가자료란에 첨부되어있습니다.) 과제에 대한 코드를 작성하시고, `Pull Request(PR)`를 작성해주시면 됩니다. PR 작성하실 때, 궁금한 점이나 어려웠던 점 등을 적어주세요. 그리고 **구현한 UI 사진도 같이 첨부해주세요.**
과제 제출 마감 기한은 **11월 31일 23:59**까지입니다.