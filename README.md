# FilmAt (iOS 15.0+) 🎥

> 손 끝에서 만나는 영화의 모든 것, FilmAt.

## 🎥 소개

> 서비스 소개
>
> - [TMDB API](https://developer.themoviedb.org/docs/getting-started)를 활용해 영화를 탐색하고 저장하며 풍부한 정보를 제공하는 영화 정보 앱입니다.
>
> 개발 인원
>
> - 1인 프로젝트
>
> 개발 기간
>
> - 2025.01 - 2025.02 (9일, 1인)

## 🎥 Made by

<div align=left>

| <img width="200px" src="https://avatars.githubusercontent.com/u/114901417?v=4"/> |
| :------------------------------------------------------------------------------: |
|                     [박신영](https://github.com/ParkSY0919)                      |
|                                       1인                                        |

</div>

## 🎥 기능

- 프로필 닉네임, 이미지, MBTI 설정 및 수정
- 영화 좋아요 표시
- 당일 유행 영화 목록 조회
- 영화 검색
- 영화 상세정보(줄거리, 표지, 포스터, 캐스트) 조회
- 최근 검색어 저장

//사진영역

## 기술 스택 및 내용

> Framework: `UIKit`
>
> Architecture: `MVVM`
>
> Design Patterns: `API Router`, `DI/DIP`, `Input-Output`
>
> Reactive Programming: `Custom Observable Pattern`
>
> Library: `Alamofire`, `Kingfisher`, `Snapkit`, `Then`

- ViewModel의 Input 및 Output 구조체와 Observable을 활용, 단방향 데이터 플로우를 구축하여 데이터 흐름의 명확성 및 예측 가능성을 확보했습니다. 예시로 SearchViewModel에서 lazyBind/bind 메서드를 통해 복잡한 상태 관리를 상황에 맞는 UI 업데이트가 가능하도록 구현하였습니다.
- ViewModel 내 클로저(likedMovieListChange, onChange 등)를 Delegate 패턴 형태로 활용하여 화면 간 데이터 변경 시 실시간 동기화를 구현, 사용자 경험의 일관성 및 코드 유연성을 향상시켰습니다.
- UIKit 기반 컴포넌트에서 버튼 상태(활성/비활성, 선택/비선택)에 따른 동적 UI 업데이트에 활용하여 인터랙티브한 UI를 제공합니다.
- UserDefaults 접근 로직을 싱글톤 패턴의 UserDefaultsManager로 추상화하여, 반복 코드 감소 및 데이터 저장/조회 로직의 명확성과 일관성을 확보했습니다.
- NetworkManager 및 TMDBTargetType enum에 Router 패턴과 Generic을 적용, Alamofire 기반 네트워크 요청 코드의 추상화 및 재사용성을 극대화하여 API 엔드포인트 관리와 다양한 응답 타입 처리를 효율화했습니다.
- TMDBTargetType의 parameters에서 Encodable 모델 객체를 직접 전달하는 구조(RequestParams?.query(request))를 통해, 모델 변경 시 파라미터 생성 코드 수정 최소화 및 API 요청의 유연성을 확보했습니다.
- tableView(_:prefetchRowsAt:) 및 tableView(_:willDisplay:forRowAt:) 델리게이트와 Observable(isCallPrefetch)을 연동, 스크롤 기반의 자연스러운 데이터 프리페칭 및 페이지네이션을 구현하여 끊김 없는 콘텐츠 탐색 경험을 제공했습니다.

<br>
