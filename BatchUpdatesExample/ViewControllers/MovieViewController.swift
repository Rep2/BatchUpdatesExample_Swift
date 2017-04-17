import UIKit

protocol MovieViewController: class {
    var eventHandler: MovieViewEventHandler? { get set }

    func present(presentables: [MoviePresentable])
    func presentWithAnimations(presentables: [MoviePresentable])
    func deletePresentables(at indexPaths: [IndexPath], with presentables: [MoviePresentable])
    func insertPresentables(at indexPaths: [IndexPath], with presentables: [MoviePresentable])
}

protocol MovieViewEventHandler {
    func didDelete(presentable: MoviePresentable)
    func didPressReset()
}

class BasicMovieViewController: UIViewController {
    var presentables = [MoviePresentable]()

    var eventHandler: MovieViewEventHandler?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Bruce Willis movies"

        self.view = tableView
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(BasicMovieViewController.didPressReset))
    }

    func didPressReset() {
        eventHandler?.didPressReset()
    }
}

extension BasicMovieViewController: MovieViewController {
    func present(presentables: [MoviePresentable]) {
        self.presentables = presentables

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func presentWithAnimations(presentables: [MoviePresentable]) {
        let oldPresentables = self.presentables
        self.presentables = presentables

        tableView.reloadData(
            with: BatchUpdates.compare(oldValues: oldPresentables, newValues: presentables)
        )
    }

    func deletePresentables(at indexPaths: [IndexPath], with presentables: [MoviePresentable]) {
        self.presentables = presentables

        tableView.deleteRows(at: indexPaths, with: .fade)
    }

    func insertPresentables(at indexPaths: [IndexPath], with presentables: [MoviePresentable]) {
        self.presentables = presentables

        tableView.insertRows(at: indexPaths, with: .fade)
    }
}

extension BasicMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeCell(for: indexPath)

        cell.present(movie: presentables[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentables.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eventHandler?.didDelete(presentable: presentables[indexPath.row])
        }
    }
}

