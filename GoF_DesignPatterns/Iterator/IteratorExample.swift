//
//  IteratorExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 4/2/25.
//

struct Student {
    let name: String
    let age: Int
    let id: String
}

class Course: Sequence {
    private var students: [String: Student]
    init(students: [String: Student]) {
        self.students = students
    }
    func register(student: Student) {
        students[student.id] = student
    }
    func withdraw(student: Student) {
        students[student.id] = nil
    }
    func makeIterator() -> DefaultStudentIterator {
        DefaultStudentIterator(students: students)
    }
    func getStudent(by id: String) -> Student? {
        students[id]
    }
}

class GetStudentByIdUseCase {
    private let course: Course
    private let id: String
    private var result: Student?
    
    init(course: Course, id: String) {
        self.course = course
        self.id = id
    }
    func execute() {
        result = course.getStudent(by: id)
    }
    func getResult() -> Student? { result }
}

class ListAllNamesUseCase {
    private let course: Course
    private var result: String = "Students: \n"
    
    init(course: Course) {
        self.course = course
    }
    func execute() {
        var studentNumber = 0
        for student in course {
            studentNumber += 1
            result += "\(studentNumber). \(student.name)\n"
        }
    }
    func getResult() -> String { result }
}

class DefaultStudentIterator: IteratorProtocol {    
    private var index = 0
    private let students: [Student]
    init(index: Int = 0, students: [String : Student]) {
        self.index = index
        self.students = Array(students.values)
    }
    func next() -> Student? {
        guard index < students.count else {
            return nil
        }
        let result = students[index]
        index += 1
        return result
    }
}
