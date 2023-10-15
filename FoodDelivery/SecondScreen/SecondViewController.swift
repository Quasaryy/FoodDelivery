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
    let cellsInRow: CGFloat = 3 // Количество ячеек в строке для вертикальной коллекции
    let sectionInsets = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8) // Отступы для коллекций
    var viewModel: SecondViewControllerViewModelProtocol = SecondViewControllerViewModel() // ViewModel для контроллера
    var selectedTag: Teg = .allMenu // Выбранный тег по умолчанию
    var selectedTagIndex: Int = 0 // Индекс выбранного тега
    let activeCell = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1) // Цвет активной ячейки
    let inactiveCell = UIColor(red: 248/255, green: 247/255, blue: 245/255, alpha: 1) // Цвет неактивной ячейки
    var currentCollectionViewType: CollectionViewType? // Текущий тип коллекции (горизонтальная или вертикальная)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.getCategoryName() // Устанавливаем заголовок на основе категории
        viewModel.fetchData {
            self.horizontalCollectionView.reloadData() // Обновляем горизонтальную коллекцию после загрузки данных
            self.verticalCollectionView.reloadData() // Обновляем вертикальную коллекцию после загрузки данных
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return viewModel.numberOfTags() // Возвращаем количество доступных тегов для горизонтальной коллекции.
        } else if collectionView == verticalCollectionView {
            return viewModel.filteredDishes(forTag: selectedTag).count // Возвращаем количество отфильтрованных блюд для выбранного тега для вертикальной коллекции.
        }
        return 0 // Возвращаем ноль по умолчанию.
    }
    
    // MARK: Creating and casting the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentType: CollectionViewType = (collectionView == horizontalCollectionView) ? .horizontal : .vertical
        var cell: UICollectionViewCell?
        
        switch currentType {
            case .horizontal:
                // Если это горизонтальная коллекция, создаем и конфигурируем ячейку для тега.
                if let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? SecondHorizontalCollectionViewCell, let tag = viewModel.tag(at: indexPath.item) {
                    let cellViewModel = SecondHorizontalCollectionViewCellViewModel(tag: tag)
                    tagCell.configure(with: cellViewModel)
                    
                    // Устанавливаем цвет фона для активной и неактивной ячейки в зависимости от выбранного тега.
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
                // Если это вертикальная коллекция, создаем и конфигурируем ячейку для блюда.
                if let foodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? SecondVerticallCollectionViewCell, let dish = viewModel.dish(at: indexPath.item) {
                    let cellViewModel = SecondVerticalCollectionViewCellViewModel(dish: dish)
                    foodCell.configure(with: cellViewModel)
                    cell = foodCell
                }
        }
        
        return cell ?? UICollectionViewCell() // Возвращаем созданную ячейку или пустую ячейку по умолчанию.
    }
    
}

// MARK: - UICollectionViewDelegate
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView, let tag = viewModel.tag(at: indexPath.item) {
                let cellViewModel = SecondHorizontalCollectionViewCellViewModel(tag: tag)
                
                // Вычисляем размер текста
                let size = cellViewModel.tagName.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)])
                
                // Добавляем дополнительные отступы
                let padding: CGFloat = 33.0
                let widthWithPadding = size.width + padding
                return CGSize(width: widthWithPadding, height: 35)
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
        let currentType: CollectionViewType = (collectionView == horizontalCollectionView) ? .horizontal : .vertical
        
        switch currentType {
            case .horizontal:
                if let tag = viewModel.tag(at: indexPath.item) {
                    selectedTag = tag
                    selectedTagIndex = indexPath.item // Обновляем выбранный индекс
                    horizontalCollectionView.reloadData() // Перезагружаем, чтобы обновить цвета ячеек
                    verticalCollectionView.reloadData()
                }
            case .vertical:
                if let selectedDish = viewModel.dish(at: indexPath.item) {
                    let modalView = ModalWindowManager.shared.presentModalWindow(from: self, dish: selectedDish)
                    modalView?.badgeManager = TabBarBadgeManager(tabBarController: tabBarController)
                    
                    // Здесь устанавливаем обработчик для изменения статуса избранного
                    modalView?.viewModel?.onFavoriteStatusChanged = { [weak self] newFavoriteStatus in
                        self?.viewModel.updateFavoriteStatus(forDishId: selectedDish.id, isFavorite: newFavoriteStatus)
                    }
                    modalView?.parentTabBarController = tabBarController
                }
        }
    }
    
}
