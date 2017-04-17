import Foundation

class ManualyAnimatedMoviePresenter: MoviePresenter {
    var deletedIndexes = [Int]()

    override func didDelete(presentable: MoviePresentable) {
        if let presentableIndex = presentables.index(of: presentable) {
            presentables.remove(at: presentableIndex)

            view?.deletePresentables(at: [IndexPath(row: presentableIndex, section: 0)], with: presentables)

            if let startIndex = MoviePresentable.mock.index(of: presentable) {
                deletedIndexes.append(startIndex)
            }
        }
    }

    override func didPressReset() {
        presentables = MoviePresentable.mock
        
        view?.insertPresentables(
            at: deletedIndexes.map { IndexPath(row: $0, section: 0) },
            with: presentables
        )

        deletedIndexes = []
    }
}
