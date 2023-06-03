//
//  ViewCode+Protocol.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCode {
    func setupViewCode() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func buildHierarchy() {}
    func setupConstraints() {}
    func applyAdditionalChanges() {}
}


