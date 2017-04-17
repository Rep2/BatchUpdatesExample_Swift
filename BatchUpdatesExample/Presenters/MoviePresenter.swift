class MoviePresenter: MovieViewEventHandler {
    weak var view: MovieViewController?

    var presentables: [MoviePresentable]

    init(view: MovieViewController) {
        self.presentables = MoviePresentable.mock
        self.view = view

        view.present(presentables: presentables)
    }

    func presentMovies() {
        view?.present(presentables: presentables)
    }

    func didDelete(presentable: MoviePresentable) {
        let presentableIndex = presentables
            .enumerated()
            .filter { $0.element == presentable }
            .first?
            .offset

        if let presentableIndex = presentableIndex {
            presentables.remove(at: presentableIndex)
        }

        presentMovies()
    }

    func didPressReset() {
        presentables = MoviePresentable.mock

        presentMovies()
    }
}
