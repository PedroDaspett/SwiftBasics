import Foundation


// Structs are fast!
// Structs are stored in the Stack (memory)
// Objects in the Stack are Value types
// Value types are copied & mutated


struct Quiz {
    let title: String
    let dateCreated: Date
    let isPremium: Bool?
    
    // Structs have an implicit init
    //    init(title: String, dateCreated: Date) {
    //        self.title = title
    //        self.dateCreated = dateCreated
    //    }
    
    //    init(title: String, dateCreated: Date = .now) {
    //        self.title = title
    //        self.dateCreated = dateCreated
    //    }
    
    init(title: String, dateCreated: Date?, isPremium: Bool?) {
        self.title = title
        self.dateCreated = dateCreated ?? .now
        self.isPremium = isPremium
    }
}


let myObject: String = "Hello, world!"

//let myQuiz: Quiz = Quiz(title: "Quiz 1", dateCreated: .now)
//let myQuiz: Quiz = Quiz(title: "Quiz 1")
//let myQuiz = Quiz(title: "Quiz 1", isPremium: nil)
let myQuiz: Quiz = Quiz(title: "Quiz 1", dateCreated: nil, isPremium: false)

print(myQuiz.title)


// -----------------------------------------------------


// "Immutable struct" = all "let" constants = NOT mutable = "cannot mutate it!"
struct UserModel {
    let name: String
    let isPremium: Bool
}

var user1: UserModel = UserModel(name: "Nick", isPremium: false)

@MainActor
func markUserAsPremium() {
    print(user1)
    user1 = UserModel(name: user1.name, isPremium: true)
    print(user1)
}

//markUserAsPremium()

// -----------------------------------------------------

// "mutable struct"
struct UserModel2 {
    let name: String
    var isPremium: Bool
}

var user2 = UserModel2(name: "Nick", isPremium: false)

@MainActor
func markUserAsPremium2() {
    print(user2)
    
    // "mutate" the struct
    user2.isPremium = true
    
    print(user2)
}
markUserAsPremium2()

// -----------------------------------------------------

// "immutable struct"
struct UserModel3 {
    let name: String
    let isPremium: Bool
    
    func markUserAsPremium(newValue: Bool) -> UserModel3 {
        UserModel3(name: name, isPremium: newValue)
    }
}

var user3: UserModel3 = UserModel3(name: "Nick", isPremium: false)
user3 = user3.markUserAsPremium(newValue: true)

// -----------------------------------------------------

// "mutable struct"

struct UserModel4 {
    let name: String
    private(set) var isPremium: Bool
    
    mutating func markUserAsPremium() {
        isPremium = true
    }
    
    mutating func updateIsPremium(newValue: Bool) {
        isPremium = newValue
    }
}

var user4 = UserModel4(name: "Nick", isPremium: false)
user4.markUserAsPremium()
user4.updateIsPremium(newValue: true)


struct User5 {
    let name: String
    let isPremium: Bool
    let isNew: Bool
    //
    //
    //
    //
}

