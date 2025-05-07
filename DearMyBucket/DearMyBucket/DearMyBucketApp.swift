//
//  DearMyBucketApp.swift
//  DearMyBucket
//
//  Created by 최진선 on 5/7/25.
//

import SwiftUI

@main
struct DearMyBucketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView() // ← 여기로 변경
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

#Preview {
    SplashView()
}
