//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by pravda on 27.11.2023.
//

import UIKit

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    
    func getNotes()
}

final class NotesListViewModel: NotesListViewModelProtocol {
    var reloadTable: (() -> Void)?

    private(set) var section: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    
    init() {
        getNotes()
    }
    
    func getNotes() {
        let notes = NotePersistent.fetchAll()
        section = []
        
        let groupedObjects = notes.reduce(into: [Date: [Note]]()) { result, note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
        }
        let keys = groupedObjects.keys
        
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let stringDate = dateFormatter.string(from: key)
            
            section.append(TableViewSection(title: stringDate,
                                            items: groupedObjects[key] ?? []))
        }
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "1 december 2023", 
                                       items: [
                                        Note(title: "First title note",
                                             description: "First note description",
                                             date: Date(),
                                             imageURL: nil,
                                             category: .personal),
                                        Note(title: "Second title note",
                                             description: "Second note description",
                                             date: Date(),
                                             imageURL: nil,
                                             category: .personal)
                                       ])
        
        self.section = [section]
    }
}
