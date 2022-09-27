#  Meduman


- Structure
    - Data
        - Utility
            - Extensions
            - Helpers
                - Constant
                - NetworkError
                - FirebaseError
                - DatabaseError
        - Firebase
            - AuthRepo
            - FirestoreRepo
        - Health
            - HealthRepo
        - Notification
            - Local-NotificationRepo
            - Push-NotificationRepo
        - Networks
            - HealthInfoNetworkServiceRepo
            - Covid19NetworkServiceRepo
        - DataBase
            - CoreDataRepo
            - KeychainRepo
            - UserDefaultRepo
            - RealmRepo
        
    - Domain
        - Utility
            - Extensions
            - Helpers
                - Constant
        - Entity
            - User
            - Record
            - Reminder
        - Use Cases
            - UserAuthUseCase
            - UserProfileUseCase
            - HealthRecordUseCase
            - ReminderUseCase

    - Presentor(MVVM)
        - Utility
            - Helpers
                - Constant
                - Formatter
        - Auth
            - Views
                - View
                - ViewModel
        - Record
            - Views
                - View
                - ViewModel
        - Reminder
            - Views
                - View
                - ViewModel
                
-------------------------------------------------------------------

- Design Patterns
    - MVVM
    - Singleton
    - Dependency Injection
    
-------------------------------------------------------------------
