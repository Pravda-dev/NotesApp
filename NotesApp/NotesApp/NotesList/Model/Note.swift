//
//  Note.swift
//  NotesApp
//
//  Created by pravda on 27.11.2023.
//

import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let description: String
    let date: Date
    let imageURL: String?
    let image: Data?
    
}
