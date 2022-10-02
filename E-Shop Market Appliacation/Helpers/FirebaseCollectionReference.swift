//
//  FirebaseCollectionReference.swift
//  E-Shop Market Appliacation
//
//  Created by Kerim Civelek on 24.09.2022.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Category
    case Items
    case Basket
}



func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
 
    Firestore.firestore().collection(collectionReference.rawValue)
}
