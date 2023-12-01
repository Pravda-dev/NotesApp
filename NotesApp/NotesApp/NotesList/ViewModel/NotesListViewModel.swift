//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by pravda on 27.11.2023.
//

import UIKit

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    private(set) var section: [TableViewSection] = []
    
    init() {
        getNotes()
        setMocks()
    }
    
    private func getNotes() {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "1 december 2023", 
                                       items: [
                                        Note(title: "First title note",
                                             description: "First note description",
                                             date: Date(),
                                             imageURL: nil,
                                             image: nil),
                                        Note(title: "Second title note",
                                             description: "Second note description",
                                             date: Date(),
                                             imageURL: nil,
                                             image: nil)
                                       ])
        
        self.section = [section]
    }
}
