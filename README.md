# MVVMi-iOS
Android, iOS 통합 아키텍쳐 샘플입니다.

Clean Architecture 기반의 MVVM + Interactor 로 구성하였습니다.

Android, iOS 통합 아키텍쳐로 Model, ViewModel, Interactor 레이어는 언어만 다를 뿐 동일한 로직을 사용하는 것이 목표입니다.

##

View 레이어는 각각의 플랫폼에 종속됩니다.

View 레이어를 제외한 각각의 레이어는 Interface로 참조됩니다.

이 Interface를 구현한 Mock or Stub을 통해 각각의 레이어에서 UnitTest가 이루어집니다.

현재 ViewModel, Interactor 레이어에 테스트가 구현되어 있습니다.

Swift버전에는 DI 라이브러리를 사용하지 않고 생성자를 통한 외부에서 직접 주입하도록 구현되어 있습니다.

##

코드는 지속 변경될 수 있습니다.

Android Code : https://github.com/magewr/MVVMi-Android
