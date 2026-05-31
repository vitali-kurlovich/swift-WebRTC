//
//  Created by Kurlovich Vitali on 5/28/26.
//

import Configuration
import SwiftUI

struct AppConfigurationKey: EnvironmentKey {
    static let defaultValue: AppConfiguration = .init()
}

extension EnvironmentValues {
    var appConfiguration: AppConfiguration {
        get { self[AppConfigurationKey.self] }
        set { self[AppConfigurationKey.self] = newValue }
    }
}
