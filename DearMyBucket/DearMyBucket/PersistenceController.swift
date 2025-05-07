//
//  PersistenceController.swift
//  DearMyBucket
//
//  Created by 최진선 on 5/7/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Core Data container
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Core Data 스토리지를 로드
        container = NSPersistentContainer(name: "DearMyBucketModel")
        
        // In-memory 저장소 사용 시 설정
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Core Data persistent stores 로드
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data 초기화 실패: \(error.localizedDescription)")
            }
        }

        // 자동으로 부모의 변경 사항을 병합
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
