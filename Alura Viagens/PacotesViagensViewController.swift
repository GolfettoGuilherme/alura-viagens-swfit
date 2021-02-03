//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Guilherme Golfetto on 31/01/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout,
                                    UISearchBarDelegate,
                                    UICollectionViewDelegate{

    //Outlets
    @IBOutlet weak var colecaoPacotesViagem: UICollectionView!
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    @IBOutlet weak var labelContadorDePacotes: UILabel!
    
    //Vars
    let listaComTodasViagens:Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens: Array<PacoteViagem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaViagens = listaComTodasViagens
        colecaoPacotesViagem.dataSource = self //falando que o nosso viewController vai implementar os métodos de DataSource da CollectionView
        colecaoPacotesViagem.delegate = self //falando que esse viewController vai implementar o metodo para ajustar o tamanho das celulas no layout e o click da tela
        pesquisarViagens.delegate = self //falando que esse viewcontroller vai controlar o outlet do UISearchbar
        self.labelContadorDePacotes.text = self.atualizaContadorLabel()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listaViagens.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
        
        let pacoteAtual = listaViagens[indexPath.item]
        
        celulaPacote.configuraCelula(pacoteViagem: pacoteAtual)
        
        return celulaPacote
    }
    
    //ajuste de tamanho de celula
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return UIDevice.current.userInterfaceIdiom == .phone
            ? CGSize(width: collectionView.bounds.width / 2 - 15, height: 160)
            : CGSize(width: collectionView.bounds.width / 3 - 20, height: 250)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //indo para a proxima tela
        
        let pacote = listaViagens[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier:"detalhes") as! DetalhesViagensViewController
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.pacoteSelecionado = pacote
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //o texto mudou no searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaViagens = listaComTodasViagens
        
        if searchText != "" {
            listaViagens = listaViagens.filter{ $0.viagem.titulo.contains(searchText)}
        }
        
        self.labelContadorDePacotes.text = self.atualizaContadorLabel()
        colecaoPacotesViagem.reloadData()
    }
    
    
    //methodos
    func atualizaContadorLabel() -> String {
        return listaViagens.count == 1 ? "1 Pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }
    
}
