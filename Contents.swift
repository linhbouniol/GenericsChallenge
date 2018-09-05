//: Playground - noun: a place where people can play

import Cocoa

struct CountedSet<Element: Hashable> { //where Element: Hashable {

    // Store set members and their counts
    private(set) var dictionary: [Element : Int] = [:]
    
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
    
    func contains(_ element: Element) -> Bool {
        //        return dictionary[element] != nil
        
        if dictionary[element] == nil {
            return false
        } else {
            return true
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

extension CountedSet: Sequence {
    // Sequence wants an iterator, and we direct that over to the dictionary.
    // An iterator is something that goes through every item in a collection like a loop.
    func makeIterator() -> DictionaryIterator<Element, Int> {
        return dictionary.makeIterator()
    }
    
    func unionSet(_ anotherCountedSet: CountedSet<Element>) -> CountedSet<Element> {
        var newSet = CountedSet()
        
        // iteration using Sequence...
        for (element, elementCount) in self { // self is the current set that is utilizing union()
            for _ in 1...elementCount {
                newSet.insert(element)
            }
        }
        
        for (element, elementCount) in anotherCountedSet {
            for _ in 1...elementCount {
                newSet.insert(element)
            }
        }
        
        return newSet
    }
    
    mutating func union(_ anotherCountedSet: CountedSet<Element>) {
        // Go through each element in a different set and adding it to your own
        for (element, elementCount) in anotherCountedSet {
            for _ in 1...elementCount {
                self.insert(element)    // self is the current set that is utilizing union()
            }
        }
    }
    
    mutating func subtract(_ anotherCountedSet: CountedSet<Element>) {
        for (element, elementcount) in anotherCountedSet {
            for _ in 1...elementcount {
                self.remove(element)
            }
        }
    }
    
    static func ==(lhs: CountedSet<Element>, rhs: CountedSet<Element>) -> Bool {
        return lhs.dictionary == rhs.dictionary
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
print(countedSet["two"]) // empty at this point



// With arrayLiteral, we can add items all at once using an array, and not need to specify the type
var otherCountedSet: CountedSet = ["zelda", "zelda", "zelda", "book", "apple", "apple"]
print(otherCountedSet)

// Using Sequence, get the values of each element
for element in otherCountedSet {
    print(element)
}

otherCountedSet.contains("zelda")
otherCountedSet.contains("link")

// Union... this is not mutating because we're not changing either sets, we're returning a new set
var anotherCountedSet: CountedSet = ["zelda", "link"]
var unionSet = otherCountedSet.unionSet(anotherCountedSet)
print(unionSet)

// Mutating union...adding anotherCountedSet to otherCountedSet directly, therefore changing otherCountedSet.
// This only works if otherCountedSet is a var because union() is mutating, and changes what otherCountedSet is. If otherCountedSet were a let, this would not work.
otherCountedSet.union(anotherCountedSet)
print(otherCountedSet)

// Subtracting anotherCountedSet from otherCountedSet...
otherCountedSet.subtract(anotherCountedSet)
print(otherCountedSet)

// Equatable
otherCountedSet == anotherCountedSet

enum Arrow { case iron, wooden, elven, dwarvish, magic, silver }
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
print(myCountedSet)
