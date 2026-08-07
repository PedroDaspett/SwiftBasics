import Foundation

struct EmployeeModel: EmployeeHasAName {
    let title: String
    let name: String
}

protocol EmployeeHasAName {
    var name: String { get }
}
