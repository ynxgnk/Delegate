import UIKit

/*
 
Delegate - делегат:
1)Делегатор -  тот, кто ставит задачу.
2)Тип делегата - протокол, которому должен соответствовать делегат.
3)Делегат - тот, кто берет на себя обязанность выполнять задачу.
 
*/

struct Product {
    let title: String
    let price: Int
}

struct Position {
    let product: Product
    var count: Int
    
    var cost: Int {
        return product.price * count
    }
}

protocol CatalogDelegate {
    func addPosition(position: Position)
}

class Catalog {
    var products = [Product]()
    var delegate: CatalogDelegate?
    
    func addToCart(index: Int, count: Int) {
        if products.count > index {
            //add position with this product in cart
            if let delegate = delegate {
                let product = products[index]
                let position = Position(product: product, count: count)
                
                delegate.addPosition(position: position)
            }
        }
    }
}

class Cart: CatalogDelegate {
    private(set) var positions = [Position]() /* set - доступ к изменению позиций только внутри класса Position, запрещает изменение извне */
    
    var cost: Int {
        var sum = 0
        
        for position in positions {
            sum += position.cost
        }
        
        return sum
    }
    
    func addPosition(position: Position) {
        self.positions.append(position)
    }
}

let catalog = Catalog()
let cart = Cart()

catalog.delegate = cart

cart.positions.count
cart.cost

let kolbasa = Product(title: "Kolbasa", price: 450)
let milk = Product(title: "Mild", price: 78)
let cheese = Product(title: "Kamamber", price: 230)

catalog.products = [kolbasa, milk, cheese]
catalog.addToCart(index: 0, count: 2)
catalog.addToCart(index: 1, count: 4)
catalog.addToCart(index: 2, count: 1)

cart.positions.count
cart.cost
for position in cart.positions {
    print(position.product.title)
}
