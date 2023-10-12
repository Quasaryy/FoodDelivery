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
    var selectedTag: Teg = .allMenu
    var selectedTagIndex: Int = 0
    let activeCell = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1)
    let inactiveCell = UIColor(red: 248/255, green: 247/255, blue: 245/255, alpha: 1)
    var currentCollectionViewType: CollectionViewType?
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData {
            self.horizontalCollectionView.reloadData()
            self.verticalCollectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return viewModel.numberOfTags()
        } else if collectionView == verticalCollectionView {
            return viewModel.filteredDishes(forTag: selectedTag).count
        }
        return 0
    }
    
    // MARK: Creating and casting the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentType: CollectionViewType = (collectionView == horizontalCollectionView) ? .horizontal : .vertical
        var cell: UICollectionViewCell?
        
        switch currentType {
            case .horizontal:
                if let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? SecondHorizontalCollectionViewCell, let tag = viewModel.tag(at: indexPath.item) {
                    let cellViewModel = SecondHorizontalCollectionViewCellViewModel(tag: tag)
                    tagCell.configure(with: cellViewModel)
                    
                    // Устанавливаем цвет фона для активной и неактивной ячейки
                    if indexPath.item == selectedTagIndex {
                        tagCell.backgroundColor = activeCell
                        tagCell.foodTag.textColor = .white
                    } else {
                        tagCell.backgroundColor = inactiveCell
                        tagCell.foodTag.textColor = .black
                    }
                    
                    cell = tagCell
                }
                
            case .vertical:
                if let foodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? SecondVerticallCollectionViewCell, let dish = viewModel.dish(at: indexPath.item) {
                    let cellViewModel = SecondVerticalCollectionViewCellViewModel(dish: dish)
                    foodCell.configure(with: cellViewModel)
                    cell = foodCell
                }
        }
        
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegate

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        if collectionView == horizontalCollectionView {
            if let tag = viewModel.tag(at: indexPath.item) {
                selectedTag = tag
                selectedTagIndex = indexPath.item // Обновляем выбранный индекс
                horizontalCollectionView.reloadData() // Перезагружаем, чтобы обновить цвета ячеек
                verticalCollectionView.reloadData()
            }
        }
    }
    
}
