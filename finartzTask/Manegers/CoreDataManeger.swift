//
//  CoreDataManeger.swift
//  finartzTask
//
//  Created by Mustafa Berkay Kaya on 17.08.2021.
//

import Foundation
import CoreData


class CoreDataManeger{
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error{
                fatalError("Core Data store failed \(error.localizedDescription)")
            }
        }
    }
    func deleteWeather(weather:Weathers){
        persistentContainer.viewContext.delete(weather)
        do {
            try persistentContainer.viewContext.save()
        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to delete context \(error)")
        }
    }
    
    
    func getAllWeathers() -> [Weathers]{
        let fetchRequest: NSFetchRequest<Weathers> = Weathers.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch  {
            return []
        }
    }
    
    func saveWeather(city:String,icon:String,sunriseTime:Date,sunsetTime:Date,temperature:Double){
        let weather = Weathers(context: persistentContainer.viewContext)
        weather.city = city
        weather.icon = icon
        weather.temperature = temperature
        weather.sunsetTime = sunsetTime
        weather.sunriseTime = sunriseTime
     
        
        do {
            try persistentContainer.viewContext.save()
        } catch  {
            print("Failed to save weather \(error)")
        }
    }
    
}
