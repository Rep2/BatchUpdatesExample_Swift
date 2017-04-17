class BatchUpdatesMoviePresenter: MoviePresenter {
    override func presentMovies() {
        view?.presentWithAnimations(presentables: presentables)
    }
}
