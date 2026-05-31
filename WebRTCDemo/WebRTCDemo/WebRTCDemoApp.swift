//
//  Created by Kurlovich Vitali on 5/23/26.
//

import SwiftUI

@main
struct WebRTCDemoApp: App {
    var body: some Scene {
        WindowGroup {
            AppLoader {
                MainView()
            }.useDefaultStatusGlassStyle()
        }
    }
}
