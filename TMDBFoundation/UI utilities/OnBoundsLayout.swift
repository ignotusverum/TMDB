//
//  OnBoundsLayout.swift
//  moVimento
//
//  Created by Giuseppe Lanza on 11/09/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit

public class OnBoundsChangedInvalidatedLayout: UICollectionViewFlowLayout {
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView?.bounds.size != newBounds.size
    }
    
    public override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = UICollectionViewFlowLayoutInvalidationContext()
        context.invalidateFlowLayoutDelegateMetrics = true
        return context
    }
}
