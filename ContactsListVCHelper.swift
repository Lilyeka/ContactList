//
//  Person.swift
//  PersonContacts
//
//  Created by Лилия Левина on 17.04.17.
//  Copyright © 2017 Лилия Левина. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ContactsListViewController {
    
    // Очищает CoreData(служебная функция)
    func clearData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            var objects = try(managedContext.fetch(Person.fetchRequest()))
            for obj in objects{
                managedContext.delete(obj as! NSManagedObject)
            }
            try(managedContext.save())
        } catch let err{
            print(err)
        }
    }
    
    func demoData(){
   // clearData()
      
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let person1 = Person(context: managedContext)
    person1.name = "Ангела"
    person1.surname = "Меркель"
    person1.personType = 1
    person1.imageBinary = UIImagePNGRepresentation(UIImage(named: "imagePlaceholder")!)! as NSData

    let person2 = Person(context: managedContext)
    person2.name = "Владимир"
    person2.surname = "Путин"
    person2.personType = 1
    person2.fatherName = "Владимирович"
    person2.birthday = "01.01.1954"
    person2.phoneNumber = "8-800-7007007"
    person2.image =  "Putin"
    person2.imageBinary = UIImagePNGRepresentation(UIImage(named: "Putin")!)! as NSData
    
    
    let person3 = Person(context: managedContext)
    person3.name = "Франсуа"
    person3.surname = "Алан"
    person3.personType = 2
    person3.position = "Президент Франции"
    person3.birthday = "15.05.1945"
    person3.phoneNumber = "8-800-8889990"
    person3.jobPhoneNumber = "5-527-123456"
    person3.image = "Alan"
    person3.imageBinary = UIImagePNGRepresentation(UIImage(named: "Alan")!)! as NSData

    do { // сохраняем данные в Core Data
       try(managedContext.save())
    }catch let err {
        print(err)
    }
    loadData()
}
    
func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            persons = try(managedContext.fetch(Person.fetchRequest()))
        } catch let err{
            print(err)
        }
       
        var friends1 = [Person]()
        var collegues1 = [Person]()
        
        for p in persons!{
            if p.personType == 1 {
                friends1.append(p)
            } else {
                collegues1.append(p)
            }
        }
        friends = friends1
        collegues = collegues1
    }
}

