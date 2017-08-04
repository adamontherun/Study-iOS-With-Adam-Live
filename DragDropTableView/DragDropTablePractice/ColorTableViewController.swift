//😘 it is 8/3/17

import UIKit

class ColorTableViewController: UITableViewController {
    
    private var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dropDelegate = self
    }
    
    // MARK: - UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell") else { fatalError() }
        let color = colors[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension ColorTableViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: 0, section: 0)
        
        coordinator.session.loadObjects(ofClass: UIColor.self) { (items) in
            let colorItems = items as! [UIColor]
            var indexPaths = [IndexPath]()
            for (index, item) in colorItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: 0)
                self.colors.insert(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIColor.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertIntoDestinationIndexPath)
    }
    
}
