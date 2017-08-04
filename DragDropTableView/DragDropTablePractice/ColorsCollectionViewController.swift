//😘 it is 8/3/17

import UIKit

private let reuseIdentifier = "sourceColorCell"

class ColorsCollectionViewController: UICollectionViewController {
    
    var candidateColors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dragDelegate = self
        candidateColors.append(contentsOf: [.red, .purple, .green, .blue, .brown])
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return candidateColors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let color = candidateColors[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
}

extension ColorsCollectionViewController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let color = candidateColors[indexPath.row]
        let itemProvider = NSItemProvider(object: color)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
}
