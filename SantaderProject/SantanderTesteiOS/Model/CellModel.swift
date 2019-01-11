//
//  CellModel.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 14/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation

struct CellModel : Decodable{
    var cells : [CellMiniModel]?
}

struct CellMiniModel : Decodable{
    var id : Int32?
    var type : Int32?
    var message : String?
    var typefield : QuantumValue?
    var hidden : Bool?
    var topSpacing : Double?
    var show : Int32?
    var required : Bool?
}

struct CellModell<T>{
    var typefield : T?
}

//MARK : enum criado por causa da propriedade 'typefield' que as vezes é String ou Int
enum QuantumValue: Decodable {
    
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        //MARK : Faz ums cast e verifica se a propriedade e Int ou String caso for converte para o seu devido valor e seta na propriedade
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}
