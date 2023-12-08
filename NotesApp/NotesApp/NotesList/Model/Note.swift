//
//  Note.swift
//  NotesApp
//
//  Created by pravda on 27.11.2023.
//

import UIKit

struct Note: TableViewItemProtocol {
    let title: String
    let description: String?
    let date: Date
    let imageURL: URL?
    let image: Data? = nil
//    let category: NoteCategory?
}

//enum NoteCategory {
//    case personal
//    case work
//    case study
//    case other
//
//    var color: UIColor {
//        switch self {
//        case .personal:
//            return .blue
//        case .work:
//            return .orange
//        case .study:
//            return .green
//        case .other:
//            return .gray
//        }
//    }
//}

