//
//  CloudKitManager.swift
//  RoomyHabits
//
//  Created by Paige B on 3/10/26.
//


import CloudKit

class CloudKitManager {

    static let shared = CloudKitManager()
    let database = CKContainer.default().publicCloudDatabase

    func fetchGoals(completion: @escaping ([CKRecord]) -> Void) {

        let query = CKQuery(recordType: "Goal", predicate: NSPredicate(value: true))

        database.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                completion(records ?? [])
            }
        }
    }

    func saveGoal(id: String, completed: Bool) {

        let recordID = CKRecord.ID(recordName: id)
        let record = CKRecord(recordType: "Goal", recordID: recordID)

        record["completed"] = completed

        database.save(record) { _, _ in }
    }
}