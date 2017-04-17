import UIKit

extension UICollectionView {
    func reloadData(with batchUpdates: BatchUpdates) {
        performBatchUpdates({
            self.insertItems(at: batchUpdates.inserted.map {
                IndexPath(row: $0, section: 0) })
            self.deleteItems(at: batchUpdates.deleted.map {
                IndexPath(row: $0, section: 0) })
            self.reloadItems(at: batchUpdates.reloaded.map {
                IndexPath(row: $0, section: 0) })

            for movedRows in batchUpdates.moved {
                self.moveItem(
                    at: IndexPath(row: movedRows.0, section: 0),
                    to: IndexPath(row: movedRows.1, section: 0)
                )
            }
        })
    }
}
extension UITableView {
    func reloadData(with batchUpdates: BatchUpdates) {
        beginUpdates()

        insertRows(at: batchUpdates.inserted
            .map { IndexPath(row: $0, section: 0) }, with: .fade)
        deleteRows(at: batchUpdates.deleted
            .map { IndexPath(row: $0, section: 0) }, with: .fade)
        reloadRows(at: batchUpdates.reloaded
            .map { IndexPath(row: $0, section: 0) }, with: .fade)
        
        for movedRows in batchUpdates.moved {
            moveRow(at: IndexPath(row: movedRows.0, section: 0),
                    to: IndexPath(row: movedRows.1, section: 0))
        }

        endUpdates()
    }
}
