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
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    // MARK: - Properties
    let cellsInRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8)
    var viewModel: SecondViewModelProtocol = SecondViewControllerViewModel()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData {
            self.horizontalCollectionView.reloadData()
            self.verticalCollectionView.reloadData()
        }
    }

}

// MARK: - Methods

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return viewModel.numberOfTags()
            } else if collectionView == verticalCollectionView {
                return viewModel.numberOfDishes()
            }
            return 0
    }
    
    // MARK: Creating and casting the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? SecondHorizontalCollectionViewCell else { return UICollectionViewCell() }
            
            if let tag = viewModel.tag(at: indexPath.item) {
                let cellViewModel = SecondHorizontalCollectionViewCellViewModel(tag: tag)
                tagCell.configure(with: cellViewModel)
            }
            return tagCell
            
        } else if collectionView == verticalCollectionView {
            guard let foodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? SecondVerticallCollectionViewCell else { return UICollectionViewCell() }
            
            if let dish = viewModel.dish(at: indexPath.item) {
                let cellViewModel = SecondVerticalCollectionViewCellViewModel(dish: dish)
                foodCell.configure(with: cellViewModel)
            }
            return foodCell
        }
        
        return UICollectionViewCell() // Эта строка будет выполнена только в случае, если ни одно из условий выше не выполнится, что в вашем случае маловероятно.
    }
    
    // MARK: Cell size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView {
            if let tag = viewModel.tag(at: indexPath.item) {
                let cellViewModel = SecondHorizontalCollectionViewCellViewModel(tag: tag)
                
                // Вычисляем размер текста
                let size = cellViewModel.tagName.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)])
                
                // Добавляем дополнительные отступы
                let padding: CGFloat = 33.0
                let widthWithPadding = size.width + padding
                return CGSize(width: widthWithPadding, height: 35)
            }
        }
        if collectionView == verticalCollectionView {
            let availableWidth = collectionView.frame.width // ширина экрана
            let cellSize: CGFloat = (availableWidth - sectionInsets.left * (cellsInRow + 1)) / cellsInRow
            let size = CGSize(width: cellSize, height: 154)
            return size
        }
        
        return CGSize(width: 50, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "toMenu", sender: nil)
    }
    
}
