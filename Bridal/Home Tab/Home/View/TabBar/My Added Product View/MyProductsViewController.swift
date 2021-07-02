//
//  MyProductsViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 01/07/2021.
//

import UIKit
import Firebase

class MyProductsViewController: UIViewController {
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var products = [Product]()
    var currentProductID = ""
    var currentProductIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTableView.delegate = self
        productsTableView.dataSource = self
        if products.count == 0 {
            loadingIndicator.startAnimating()
        DataServices.instance.getProducts(by: "userId", value: Auth.auth().currentUser!.uid ) {[weak self] (products) in
                if products.count > 0 {
                    print("product found")
                    self!.products = products
                    DispatchQueue.main.async {
                        self!.productsTableView.reloadData()
                    }
                    self!.loadingIndicator.stopAnimating()
                }
            
            }
            
        }
        
    }

    @IBAction func addProductButtonClicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "AddProductViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "AddProductViewController") as? AddProductViewController  else {
            return
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}

extension MyProductsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductsTableViewCell else {return UITableViewCell()}
        cell.configurCell(product: products[indexPath.row])
        self.currentProductID = products[indexPath.row].productID
        self.currentProductIndex = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteProduct), for: .touchUpInside)
    
        return cell
    }
    @objc func deleteProduct(){
        DataServices.instance.deleteProduct(Id: currentProductID)
        products.remove(at: currentProductIndex)
        productsTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataServices.selectedProduct = products[indexPath.row]
        
         let mainStoryboard = UIStoryboard(name: "ProductDetailsViewController", bundle: nil)
         guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "ProductDetailsViewController") as? ProductDetailsViewController  else {
             return
         }
         navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.productsTableView.frame.height / 5
        
    }
}
