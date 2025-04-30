//
//  FacetedBuilder.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 14/4/25.
//


class Person {
    // address
    var streetAdrees = "", postCode = "", city = ""
    // employment
    var companyName = "", position = "", annualIncome = 0
}

class PersonBuilder {
    var person = Person()
    func build() -> Person { person }
    func lives() -> PersonAddressBuilder {
        PersonAddressBuilder(person: person, parent: self)
    }
    func works() -> PersonEmploymentBuilder {
        PersonEmploymentBuilder(person: person, parent: self)
    }
}

class PersonEmploymentBuilder {
    let person: Person
    let parent: PersonBuilder
    init(person: Person, parent: PersonBuilder) {
        self.person = person
        self.parent = parent
    }
    func at(_ companyName: String) -> Self {
        person.companyName = companyName
        return self
    }
    func asA(_ position: String) -> Self {
        person.position = position
        return self
    }
    func earning(_ annualIncome: Int) -> Self {
        person.annualIncome = annualIncome
        return self
    }
    func lives() -> PersonAddressBuilder {
        parent.lives()
    }
    func build() -> Person {
        parent.build()
    }
}

class PersonAddressBuilder {
    let person: Person
    let parent: PersonBuilder
    init(person: Person, parent: PersonBuilder) {
        self.person = person
        self.parent = parent
    }
    func at(_ streetAdrees: String) -> Self {
        person.streetAdrees = streetAdrees
        return self
    }
    func withPostCode(_ postCode: String) -> Self {
        person.postCode = postCode
        return self
    }
    func inCity(_ city: String) -> Self {
        person.city = city
        return self
    }
    func works() -> PersonEmploymentBuilder {
        parent.works()
    }
    func build() -> Person {
        parent.build()
    }
}

class PersonBuilderClient {
    func main() {
        let personBuilder = PersonBuilder()
        let _ = personBuilder
            .lives()
                .at("Calle 12 # 34 - 56")
                .inCity("Medellín")
            .works()
                .asA("Ingeniero")
                .earning(1234)
            .build()
    }
}
