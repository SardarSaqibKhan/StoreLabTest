//
//  AllImagesVC.swift
//  challange
//
//  Created by sardar saqib on 06/01/2023.
//

import UIKit

class AllImagesVC: UIViewController {
    
   @IBOutlet weak var imagesCollectionView:UICollectionView!
    
    var viewModel = AllImagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.collectionViewWidth = self.imagesCollectionView.frame.width
    }


}
extension AllImagesVC {
    func setupView(){
        self.navigationController?.isNavigationBarHidden = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.prefetchDataSource = self
        viewModel.delegate = self
        viewModel.getAllImages()
    }
}
extension AllImagesVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.register(AllImagesCollectionViewCell.self, indexPath: indexPath)
        cell.configCell(imageURL: viewModel.allImages[indexPath.row].downloadUrl ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let refVC = ImageDetailVC()
        refVC.viewModel.imageDetails = viewModel.allImages[indexPath.row]
        self.navigationController?.pushViewController(refVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth : CGFloat = (collectionView.frame.width / CGFloat(viewModel.numberOfCellInRow)) - 1
        let totalHeight : CGFloat = viewModel.collectionViewCellHeight
        
        return CGSizeMake(ceil(totalWidth), ceil(totalHeight))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0 // Adjust the inter item space based on the requirement.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return viewModel.collectionviewLineSpacing
    }
}
// MARK: ---- VIEWMODELE DELEGATES ----
extension AllImagesVC:AllImagesViewToVMDelegate{
    func didRecieveImages() {
        self.imagesCollectionView.reloadData()
    }
    
    func didFailedToRecieveImages(error: String) {
        self.showAlertMessage(message: error)
    }
}
// MARK: ---- LOADING MORE IMAGES  ----
extension AllImagesVC:UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getAllImages()
        }
        
       
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.allImages.count - 6
      }
}