// EXPLICAÇÃO DO CHATGPT: https://chatgpt.com/s/t_6a6b62d687c08191b672ca679d4b6a21
//
//Sim — e acho que a confusão vem principalmente de uma coisa: **o código está misturando três conceitos diferentes**:
//
//1. `let` e `var` nas propriedades da `struct`
//2. `let` e `var` na própria variável que guarda a `struct`
//3. `struct` ser **Value Type**, ou seja, ser copiada quando você atribui uma a outra
//
//Vamos separar isso porque aí o documento fica bem mais fácil.
//
//---
//
//# 1. Primeiro: o que é uma `struct`?
//
//Uma `struct` é um tipo que representa um conjunto de dados:
//
//```swift
//struct User {
//    let name: String
//    var isPremium: Bool
//}
//```
//
//Podemos criar:
//
//```swift
//var user = User(name: "Nick", isPremium: false)
//```
//
//Agora temos:
//
//```text
//user
//├── name = "Nick"
//└── isPremium = false
//```
//
//O ponto importante é:
//
//> **A `struct` em si não é imutável ou mutável. As propriedades dela podem ser `let` ou `var`.**
//
//Então:
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//}
//```
//
//é uma struct cujos dados **não podem ser alterados diretamente**.
//
//Enquanto:
//
//```swift
//struct User {
//    let name: String
//    var isPremium: Bool
//}
//```
//
//permite alterar `isPremium`.
//
//---
//
//# 2. `let` na propriedade vs `var` na propriedade
//
//Seu exemplo:
//
//```swift
//struct UserModel {
//    let name: String
//    let isPremium: Bool
//}
//```
//
//Depois:
//
//```swift
//var user1 = UserModel(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//Você **não pode** fazer:
//
//```swift
//user1.isPremium = true // ❌
//```
//
//Porque `isPremium` é `let`.
//
//Então, como você faz para ter um usuário premium?
//
//Você cria **outro UserModel**:
//
//```swift
//user1 = UserModel(
//    name: user1.name,
//    isPremium: true
//)
//```
//
//Ou seja:
//
//```text
//ANTES
//
//user1
//├── name = Nick
//└── isPremium = false
//
//
//DEPOIS
//
//user1
//├── name = Nick
//└── isPremium = true
//```
//
//Você não modificou o objeto antigo.
//
//Você **substituiu o valor inteiro por outro valor**.
//
//---
//
//# 3. "Mas por que eu faria isso?"
//
//Essa é a parte realmente importante.
//
//À primeira vista, você provavelmente pensou:
//
//> "Por que eu faria isso? Não seria muito mais simples colocar `var isPremium`?"
//
//Sim. **Em muitos casos seria.**
//
//Mas structs imutáveis têm uma vantagem muito importante:
//
//## Você consegue controlar melhor as mudanças de estado.
//
//Imagine:
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//    let isNew: Bool
//}
//```
//
//Você pode decidir:
//
//> "Depois que um `User` foi criado, ninguém pode alterar suas propriedades diretamente."
//
//Então isso:
//
//```swift
//user.isPremium = true
//```
//
//não existe.
//
//Para mudar o usuário, você precisa criar outro:
//
//```swift
//user = User(
//    name: user.name,
//    isPremium: true,
//    isNew: user.isNew
//)
//```
//
//Isso parece mais trabalhoso, mas existe um benefício:
//
//### O estado fica mais previsível.
//
//Você sabe que:
//
//```swift
//let user = User(...)
//```
//
//não vai sofrer alterações escondidas.
//
//---
//
//# 4. Agora vem a parte que mais confunde
//
//Olha isso:
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//}
//
//var user = User(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//Temos:
//
//```text
//user
//↓
//User
//├── name = "Nick"
//└── isPremium = false
//```
//
//Embora as propriedades sejam `let`, a variável `user` é `var`.
//
//Isso permite:
//
//```swift
//user = User(
//    name: "Nick",
//    isPremium: true
//)
//```
//
//Você não alterou `isPremium`.
//
//Você trocou **o valor inteiro de `user`**.
//
//É uma diferença extremamente importante.
//
//---
//
//# 5. Compare estas duas situações
//
//## Caso A
//
//```swift
//let user = User(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//Não pode:
//
//```swift
//user = User(...) // ❌
//```
//
//E também não pode:
//
//```swift
//user.isPremium = true // ❌
//```
//
//O `user` inteiro é imutável.
//
//---
//
//## Caso B
//
//```swift
//var user = User(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//Não pode:
//
//```swift
//user.isPremium = true // ❌
//```
//
//porque `isPremium` é `let`.
//
//Mas pode:
//
//```swift
//user = User(
//    name: "Nick",
//    isPremium: true
//)
//```
//
//porque `user` é `var`.
//
//---
//
//## Caso C
//
//```swift
//var user = UserModel2(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//e:
//
//```swift
//struct UserModel2 {
//    let name: String
//    var isPremium: Bool
//}
//```
//
//Agora:
//
//```swift
//user.isPremium = true // ✅
//```
//
//porque `isPremium` é `var`.
//
//---
//
//# 6. Então por que o exemplo 3 é interessante?
//
//Seu código:
//
//```swift
//struct UserModel3 {
//    let name: String
//    let isPremium: Bool
//
//    func markUserAsPremium(newValue: Bool) -> UserModel3 {
//        UserModel3(
//            name: name,
//            isPremium: newValue
//        )
//    }
//}
//```
//
//E:
//
//```swift
//var user3 = UserModel3(
//    name: "Nick",
//    isPremium: false
//)
//
//user3 = user3.markUserAsPremium(newValue: true)
//```
//
//Isso é muito legal porque o método **não modifica o próprio `UserModel3`**.
//
//Ele recebe:
//
//```text
//UserModel3
//isPremium = false
//```
//
//e retorna:
//
//```text
//NOVO UserModel3
//isPremium = true
//```
//
//Visualmente:
//
//```text
//user3
//│
//▼
//┌─────────────────┐
//│ name = Nick     │
//│ premium = false │
//└─────────────────┘
//│
//│ markUserAsPremium()
//▼
//┌─────────────────┐
//│ name = Nick     │
//│ premium = true  │
//└─────────────────┘
//│
//▼
//user3
//```
//
//Esse estilo é muito próximo da ideia de **imutabilidade** e **programação funcional**.
//
//---
//
//# 7. "Mas não é mais simples usar `var`?"
//
//Sim.
//
//Seu exemplo 2:
//
//```swift
//struct UserModel2 {
//    let name: String
//    var isPremium: Bool
//}
//
//var user2 = UserModel2(
//    name: "Nick",
//    isPremium: false
//)
//
//user2.isPremium = true
//```
//
//É muito mais simples.
//
//E não há nada errado com isso.
//
//Então a pergunta não é:
//
//> "Qual é melhor?"
//
//É:
//
//> **"Eu quero que esse tipo possa ser modificado diretamente?"**
//
//Se sim:
//
//```swift
//var isPremium: Bool
//```
//
//Se não:
//
//```swift
//let isPremium: Bool
//```
//
//---
//
//# 8. E aqui entra o `private(set)`
//
//Esse exemplo é particularmente importante:
//
//```swift
//struct UserModel4 {
//    let name: String
//    private(set) var isPremium: Bool
//
//    mutating func markUserAsPremium() {
//        isPremium = true
//    }
//}
//```
//
//O:
//
//```swift
//private(set)
//```
//
//significa basicamente:
//
//> "Pode ler de fora, mas só pode alterar aqui dentro."
//
//Então:
//
//```swift
//var user = UserModel4(
//    name: "Nick",
//    isPremium: false
//)
//```
//
//Você pode:
//
//```swift
//print(user.isPremium) // ✅
//```
//
//Mas não pode:
//
//```swift
//user.isPremium = true // ❌
//```
//
//Porém a própria `struct` pode:
//
//```swift
//mutating func markUserAsPremium() {
//    isPremium = true
//}
//```
//
//Então:
//
//```swift
//user.markUserAsPremium()
//```
//
//funciona.
//
//---
//
//# 9. Mas por que precisa de `mutating`?
//
//Essa é outra coisa muito importante para entrevista de Swift.
//
//Como `struct` é **Value Type**, métodos de uma struct normalmente não podem modificar suas propriedades.
//
//Por exemplo:
//
//```swift
//struct User {
//    var isPremium: Bool
//
//    func makePremium() {
//        isPremium = true // ❌
//    }
//}
//```
//
//O compilador reclama.
//
//Você precisa dizer:
//
//```swift
//mutating func makePremium() {
//    isPremium = true
//}
//```
//
//O `mutating` está dizendo:
//
//> "Esse método pode modificar o valor da própria struct."
//
//Então:
//
//```swift
//struct User {
//    var isPremium: Bool
//
//    mutating func makePremium() {
//        isPremium = true
//    }
//}
//```
//
//Agora:
//
//```swift
//var user = User(isPremium: false)
//
//user.makePremium()
//```
//
//Funciona.
//
//---
//
//# 10. E isso nos leva à grande diferença entre os exemplos
//
//Seu documento está mostrando **dois estilos diferentes**.
//
//### Estilo 1 — Imutável
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//
//    func makePremium() -> User {
//        User(
//            name: name,
//            isPremium: true
//        )
//    }
//}
//```
//
//Uso:
//
//```swift
//var user = User(
//    name: "Nick",
//    isPremium: false
//)
//
//user = user.makePremium()
//```
//
//A ideia é:
//
//> "Eu não altero o User. Eu crio um novo User."
//
//---
//
//### Estilo 2 — Mutável
//
//```swift
//struct User {
//    let name: String
//    var isPremium: Bool
//
//    mutating func makePremium() {
//        isPremium = true
//    }
//}
//```
//
//Uso:
//
//```swift
//var user = User(
//    name: "Nick",
//    isPremium: false
//)
//
//user.makePremium()
//```
//
//A ideia é:
//
//> "Eu permito que o User altere seu estado."
//
//---
//
//# 11. Agora vamos falar do que realmente significa "Struct é Value Type"
//
//Essa parte é **fundamental para entrevista**.
//
//Imagine:
//
//```swift
//struct User {
//    var name: String
//}
//
//var user1 = User(name: "Pedro")
//var user2 = user1
//```
//
//Como `User` é `struct`, `user2` recebe **uma cópia do valor**.
//
//Conceitualmente:
//
//```text
//user1                     user2
//┌──────────────┐          ┌──────────────┐
//│ name Pedro   │          │ name Pedro   │
//└──────────────┘          └──────────────┘
//↑                         ↑
//└──── valores iguais ─────┘
//```
//
//Então:
//
//```swift
//user2.name = "Nick"
//```
//
//temos:
//
//```text
//user1                     user2
//┌──────────────┐          ┌──────────────┐
//│ name Pedro   │          │ name Nick    │
//└──────────────┘          └──────────────┘
//```
//
//`user1` continua sendo Pedro.
//
//Isso é **Value Semantics**.
//
//---
//
//# 12. E aqui aparece uma consequência MUITO interessante
//
//Compare:
//
//```swift
//struct User {
//    var name: String
//}
//```
//
//com:
//
//```swift
//class User {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//```
//
//Struct:
//
//```swift
//var user1 = User(name: "Pedro")
//var user2 = user1
//
//user2.name = "Nick"
//```
//
//Resultado:
//
//```text
//user1 → Pedro
//user2 → Nick
//```
//
//Classe:
//
//```swift
//var user1 = User(name: "Pedro")
//var user2 = user1
//
//user2.name = "Nick"
//```
//
//Resultado:
//
//```text
//user1 → Nick
//user2 → Nick
//```
//
//Porque classes são **Reference Types**.
//
//---
//
//# 13. Um detalhe importante: "Struct fica na Stack" não é uma regra absoluta
//
//No seu documento está:
//
//```swift
//// Structs are stored in the Stack (memory)
//```
//
//Isso é uma simplificação que eu **não decoraria para entrevista**.
//
//O mais correto é falar:
//
//> **Structs são Value Types. Classes são Reference Types.**
//
//A questão de Stack vs Heap depende de como o Swift implementa e otimiza determinada coisa. Não é correto resumir simplesmente como:
//
//```text
//struct → Stack
//class → Heap
//```
//
//como se fosse uma regra universal.
//
//Para entrevista, **Value Type vs Reference Type** é o conceito importante.
//
//---
//
//# 14. Então quando usar `let` e quando usar `var`?
//
//Eu pensaria assim:
//
//### `let`
//
//Use quando o valor **não deveria mudar depois de criado**.
//
//Exemplo:
//
//```swift
//struct User {
//    let id: Int
//    let name: String
//}
//```
//
//Um ID normalmente não deveria mudar.
//
//---
//
//### `var`
//
//Use quando faz sentido que o estado seja alterado:
//
//```swift
//struct User {
//    let id: Int
//    let name: String
//    var isPremium: Bool
//}
//```
//
//O usuário pode se tornar premium.
//
//---
//
//### `private(set)`
//
//Quando você quer:
//
//> "Outras partes do código podem consultar o estado, mas não podem alterá-lo diretamente."
//
//```swift
//struct User {
//    let name: String
//    private(set) var isPremium: Bool
//
//    mutating func makePremium() {
//        isPremium = true
//    }
//}
//```
//
//Isso é uma forma de **encapsulamento**.
//
//---
//
//# 15. E tem uma coisa ainda mais interessante no seu exemplo
//
//Veja:
//
//```swift
//struct UserModel3 {
//    let name: String
//    let isPremium: Bool
//
//    func markUserAsPremium(newValue: Bool) -> UserModel3 {
//        UserModel3(name: name, isPremium: newValue)
//    }
//}
//```
//
//O método recebe:
//
//```swift
//newValue: Bool
//```
//
//Então ele poderia fazer:
//
//```swift
//user3.markUserAsPremium(newValue: true)
//```
//
//ou:
//
//```swift
//user3.markUserAsPremium(newValue: false)
//```
//
//Mas o nome:
//
//```swift
//markUserAsPremium
//```
//
//sugere que você sempre quer `true`.
//
//Então eu provavelmente escreveria:
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//
//    func markAsPremium() -> User {
//        User(
//            name: name,
//            isPremium: true
//        )
//    }
//}
//```
//
//Uso:
//
//```swift
//var user = User(
//    name: "Nick",
//    isPremium: false
//)
//
//user = user.markAsPremium()
//```
//
//Isso deixa a intenção muito mais clara.
//
//---
//
//# 16. Resumindo o seu documento
//
//Eu organizaria mentalmente assim:
//
//```text
//STRUCT
//│
//▼
//VALUE TYPE
//│
//▼
//atribuição gera cópia
//│
//┌─────────┴─────────┐
//▼                   ▼
//PROPRIEDADE           PROPRIEDADE
//let                   var
//│                     │
//▼                     ▼
//não modifica           pode modificar
//│                     │
//│                     ▼
//│              precisa mutating
//│              dentro da struct
//│
//▼
//pode criar outro valor
//e substituir a variável
//```
//
//E:
//
//```swift
//struct User {
//    let name: String
//    let isPremium: Bool
//}
//```
//
//significa:
//
//> **O estado do User não pode ser alterado internamente.**
//
//Enquanto:
//
//```swift
//struct User {
//    let name: String
//    var isPremium: Bool
//}
//```
//
//significa:
//
//> **O estado `isPremium` pode ser alterado.**
//
//E:
//
//```swift
//private(set) var isPremium: Bool
//```
//
//significa:
//
//> **Pode ser lido externamente, mas só pode ser alterado internamente.**
//
//---
//
//## 🧠 A frase que eu decoraria para entrevista
//
//Se te perguntarem **"Qual a diferença entre esses dois?"**:
//
//```swift
//struct User {
//    let isPremium: Bool
//}
//```
//
//e
//
//```swift
//struct User {
//    var isPremium: Bool
//}
//```
//
//Eu responderia:
//
//> **"A primeira torna a propriedade imutável depois da inicialização. Para mudar o estado, preciso criar um novo valor da struct e substituir a variável que o contém. A segunda permite mutar diretamente a propriedade, e métodos que modificam propriedades de uma struct precisam ser marcados como `mutating`."**
//
//E se perguntarem **por que escolher imutabilidade**:
//
//> **"Para tornar o estado mais previsível e evitar alterações diretas inesperadas. Em vez de modificar um valor existente, operações retornam um novo valor, o que facilita raciocinar sobre o estado e pode reduzir efeitos colaterais."**
//
//Essa segunda resposta é, na minha opinião, **a parte mais importante de entender desse documento**.
