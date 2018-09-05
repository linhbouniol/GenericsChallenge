//: Playground - noun: a place where people can play

import Cocoa

struct CountedSet<Element: Hashable> { //where Element: Hashable {

    // Store set members and their counts
    private(set) var dictionary = [Element : Int]()
    
    var count: Int {
        return dictionary.count
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    mutating func insert(_ element: Element) {
        // if the element already exist, increase its value by 1
        // if the element doesn't exist yet, set its value = 1
        
        // current count of element
        if let elementCount = dictionary[element] {
            dictionary[element] = elementCount + 1
        } else {
            dictionary[element] = 1
        }
    }
    
    mutating func remove(_ element: Element) {
        if let elementCount = dictionary[element] {
            if elementCount == 1 {
                dictionary.removeValue(forKey: element)
            } else {
                dictionary[element] = elementCount - 1
            }
        }
    }
    
    subscript(_ element: Element) -> Int {
        if let elementCount = dictionary[element] {
            return elementCount
        } else {
            return 0
        }
    }
}

extension CountedSet: ExpressibleByArrayLiteral {
    init(arrayLiteral: Element...) {
        self.init()
        for element in arrayLiteral {
            self.insert(element)
        }
    }
}

// Without conforming to ExpressibleByArrayLiteral, we must add each item individually
var countedSet = CountedSet<String>()
countedSet.insert("one")
countedSet.insert("two")
print(countedSet["two"])
countedSet.insert("two")
countedSet.remove("one")
print(countedSet["two"])
countedSet.remove("two")
countedSet.remove("two")
print(countedSet["two"])

//for element in countedSet {
//    print(element)
//}

// With arrayLiteral, we can add items all at once using an array, and not need to specify the type
var otherCountedSet: CountedSet = ["zelda", "zelda", "zelda", "book", "apple", "apple"]
print(otherCountedSet)


enum Arrow { case iron, wooden, elven, dwarvish, magic, silver }
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
print(myCountedSet)
