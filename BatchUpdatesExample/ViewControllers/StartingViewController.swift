import UIKit

class StartingViewController: UIViewController {

    let presentables = [
        "Without animatons",
        "With manual animatons",
        "With batch animations"
    ]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Starting view"

        self.view = tableView

        tableView.register(LabelCell.self, forCellReuseIdentifier: LabelCell.identifier)
    }
}

extension StartingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieViewController = BasicMovieViewController(nibName: nil, bundle: nil)

        let presenter: MoviePresenter
        switch indexPath.row {
        case 0:
            presenter = MoviePresenter(view: movieViewController)
        case 1:
            presenter = ManualyAnimatedMoviePresenter(view: movieViewController)
        case 2:
            presenter = BatchUpdatesMoviePresenter(view: movieViewController)
        default:
            fatalError()
        }

        movieViewController.eventHandler = presenter

        navigationController?.pushViewController(movieViewController, animated: true)

        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension StartingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LabelCell = tableView.dequeCell(for: indexPath)

        cell.present(text: presentables[indexPath.row])
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentables.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

