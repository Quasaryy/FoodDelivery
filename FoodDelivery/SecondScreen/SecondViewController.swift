//
//  SecondViewController.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var viewModel: SecondViewModelProtocol = SecondViewControllerViewModel()
    let cellsInRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData {
            self.horizontalCollectionView.reloadData()
        }
    }
    
}

// MARK: - Methods

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfTags()
    }
    
    // MARK: Creating and casting the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
        
        if let tag = viewModel.tag(at: indexPath.item) {
                let cellViewModel = SecondCollectionViewCellViewModel(tag: tag)
                cell.configure(with: cellViewModel)
            }
        
        return cell
    }
    
    // MARK: Cell size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let tag = viewModel.tag(at: indexPath.item) {
            let cellViewModel = SecondCollectionViewCellViewModel(tag: tag)
            
            // Вычисляем размер текста
            let size = cellViewModel.tagName.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)])
            
            // Добавляем дополнительные отступы
            let padding: CGFloat = 32.0 // 16 (слева) + 16 (справа)
            let widthWithPadding = size.width + padding
            return CGSize(width: widthWithPadding, height: 35) // 30 или другое значение для высоты
        }
        
        return CGSize(width: 50, height: 35) // минимальный размер по умолчанию
    }

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        sectionInsets.top
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "toMenu", sender: nil)
    }
    
}
