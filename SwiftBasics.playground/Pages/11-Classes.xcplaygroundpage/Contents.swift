import Foundation


// Classes are slow!
// Classes are stored in the Heap (memory)
// Objects in the Heap are Reference types
// Reference types point to an object in memory and update the object in memory


// All the data needed for some screen
class ScreenViewModel {
    let title: String
    private(set) var showButton: Bool
    
    // Same init as a Struct, except structs have implicit inits
    init(title: String, showButton: Bool) {
        self.title = title
        self.showButton = showButton
    }
    
    deinit {
        // runs as the object is being removed from memory
        // Structs do NOT have deinit!
    }
    
    func hideButton() {
        showButton = false
    }
    
    func updateShowButton(newValue: Bool) {
        showButton = newValue
    }
}


// Notice that we are using a "let", because:
// the object itself is not changing
// the data inside the object is changing
let viewModel: ScreenViewModel = ScreenViewModel(title: "Screen 1", showButton: true)
//viewModel.showButton = false
let value = viewModel.showButton

viewModel.hideButton()
viewModel.updateShowButton(newValue: false)

// ---------------------------------

// Struct tests below
struct Teste1 {
    let title: String
    var subtitle: String
}

let first = Teste1(title: "Pedro", subtitle: "Daspett")
var second = first

//first.title = "Rafael" // Cannot do it because TITLE is a LET constant in the Struct
//first.subtitle = "Couventaris" // Cannot do it because besides subtitle is a VAR in the Struct, the instance FIRST is a LET constant
//first = Teste1(title: "Lua", subtitle: "Bezana") // Cannot do it because the instance FIRST is a LET constant


//second.title = "Rafael" // Cannot do it because TITLE is a LET constant in the Struct
second.subtitle = "Couventaris" // Can do it because the instance SECOND is a VAR and SUBTITLE is also a VAR
second = Teste1(title: "Lua", subtitle: "Bezana") // Can do it because the instance SECOND is a VAR, so we can attribute a whole new Struct instance to it

// Explicação:
// first é uma constante. Como Teste1 é uma struct (Value Type), não posso alterar nenhuma propriedade através de first, mesmo que a propriedade seja var.
// second é uma variável e recebeu uma cópia independente de first. Por isso posso alterar second.subtitle, já que subtitle também é var. Também posso alterar o let title, mas aí precisaria atribuir um novo objeto (caso Lua)
// NA STRUCT, LET CONGELA O VALOR


// Classes tests below
class Teste2 {
    let title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

let third = Teste2(title: "Pedro", subtitle: "Daspett")
var fourth = third

//third.title = "Rafael" // Cannot do it because TITLE is a LET constant inside the Class
//third.subtitle = "Couventaris" // Can do it because we are not mutating the the instance called "third". We are mutating the class itself and the class has a VAR subtitle
//third = Teste2(title: "Lua", subtitle: "Bezana") // Cannot do it because THIRD is a LET constant


//fourth.title = "Rafael" // Cannot do it because TITLE is a LET constant inside the Class
fourth.subtitle = "Couventaris" // Can do it because we are not mutating the the instance called "third". We are mutating the class itself and the class has a VAR subtitle
fourth = Teste2(title: "Lua", subtitle: "Bezana") // Can do it because FOURTH is a VAR constant


// Explicação:
// third é uma constante que contém uma referência para um objeto. A referência não pode ser alterada, mas o objeto apontado por ela pode ser mutado.
// fourth recebe uma cópia da referência, não uma cópia do objeto. Portanto third e fourth apontam para a mesma instância.
// fourth é var, então posso fazer a referência fourth passar a apontar para outro objeto.
// NA CLASS, LET CONGELA A REFERÊNCIA
// Num caso de:
//
// let user = User(...)
//
// Você não pode fazer:
//
// user = OutroUser(...)
//
// mas pode fazer:
//
// user.name = "Novo nome"
//
// se name for var.
