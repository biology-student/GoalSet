//
//  ViewModel.swift
//  GoalSet
//
//  Created by Yoshikazu Tsuka on 2021/05/27.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    @Published var achieveDate : Date?
    @Published var achieve = false
    @Published var isNewData = false
    @Published var updateItem : CheckPoint!
    
    func writeData(context: NSManagedObjectContext) {
        
        
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            updateItem.achieve = achieve
            updateItem.achieveDate = achieveDate
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            achieve = false
            content = ""
            date = Date()
            return
        }
        
        let newCheckPoint = CheckPoint(context: context)
        newCheckPoint.date = date
        newCheckPoint.content = content
        newCheckPoint.achieve = achieve
        newCheckPoint.achieveDate = achieveDate
        
        do {
            try context.save()
            isNewData.toggle()
            achieve = false
            content = ""
            date = Date()
            achieveDate = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: CheckPoint){
        updateItem = item
        
        date = item.date!
        content = item.content!
        achieve = item.achieve
        achieveDate = item.achieveDate
        isNewData.toggle()
    }
}
