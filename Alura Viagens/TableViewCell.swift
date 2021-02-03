//
//  TableViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 17/08/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imagemViagem: UIImageView!
    
    func configuraCelula(viagemAtual:Viagem){
        labelTitulo.text = viagemAtual.titulo
        
        labelQuantidadeDias.text = viagemAtual.quantidadeDeDias == 1 ? "1 dia" : "\(viagemAtual.quantidadeDeDias) dias"
        
        labelPreco.text = "R$ \(viagemAtual.preco)"
        imagemViagem.image = UIImage(named: viagemAtual.caminhoDaImagem)
        
        imagemViagem.layer.cornerRadius = 10
        imagemViagem.layer.masksToBounds = true
    }

}
