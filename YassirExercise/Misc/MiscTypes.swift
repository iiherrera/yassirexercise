//
//  MiscTypes.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/27/23.
//

import SwiftUI

// We use this struct to carry the alert info and to be reacted to when published
struct IdentifiableAlert: Identifiable {
    let id = UUID()
    var alertText: LocalizedStringKey = ""
    var alertTitle: LocalizedStringKey = ""
    var buttonTitle: LocalizedStringKey = ""
    var action: ()->() = {}
    
    // Generates the alert object based on the properties of the struct
    var builtAlert: Alert {
        Alert(title: Text(self.alertTitle), message: Text(self.alertText), dismissButton: .default(Text(self.buttonTitle)) {
            self.action()
        })
    }
}
