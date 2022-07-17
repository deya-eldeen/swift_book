
import UIKit
import HealthKit

protocol HasUserDefaults {
    var userDefaults: UserDefaults { get }
}

protocol HasUrlSession {
    var session: URLSession { get }
}

protocol HasHealthStore {
    var store: HKHealthStore { get }
}

protocol Batata {
    var lawz: String { get }
}

struct Dependencies: HasUserDefaults, HasUrlSession, HasHealthStore {
    let userDefaults: UserDefaults
    let session: URLSession
    let store: HKHealthStore

    init(
        userDefaults: UserDefaults = .standard,
        session: URLSession = .shared,
        store: HKHealthStore = .init()
    ) {
        self.userDefaults = userDefaults
        self.session = session
        self.store = store
    }
}

class ViewController: UIViewController {
    typealias Dependencies = HasUserDefaults & HasUrlSession

    private let userDefaults: UserDefaults
    private let session: URLSession

    init(dependencies: Dependencies) {
        userDefaults = dependencies.userDefaults
        session = dependencies.session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController2: UIViewController {
    typealias Dependencies = HasUserDefaults & HasUrlSession & Batata

    private let userDefaults: UserDefaults
    private let session: URLSession

    init(dependencies: Dependencies) {
        userDefaults = dependencies.userDefaults
        session = dependencies.session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension Dependencies {
//    static var mocked: Dependencies {
//        return Dependencies(
//            userDefaults: UserDefaults(suiteName: #file),
//            session: MockedUrlSession(),
//            store: MockedHealthStore()
//        )
//    }
//}

//The example above shows how we can create the mocked version of dependencies to use it for Unit-Testing.
