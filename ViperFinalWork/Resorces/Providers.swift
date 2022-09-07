//
//  Provider.swift
//  ViperFinalWork
//
//  Created by emre usul on 3.05.2022.
//

import Foundation

final class UserDataProvider {

    private let userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults.standard
    }

    func isFavorite(movieId: Int) -> Bool {
        return getFavoriteMovie().contains { $0.id == movieId}
    }

    func addMovieToFavorites(movie: MovieDetailResponse) {
        var favorites = getFavoriteMovie()
        guard !favorites.contains(where: {$0.id == movie.id }) else {return}
        favorites.append(movie)
        saveFavoriteMovies(movies: favorites)
    }

    func removeMovieFromFavorites(card: MovieDetailResponse) {
        var favorites = getFavoriteMovie()
        guard let indx = favorites.firstIndex(where: {$0.id == card.id}) else {return}
        favorites.remove(at: indx)
        saveFavoriteMovies(movies: favorites)
    }

    func getFavoriteMovie() -> [MovieDetailResponse] {
        guard let favoritesData = userDefaults.object(forKey: "favoriteMovies") as? Data else {return []}
        let decoder = JSONDecoder()
        guard let favoriteCards = try? decoder.decode([MovieDetailResponse].self, from: favoritesData) else {return []}
        return favoriteCards
    }

    private func saveFavoriteMovies(movies: [MovieDetailResponse]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movies) {
            userDefaults.set(encoded, forKey: "favoriteMovies")
        }
    }
}
