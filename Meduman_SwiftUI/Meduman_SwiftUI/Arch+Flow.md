#  Architect & Flow
-------------------------------------------------------

-Clean Architecture + MVVM-


Data
    - Firebase
        - FBAuthRepo
        - FBFirestoreRepo
    - HealthKit
        - HealthKitRepo
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
    
Domain
    - Entity
        - User
        - Record
        - Reminder
    
    - Use Cases
        - FirebaseManager
        - RecordManager
        - ReminderManager

Presentor(MVVM)

