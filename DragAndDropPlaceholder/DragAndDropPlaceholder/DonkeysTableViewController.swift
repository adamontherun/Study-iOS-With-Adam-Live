//😘 it is 8/9/17

import UIKit

class DonkeysTableViewController: UITableViewController {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "donkeyCell", for: indexPath)
        cell.textLabel?.text = ""
        let photo = photos[indexPath.row]
        cell.imageView?.image = photo.image
        return cell
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.dropDelegate = self
    }
}

extension DonkeysTableViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        for dropItem in coordinator.items {
            let indexPath = coordinator.destinationIndexPath ?? IndexPath(row: 0, section: 0)
            let placeholder = UITableViewDropPlaceholder(insertionIndexPath: indexPath, reuseIdentifier: "placeholderCell", rowHeight: UITableViewAutomaticDimension)
            placeholder.cellUpdateHandler = { (cell) in
                guard let cell = cell as? PlaceholderTableViewCell else { return }
                cell.activityIndicator.startAnimating()
            }
            let dragItem = dropItem.dragItem
            let placeholderContext = coordinator.drop(dragItem, to: placeholder)
            let itemProvider = dragItem.itemProvider
            loadPhoto(from: itemProvider, with: placeholderContext)
        }
    }
    
    private func loadPhoto(from itemProvider: NSItemProvider, with placeholderContext: UITableViewDropPlaceholderContext) {
        itemProvider.loadObject(ofClass: Photo.self) { (photo, error) in
            guard error == nil,
                let photo = photo as? Photo else { return }
            
            DispatchQueue.main.async {
                placeholderContext.commitInsertion(dataSourceUpdates: { (insertionIndexPath) in
                    self.photos.insert(photo, at: insertionIndexPath.row)
                })
            }
        }
    }
    
}
