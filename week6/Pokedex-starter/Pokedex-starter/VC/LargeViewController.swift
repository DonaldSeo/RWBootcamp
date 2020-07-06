/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class LargeViewController: UIViewController {
  
  
  @IBOutlet weak var largeCollectionView: UICollectionView!
  let pokemons = PokemonGenerator.shared.generatePokemons()
  
  let dataSource = HorizontalCVDataSource()
  let delegate = HorizontalCVDelegate(interItemSpacing: 5)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let pokemonLargeCell = UINib(nibName: "PokemonLargeCell", bundle: nil)
    largeCollectionView.register(pokemonLargeCell, forCellWithReuseIdentifier: PokemonLargeCell.reuseIdentifier)
    largeCollectionView.dataSource = dataSource
    largeCollectionView.delegate = delegate
    
    
  }
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    guard tabBarController?.selectedIndex == 1 else { return }
    
    if UIDevice.current.orientation.isLandscape{
      guard let layout = largeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
        fatalError("nil unwrapping")
        }
        let (maxWidth, maxHeight) = setupCollectionViewCell()
        layout.itemSize = CGSize(width: maxWidth*0.60, height: maxHeight*0.7)
        layout.invalidateLayout()
    } else if UIDevice.current.orientation.isPortrait {
      guard let layout = largeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
        fatalError("nil unwrapping")
      }
      let (maxWidth, maxHeight) = setupCollectionViewCell()
      layout.itemSize = CGSize(width: maxWidth*0.85, height: maxHeight*0.7)
      layout.invalidateLayout()
      }
  }

  func setupCollectionViewCell() -> (CGFloat, CGFloat) {
    let maxWidth = UIScreen.main.bounds.width
    let maxHeight = UIScreen.main.bounds.height
    return (maxWidth, maxHeight)
  }
  
}

