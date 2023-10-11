import UIKit
import Foundation


class SuperEnemy {
    var name: String
    var hitPoints: Int
    
    init(name: String, hitPoints: Int) {
        self.name = name
        self.hitPoints = hitPoints
    }
}

protocol Superhero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get }
    
    func attack(target: SuperEnemy) -> Int
    func performSuperPower(target: SuperEnemy) -> Int
}


extension Superhero {
    func printSuperheroInfo() {
        print("Name: \(name)")
        print("Alias: \(alias)")
        print("Is Evil: \(isEvil)")
        print("Superpowers: \(superPowers)")
    }
}
struct Lobiani: Superhero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String: Int]
    
    func attack(target: SuperEnemy) -> Int {
        let damage = Int.random(in: 20...40)
        target.hitPoints -= damage
        return target.hitPoints
    }
    
    func performSuperPower(target: SuperEnemy) -> Int {
        let sortedPowers = superPowers.sorted { $0.value > $1.value }
        guard let (power, damage) = sortedPowers.first else { return target.hitPoints }
        target.hitPoints -= damage
        var updatedPowers = superPowers
        updatedPowers.removeValue(forKey: power)
        return target.hitPoints
    }
}

struct LobianiLorit: Superhero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String: Int]
    
    func attack(target: SuperEnemy) -> Int {
        let damage = Int.random(in: 20...40)
        target.hitPoints -= damage
        return target.hitPoints
    }
    
    func performSuperPower(target: SuperEnemy) -> Int {
        let sortedPowers = superPowers.sorted { $0.value > $1.value }
        guard let (power, damage) = sortedPowers.first else { return target.hitPoints }
        target.hitPoints -= damage
        var updatedPowers = superPowers
        updatedPowers.removeValue(forKey: power)
        return target.hitPoints
    }
}

class SuperheroSquad<T: Superhero> {
    var superheroes: [T]
    
    init(superheroes: [T]) {
        self.superheroes = superheroes
    }
    
    func listSuperheroes() {
        for hero in superheroes {
            hero.printSuperheroInfo()
        }
    }
}


extension SuperheroSquad {
    func simulateShowdown(enemy: SuperEnemy) {
        var enemyHitPoints = enemy.hitPoints
        var heroesWithPowers = superheroes
        
        while enemyHitPoints > 0 && !heroesWithPowers.isEmpty {
            let heroIndex = Int.random(in: 0..<heroesWithPowers.count)
            let hero = heroesWithPowers[heroIndex]
            
            if !hero.superPowers.isEmpty {
                enemyHitPoints = hero.performSuperPower(target: enemy)
                heroesWithPowers[heroIndex] = hero
            } else {
                enemyHitPoints = hero.attack(target: enemy)
                heroesWithPowers.remove(at: heroIndex)
            }
            
            print("ხაჭაპურის სიცოცხლე: \(enemyHitPoints)")
            print("-----------------------------")
            if enemyHitPoints >= 0 {
                print("ლობიანის გუნდმა შეუტია")
            }
            
    }
        
        if enemyHitPoints <= 0 {
            print("ლობიანის გუნდმა გაიმარჯვა!")
        } else {
            print("ხაჭაპურმა გაიმარჯვა!")
        }
    }
}



let enemy = SuperEnemy(name: "ხაჭაპური", hitPoints: 100)
let lobiani = Lobiani(name: "ლობიანი", alias: "ლობიანის-გუნდი", isEvil: false, superPowers: ["ლობიოს სროლა": 30])
let lobianiLorit = LobianiLorit(name: "ლობიანი-ლორით", alias: "ლობიანის-გუნდი", isEvil: false, superPowers: ["ლორით განადგურება": 20])

let squad = SuperheroSquad(superheroes: [lobiani])
squad.simulateShowdown(enemy: enemy)


