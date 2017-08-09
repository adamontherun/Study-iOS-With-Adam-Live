//Some text.

import UIKit

class DogsTableViewController: UITableViewController {
    
    private var dogs: [Dog] {
        let dog1 = Dog(image: #imageLiteral(resourceName: "dog1"), maxBarkVolume: 7)
        let dog2 = Dog(image: #imageLiteral(resourceName: "dog2"), maxBarkVolume: 3)
        let dog3 = Dog(image: #imageLiteral(resourceName: "dog3"), maxBarkVolume: 9)
        return [dog1, dog2, dog3]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dragDelegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
        let dog = dogs[indexPath.row]
        cell.imageView?.image = dog.image
        if let maxBarkVolume = dog.maxBarkVolume {
            cell.textLabel?.text = "Max Bark Volume: \(maxBarkVolume)"
        }
        return cell
    }
}

extension DogsTableViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dog = dogs[indexPath.row]
        let itemProvider = NSItemProvider(object: dog)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
}
