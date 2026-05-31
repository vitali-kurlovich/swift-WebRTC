//
//  Created by Kurlovich Vitali on 5/28/26.
//

import SwiftUI

enum AppLoaderState {
    case ready(AppConfiguration)
    case inProgress
    case error(any Error)
}

struct AppLoader<Content: View>: View {
    @State
    private var state: AppLoaderState = .inProgress

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        switch state {
        case let .ready(appConfiguration):
            content.environment(\.appConfiguration, appConfiguration)
        case .inProgress:
            ProgressView("Loading settings")
                .task {
                    Task {
                        do {
                            let coordinator = AppConfigurationCoordinator()
                            let reader = try await coordinator.reader
                            let configuration = AppConfiguration(reader: reader)

                            self.state = .ready(configuration)

                        } catch {
                            self.state = .error(error)
                        }
                    }
                }
        case let .error(error):
            List {
                Text(error.localizedDescription)
            }
            .refreshable {
                self.state = .inProgress
            }
        }
    }
}

#Preview {
    AppLoader {
        IceServersListView()
    }
}
