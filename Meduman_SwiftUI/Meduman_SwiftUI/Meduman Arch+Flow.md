#  Meduman


- Structure
        
    - Data
        - User
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
                
    - Utility
        - Constant
        - NetworkError
        - FirebaseError
        - DatabaseError
        - Cunstructor
                
-------------------------------------------------------------------

- Design Patterns
    - MVVM
    - Singleton
    - Dependency Injection
    
-------------------------------------------------------------------
