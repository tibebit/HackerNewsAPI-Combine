//
//  ViewController.swift
//  HackerNews(UIKit&Combine)
//
//  Created by Fabio Tiberio on 03/03/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var stories               = [Story]()
    private var api           = API()
    private var subscriptions = [AnyCancellable]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        receiveStories()
    }
    
    
    private func receiveStories() {
        
        api.stories()
            .sink(receiveCompletion: { _ in
                Task {await self.updateUI()}
            }, receiveValue: {
                self.stories = $0
            })
            .store(in: &subscriptions)
    }
    
    
    @MainActor private func updateUI() async {
        
        await MainActor.run { tableView.reloadData() }
    }

    
    @MainActor private func presentAlert(with error: API.Error) {
        
        let alertController = UIAlertController(title: "API Error", message: error.errorDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        let story = stories[indexPath.row]
        cell.contentConfiguration = cell.configure(title: story.title, author: story.by)
        
        return cell
    }
}
