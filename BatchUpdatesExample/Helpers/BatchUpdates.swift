struct BatchUpdates {
    let deleted: [Int]
    let inserted: [Int]
    let moved: [(Int, Int)]
    let reloaded: [Int]

    init(deleted: [Int], inserted: [Int], moved: [(Int, Int)], reloaded: [Int] = []) {
        self.deleted = deleted
        self.inserted = inserted
        self.moved = moved
        self.reloaded = reloaded
    }

    static func compare<T: Equatable>(oldValues: [T], newValues: [T]) -> BatchUpdates {
        var deleted = [Int]()
        var moved = [(Int, Int)]()

        var remainingNewValues = newValues
            .enumerated()
            .map { (element: $0.element, offset: $0.offset, alreadyFound: false) }

        outer: for oldValue in oldValues.enumerated() {
            for newValue in remainingNewValues {
                print(oldValue)
                print(newValue)
                if oldValue.element == newValue.element && !newValue.alreadyFound {
                    if oldValue.offset != newValue.offset {
                        moved.append((oldValue.offset, newValue.offset))
                    }

                    remainingNewValues[newValue.offset].alreadyFound = true

                    continue outer
                }
            }

            deleted.append(oldValue.offset)
        }

        let inserted = remainingNewValues
            .filter { !$0.alreadyFound }
            .map { $0.offset }

        return BatchUpdates(deleted: deleted, inserted: inserted, moved: moved)
    }

    static func switchArrays(oldCount: Int, newCount: Int) -> BatchUpdates {
        return BatchUpdates(deleted: Array(0..<oldCount), inserted: Array(0..<newCount), moved: [])
    }
}
