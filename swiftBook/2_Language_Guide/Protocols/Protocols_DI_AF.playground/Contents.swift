
import UIKit
import HealthKit

//protocol DependencyFactory {
//    func makeHealthService() -> HealthService
//    func makeSettingsSevice() -> SettingsService
//}
//
//struct Dependencies {
//    private let healthStore: HKHealthStore
//    private let userDefaults: UserDefaults
//
//    init(
//        healthStore: HKHealthStore = .init(),
//        userDefaults: UserDefaults = .standard
//    ) {
//        self.healthStore = healthStore
//        self.userDefaults = userDefaults
//    }
//}
//
//extension Dependencies: DependencyFactory {
//    func makeHealthService() -> HealthService {
//        return HealthService(store: healthStore)
//    }
//
//    func makeSettingsSevice() -> SettingsService {
//        return Settings(defaults: userDefaults)
//    }
//}
