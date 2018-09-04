//: Playground - noun: a place where people can play

import Cocoa

struct CountedSet<Element: Hashable> { //where Element: Hashable {

    // Store set members and their counts
    private(set) var dictionary = [Element : Int]()
    var count = 1
    var isEmpty = true  // set is empty when count is 0
    
    mutating func insert(_ element: Element) {
        // Set count to element
        dictionary[element] = count
        
        // increase count by 1
        count += 1
        
        // Set is no loner empty
        isEmpty = false
    }
    
//    mutating func remove() -> Element? { // can't remove a dictionary without a key?
    
    mutating func remove(_ element: Element) {
        
        // element might not exist
        if dictionary[element] != nil {
            dictionary.removeValue(forKey: element)
        }
        
        if count > 0 {
            isEmpty = false
        }
        // Do we want to reset the count?
    }
    
    mutating func subscripting(_ element: Element) -> Int {
        if dictionary[element] != nil {
            return dictionary[element]!
        } else {
            return 0
        }
        
    }
}



var countedSet = CountedSet<String>()
countedSet.insert("apple")
countedSet.insert("pear")
countedSet.insert("orange")
print(countedSet.dictionary)
countedSet.remove("pear")
print(countedSet.dictionary)
countedSet.insert("banana")
print(countedSet.dictionary)
print(countedSet.subscripting("apple"))
print(countedSet.subscripting("pear"))
print(countedSet.subscripting("banana"))



