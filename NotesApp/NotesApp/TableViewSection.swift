//
//  TableViewSection.swift
//  NotesApp
//
//  Created by pravda on 27.11.2023.
//

import UIKit

protocol TableViewItemProtocol { }

struct TableViewSection {
    var title: String
    var items: [TableViewItemProtocol]
}
