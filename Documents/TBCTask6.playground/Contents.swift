import UIKit

import Foundation
import PlaygroundSupport

public func result(for exercise: String, action: () -> Void) {
    print("ამოცანა: \(exercise)")
    print("------------------------------")
    action()
    print("\n")
    print()
}

result(for: "ბიბლიოთეკა") {
    class Book {
        let bookID: Int
        
        let title: String
        
        let author: String
        
        var isBorrowed: Bool
        
        init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        
            self.bookID = bookID
            
            self.title = title

            self.author = author

            self.isBorrowed = isBorrowed
        }
        
        func markAsBorrowed() {
            isBorrowed = true
        }
        
        func markAsReturned() {
            isBorrowed = false
        }
    }
    
    class Owner {

        let ownerId: Int

        let name: String

        var borrowedBooks: [Book]
        
        init(ownerId: Int, name: String, borrowedBooks: [Book]) {

            self.ownerId = ownerId

            self.name = name

            self.borrowedBooks = borrowedBooks
        }
        
        func borrowBook(book: Book) {

            borrowedBooks.append(book)

            book.markAsBorrowed()
        }
        
        func returnBook(book: Book) {
            if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {

                borrowedBooks.remove(at: index)

                book.markAsReturned()
            }
        }
    }
    class Library {
       
        var books: [Book]
        
        var owners: [Owner]
        
        init(books: [Book], owners: [Owner]) {
            self.books = books
            self.owners = owners
        }
        
        func addBook(book: Book) {
            books.append(book)
        }
        
        func addOwner(owner: Owner) {
            owners.append(owner)
        }
        
        func findAvailableBooks() -> [Book] {
            return books.filter { !$0.isBorrowed }
        }
        
        func findBorrowedBooks() -> [Book] {
            return books.filter { $0.isBorrowed }
        }
        
        func findOwnerById(ownerId: Int) -> Owner? {
            return owners.first(where: { $0.ownerId == ownerId })
        }
        
        func findBooksByOwner(owner: Owner) -> [Book] {
            return owner.borrowedBooks
        }
        
        func allowBorrowBook(owner: Owner, book: Book) -> Bool {
            if !book.isBorrowed {
                owner.borrowBook(book: book)
                return true
            }
            return false
        }
    }

    // სიმულაცია
    
    //აქ ქულებზე ვჩალიჩობ
    let book1 = Book(bookID: 1, title: "როგორ გავცეთ საუკეთესო feedback-ები", author: "ნანა/სანდრო", isBorrowed: false)
    let book2 = Book(bookID: 2, title: "როგორ გავცეთ უფრო მიზუსტებული ახსნა და მაგალითი უშუალო თემაზე", author: "ნანა/სანდრო", isBorrowed: false)
    let book3 = Book(bookID: 3, title: "როგორ მოვიგოთ გამსწორებლის გული", author: "გიორგი", isBorrowed: false)
    let book4 = Book(bookID: 4, title: "როგორ მეძინება", author: "გიორგი.ხ", isBorrowed: false)

    let owner1 = Owner(ownerId: 1, name: "გიორგი", borrowedBooks: [])
    let owner2 = Owner(ownerId: 2, name: "ანი", borrowedBooks: [])

    let library = Library(books: [book1, book2, book3, book4], owners: [owner1, owner2])

    if library.allowBorrowBook(owner: owner1, book: book1) {
        print("გიორგიმ ბიბლიოთეკიდან წაიღო: \(book1.title)")
    }

    print("----------------------")
    
    if library.allowBorrowBook(owner: owner2, book: book2) {
        print("ანიმ ბიბლიოთეკიდან წაიღო: \(book2.title)")
    }
    print("----------------------")
    
    print("ბიბლიოთეკიდან წაღებული წიგნები:")
    for book in library.findBorrowedBooks() {
        print("- \(book.title)")
    }
    print("----------------------")
    
    print("ბიბლიოთეკაში დარჩენილი წიგნები:")
    for book in library.findAvailableBooks() {
        print("- \(book.title)")
    }
    print("----------------------")
    if let john = library.findOwnerById(ownerId: 1) {
        print("გიორგის მიერ წაღებული წიგნები ბიბლიოთეკიდან:")
        for book in library.findBooksByOwner(owner: john) {
            print("- \(book.title)")
        }
    }
}
  
result(for: "მაღაზია") {
    
    class Product {
        
        let productID: Int
        let name: String
        let price: Double
        
        init(productID: Int, name: String, price: Double) {
            self.productID = productID
            self.name = name
            self.price = price
        }
    }
    
    class Cart {
        let cartID: Int
        var items: [Product]
        
        init(cartID: Int, items: [Product]) {
            self.cartID = cartID
            self.items = items
        }
        
        func addProduct(product: Product) {
            items.append(product)
        }
        
        func removeProduct(productID: Int) {
            items.removeAll(where: { $0.productID == productID })
        }
        
        func calculateTotalPrice() -> Double {
            var totalPrice = 0.0
            for item in items {
                totalPrice += item.price
            }
            return totalPrice
        }
    }
    
    class User {
        let userID: Int
        let username: String
        var cart: Cart
        
        init(userID: Int, username: String, cart: Cart) {
            self.userID = userID
            self.username = username
            self.cart = cart
        }
        
        func addProductToCart(product: Product) {
            cart.addProduct(product: product)
        }
        
        func removeProductFromCart(productID: Int) {
            cart.removeProduct(productID: productID)
        }
        
        func checkout() -> Double {
            let totalPrice = cart.calculateTotalPrice()
            cart.items.removeAll()
            return totalPrice
        }
    }

    //სიმულაცია

    let product1 = Product(productID: 1, name: "TV", price: 1000)
    
    let product2 = Product(productID: 2, name: "MacBook Pro", price: 4500)
    
    let product3 = Product(productID: 3, name: "AppleWatch", price: 230)
    
    let product4 = Product(productID: 4, name: "Iphone", price: 1300)

    let cart1 = Cart(cartID: 1, items: [])
    
    let user1 = User(userID: 1, username: "გიორგი", cart: cart1)
    
    let cart2 = Cart(cartID: 2, items: [])
    
    let user2 = User(userID: 2, username: "ანა", cart: cart2)

    user1.addProductToCart(product: product1)
    
    user1.addProductToCart(product: product2)
    
    user2.addProductToCart(product: product3)
   
    user2.addProductToCart(product: product4)
  
    print("ორივე მომხმარებლის კალათების საერთო გადასახდელი თანხა:", user1.cart.calculateTotalPrice() + user2.cart.calculateTotalPrice())

    print("---------------------------------------------")
    
    let totalPrice1 = user1.checkout()

    let totalPrice2 = user2.checkout()
    

    print("გადასახდელი თანხა \(user1.username)-სთვის: $\(totalPrice1)")

    print("გადასახდელი თანხა \(user2.username)-სთვის: $\(totalPrice2)")

    print("---------------------------------------------")
    
    print("მოხმარებლებმა გადაიხადეს თანხა და გააცარიელეს კალათები")
    
    user1.removeProductFromCart(productID: 1)
    
    user1.removeProductFromCart(productID: 2)
    
    user2.removeProductFromCart(productID: 3)
    
    user2.removeProductFromCart(productID: 4)
    
    print("---------------------------------------------")
    
    print("გიორგის კალათა: \(user1.cart.items)")
    
    print("ანას კალათა: \(user1.cart.items)")
    
    
    
}
