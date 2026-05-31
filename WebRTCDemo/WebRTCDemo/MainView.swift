//
//  Created by Kurlovich Vitali on 5/23/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // IceServersListView()

        TabView {
            Tab("Channel", systemImage: "tray.and.arrow.down.fill") {
                // ChannelsView()
            }

            Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
                // SentView()
            }

            Tab("Account", systemImage: "person.crop.circle.fill") {
                // AccountView()
            }
        }
    }
}

struct ChannelsView: View {
    @State
    private var inputText: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .border(Color.secondary)

            HStack {
                Spacer()
                Button("Send") {}
            }
        }.padding()
    }
}

#Preview {
    AppLoader {
        MainView()
    }
}
