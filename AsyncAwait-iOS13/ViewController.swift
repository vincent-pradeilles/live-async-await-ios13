//
//  ViewController.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var imagesLoadingTasks = [UITableViewCell: Task<Void, Never>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            movies = await makeAsyncNetworkCall().results
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
        
        cell.detailTextLabel?.text = movie.overview
        cell.detailTextLabel?.font = .preferredFont(forTextStyle: .subheadline)
        cell.detailTextLabel?.numberOfLines = 3
        
        imagesLoadingTasks[cell]?.cancel()
        imagesLoadingTasks[cell] = Task {
            cell.imageView?.image = await movie.posterImage
            cell.setNeedsLayout()
        }
        
        return cell
    }
}
