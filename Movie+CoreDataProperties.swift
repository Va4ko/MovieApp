//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 5.12.22.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var poster: Data?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var genre: String?
    @NSManaged public var shortAbout: String?
    @NSManaged public var longAbout: String?

}

extension Movie : Identifiable {

}
