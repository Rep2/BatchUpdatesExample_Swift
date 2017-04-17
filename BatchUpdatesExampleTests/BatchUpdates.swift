import XCTest
import Nimble
@testable import BatchUpdatesExample

class BatchUpdatesTests: XCTestCase {

    func testEmpty() {
        let old = [String]()
        let new = [String]()

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([]))
        expect(changes.moved.count).to(equal(0))
    }

    func testSingleDelete() {
        let old = ["test"]
        let new = [String]()

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([0]))
        expect(changes.inserted).to(equal([]))
        expect(changes.moved.count).to(equal(0))
    }

    func testMultipleDelete() {
        let old = ["test1", "test2", "test3", "test4", "test5"]
        let new = ["test2", "test5"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([0, 2, 3]))
        expect(changes.inserted).to(equal([]))

        expect(changes.moved.count).to(equal(2))
        expect(changes.moved[0].0).to(equal(1))
        expect(changes.moved[0].1).to(equal(0))
        expect(changes.moved[1].0).to(equal(4))
        expect(changes.moved[1].1).to(equal(1))
    }

    func testInsertOne() {
        let old = [String]()
        let new = ["test"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([0]))
        expect(changes.moved.count).to(equal(0))
    }

    func testMultipleInsert() {
        let old = ["test2", "test5"]
        let new = ["test1", "test2", "test3", "test4", "test5"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([0, 2, 3]))

        expect(changes.moved.count).to(equal(2))
        expect(changes.moved[0].0).to(equal(0))
        expect(changes.moved[0].1).to(equal(1))
        expect(changes.moved[1].0).to(equal(1))
        expect(changes.moved[1].1).to(equal(4))
    }

    func testMultipleMoved() {
        let old = ["test1", "test2"]
        let new = ["test2", "test1"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([]))

        expect(changes.moved.count).to(equal(2))
        expect(changes.moved[0].0).to(equal(0))
        expect(changes.moved[0].1).to(equal(1))
        expect(changes.moved[1].0).to(equal(1))
        expect(changes.moved[1].1).to(equal(0))
    }

    func testSameInsertedOnce() {
        let old = ["test1"]
        let new = ["test1", "test1"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([1]))

        expect(changes.moved.count).to(equal(0))
    }

    func testSameInsertedMultiple() {
        let old = ["test1", "test2"]
        let new = ["test1", "test2", "test1", "test1", "test2", "test1"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([]))
        expect(changes.inserted).to(equal([2, 3, 4, 5]))

        expect(changes.moved.count).to(equal(0))
    }

    func testSameDeletedOnce() {
        let old = ["test1", "test1"]
        let new = ["test1"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([1]))
        expect(changes.inserted).to(equal([]))

        expect(changes.moved.count).to(equal(0))
    }

    func testSameDeletedMultiple() {
        let old = ["test1", "test1", "test1", "test2", "test2"]
        let new = ["test1", "test2"]

        let changes = BatchUpdates.compare(oldValues: old, newValues: new)

        expect(changes.deleted).to(equal([1, 2, 4]))
        expect(changes.inserted).to(equal([]))

        expect(changes.moved.count).to(equal(1))
        expect(changes.moved[0].0).to(equal(3))
        expect(changes.moved[0].1).to(equal(1))
    }
}
