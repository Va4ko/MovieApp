//
//  CoreDataHelper.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 5.12.22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataRelationship")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func movie(poster: Data, title: String, releaseDate: Date, genre: String, shortAbout: String, longAbout: String) -> Movie {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.poster = poster
        movie.title = title
        movie.releaseDate = releaseDate
        movie.genre = genre
        movie.shortAbout = shortAbout
        movie.longAbout = longAbout
        return movie
    }
    
    func movies() -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedSongs: [Movie] = []
        
        do {
            fetchedSongs = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedSongs
    }
    
    // MARK: - Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("❗️Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteSong(movie: Movie) {
        let context = persistentContainer.viewContext
        context.delete(movie)
        save()
    }
    
    
}
