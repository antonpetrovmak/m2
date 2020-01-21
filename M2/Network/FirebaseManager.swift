//
//  FirebaseManager.swift
//  M2
//
//  Created by Petrov Anton on 1/11/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager {
    
    static let share = FirebaseManager()
    private init() { }
    
    let rootRef = Firestore.firestore()
    let residentialComplexCollection = Firestore.firestore().collection("residential_complex")
    let creditsCollection = Firestore.firestore().collection("credits")
    
    func feachResidentialComplex() {
        residentialComplexCollection.getDocuments { (snapshot, error) in
            if let documents = snapshot?.documents {
                print("✅Snapshot: ", documents)
                for doc in documents {
                    let complex = ResidentialComplex(from: doc.data())
                    print("Complex: \(complex)")
                }
                //let complexes = documents.compactMap { ResidentialComplex(from: $0.data()) }
                //print("Complexes: \(complexes)")
                
            } else if let error = error {
                print("❌Error: ", error)
            }
        }
    }
    
    func fetchCredits() {
        creditsCollection.getDocuments { (snapshot, error) in
            if let document = snapshot?.documents.first {
                print("✅Snapshot: ", document.data())
                let credit = RCCredit.init(from: document.data())
                print(credit)
            } else if let error = error {
                print("❌Error: ", error)
            }
        }
    }
}
