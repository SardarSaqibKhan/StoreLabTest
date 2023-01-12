//
//  AllImagesViewModel.swift
//  challange
//
//  Created by sardar saqib on 07/01/2023.
//

import Foundation

class AllImagesViewModel{
    
    var collectionViewWidth = CGFloat()
    var collectionViewCellHeight:CGFloat = 100
    var numberOfCellInRow:CGFloat = 3
    var collectionviewLineSpacing:CGFloat = 2
    var currentPage = 1
    var limit = 30
    var isDownloadingInProgress = false
    
    weak var delegate:AllImagesViewToVMDelegate?
    var allImages = [AllImagesModel]()
    
    func getAllImages(){
        guard !isDownloadingInProgress else{
            return
        }
        isDownloadingInProgress = true
        let parameters = "page=\(currentPage)&limit=\(limit)"
        NetworkClient.shared.getRequest(EndPoints.BASE_URL + parameters, parameters: nil, headers: nil,  checkInternetConnectivity: true, showLoader: currentPage == 1 ? true:false) { [weak self] (imagesResponse:[AllImagesModel]) in
            self?.isDownloadingInProgress = false
            self?.allImages.append(contentsOf: imagesResponse)
            print("🚀🔥🚀 Called Page NO : \(self?.currentPage ?? 0)")
            self?.currentPage += 1
            self?.delegate?.didRecieveImages()
            
        } failure: { err in
            self.isDownloadingInProgress = false
            self.delegate?.didFailedToRecieveImages(error: err)
        }

    }
    
}
// MARK: --- VIEW TO VIEW MODEL DELEGATES -----
protocol AllImagesViewToVMDelegate:AnyObject{
    func didRecieveImages()
    func didFailedToRecieveImages(error:String)
}
