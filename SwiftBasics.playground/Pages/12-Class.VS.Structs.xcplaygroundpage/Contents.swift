import UIKit

class Car {
    var year: Int
    var make: String
    var color: String
    
    init(year: Int, make: String, color: String) {
        self.year = year
        self.make = make
        self.color = color
    }
}

var myCar = Car(year: 2026, make: "Dodge", color: "Red")
var stolenCar = myCar
stolenCar.color = "Yellow"

print(myCar.color)
print(stolenCar.color)


// Google Sheet analogy: it is a shared document where everyone changes the same document
// Classes are reference types, and if you create multiple variables of the same class, they're all going to point to the same piece of data.
// If you change that piece of data on any one of those variables, the propriety is going to change for all the variables that are all pointing to the same piece of data

//struct Car {
//    var year: Int
//    var make: String
//    var color: String
//}
//
//var myCar = Car(year: 2026, make: "Dodge", color: "Red")
//var stolenCar = myCar
//stolenCar.color = "Yellow"
//
//print(myCar.color)
//print(stolenCar.color)

// Microsoft Excel anology: I have a document then I copy it and send the copy to someone else. That person can change that copy anyway he want it but won't affect my copy of it
// Structs are value types, and if you create multiple variables of the same struct, each one will be a different and unique copy. The changes that are made on one doesn't affect the others


// When do you need a class?
// - Inheritance
// - Reference Type
// Example:
class MyButton: UIButton {
    
}

// When do you need a struct?
// - Lightweight
// - Performant
// - Value Type
// Example: SwiftUI view
