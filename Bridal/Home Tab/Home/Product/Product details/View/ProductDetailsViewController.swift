//
//  ProductDetailsViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addedByLabel: UILabel!
    @IBOutlet weak var supTitleLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentView: UIImageView!
    //Slide Show
      var timer = Timer()
      var counter = 0
      var flage = true
    //----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        startSlideShow()
        titleLabel.text = DataServices.selectedProduct!.title
        supTitleLabel.text = DataServices.selectedProduct!.supTitle
        priceLabel.text = DataServices.selectedProduct!.price
        categoryLabel.text = DataServices.selectedProduct!.categoryName
        addedByLabel.text = DataServices.selectedProduct!.userName
        //addedByLabel.text = selectedProduct!.userId
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        
        productImagesCollectionView.layer.borderWidth = 1
        productImagesCollectionView.layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addToFavoriteButtonClicked(_ sender: Any) {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
    }
    
    
    func startSlideShow(){
          //SlideView
         
          DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
          }
      }
    @objc func changeImage(){
        if counter == DataServices.selectedProduct!.imagesStringURL.count {
               flage = false
               counter -= 1
               
           }else if counter == 0 {
               flage = true
           }
           if flage {
               let index = IndexPath(item: counter , section: 0)
               self.productImagesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              // self.pageControler.currentPage = counter
               counter += 1
           }else {
               let index = IndexPath(item: counter , section: 0)
               self.productImagesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              // self.pageControler.currentPage = counter
               counter -= 1
           }
           
       }
}

extension ProductDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServices.selectedProduct!.imagesStringURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as! ProductImagesCollectionViewCell
        cell.setImage(index: indexPath.row)
        cell.productImageView.frame = CGRect(x: 0, y: 0, width: productImagesCollectionView.frame.width, height: productImagesCollectionView.frame.height)
        return cell
    }
    

    
}
