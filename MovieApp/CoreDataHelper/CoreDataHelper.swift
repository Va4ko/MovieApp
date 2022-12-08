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
        
    init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func addMovie(poster: Data, title: String, releaseDate: String, genre: String, shortAbout: String, longAbout: String) -> Movie {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.poster = poster
        movie.title = title
        movie.releaseDate = releaseDate
        movie.genre = genre
        movie.shortAbout = shortAbout
        movie.longAbout = longAbout
        return movie
    }
    
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: true)]
        var fetchedMovies: [Movie] = []
        
        do {
            fetchedMovies = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching movies \(error)")
        }
        completion(fetchedMovies)
    }
    
    // MARK: - Core Data Saving support
    func save (completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("❗️Unresolved error \(nserror), \(nserror.userInfo)")
            }
            completion()
        }
    }
    
    func deleteMovie(movie: Movie, completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        context.delete(movie)
        save {
            completion()
        }
    }
    
}
