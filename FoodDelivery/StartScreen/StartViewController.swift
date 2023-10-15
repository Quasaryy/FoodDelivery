//
//  StartViewController.swift
//  FoodDelivery
//
//  Created by Yury on 08.10.23.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: StartViewControllerViewModelProtocol = StartViewControllerViewModel() // ViewModel для управления данными
    let cellsInRow: CGFloat = 1 // Количество ячеек в строке
    let sectionInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) // Отступы между ячейками
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Загрузка данных из ViewModel и обновление коллекции при завершении загрузки
        viewModel.fetchData {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - Methods
extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCategories() // Количество категорий для отображения
    }
    
    // MARK: Создание и настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenCell", for: indexPath) as? StartCollectionViewCell else { return UICollectionViewCell() }
        
        if let category = viewModel.category(at: indexPath.item) {
            let cellViewModel = StartCollectionViewCellViewModel(category: category)
            cell.configure(with: cellViewModel)
        }
        
        return cell
    }
    
    // MARK: Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        let cellSize: CGFloat = (availableWidth - sectionInsets.left * (cellsInRow + 1)) / cellsInRow
        let size = CGSize(width: cellSize, height: 148)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.top
    }
    
    // MARK: Обработка выбора ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = viewModel.category(at: indexPath.row)
        performSegue(withIdentifier: "toMenu", sender: selectedCategory)
    }
    
}

// MARK: - Navigation
extension StartViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenu",
           let destination = segue.destination as? SecondViewController,
           let selectedCategory = sender as? Category {
            destination.viewModel.setCategoryName(selectedCategory.name)
        }
    }
    
}
