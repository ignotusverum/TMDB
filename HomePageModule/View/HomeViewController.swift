//
//  HomeViewController.swift
//  HomePageModule
//
//  Created by Giuseppe Lanza on 26/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import RxDataSources

extension Movie: IdentifiableType {
    public var identity: Int64 { return id }
}

class HomeViewController: UIViewController, Themed, UICollectionViewDelegateFlowLayout {
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    lazy var collectionView = { UICollectionView(frame: .zero, collectionViewLayout: layout) }()
    
    let disposeBag = DisposeBag()
    let viewModel: HomePageViewModelProtocol
    
    let dataSource: RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, Movie>>
    
    init(with viewModel: HomePageViewModelProtocol) {
        self.viewModel = viewModel
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(configureCell: { dataSource, collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
            cell.setup(show: movie)
            cell.applyTheme()
            return cell
        })
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        collectionView.register(
            UINib(nibName: "PostCollectionViewCell",
                  bundle: Bundle(for: HomeViewController.self)
            ), forCellWithReuseIdentifier: "PostCollectionViewCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.refreshControl = UIRefreshControl()
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        applyTheme()
    }
    
    func bindViewModel() {
        let viewDidAppear = rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .toVoid()
        
          let pull = collectionView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .toVoid()
        
        let reload = Observable.merge(viewDidAppear,
                                      pull)
            .map { _ in  HomePageUIAction.reload}
        
        let states = viewModel.transform(input: Observable.merge([
            Observable.combineLatest(
                collectionView.rx.contentOffset.map { $0.y },
                collectionView.rx.observe(CGSize.self, "contentSize")
                    .compactMap { $0?.height }
            ).map { [weak self] (y, h) in
                    guard let self = self,
                        (h - self.collectionView.bounds.height) >= (y - 100) else {
                            return false
                    }
                    return true
            }
            .distinctUntilChanged()
                .takeTrue()
                .map { _ in HomePageUIAction.nextPage },
            collectionView.rx.modelSelected(Movie.self)
                .map(HomePageUIAction.selectMovie),
            reload
        ])).publish()
        
        Observable.merge(
            states.capture(case: HomePageState.shows).map { movies, _ in
                movies
            },
            Observable.merge(
                states.capture(case: HomePageState.error).map { _, prevState in prevState },
                states.capture(case: HomePageState.loading).map { _, prevState in prevState }
            ).compactMap { prevState in
                guard case let HomeOverlayCases.shows(movies, _) = prevState else {
                    return nil
                }
                return movies
            }
        ).map { movies in
            [AnimatableSectionModel(model: "", items: movies)]
        }
        .asDriverIgnoreError() // it will always perform on the main thread, ignore errors to keep the stream alive
        .drive(collectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
            states.exclude(case: HomePageState.loading).toVoid()
            .asDriverIgnoreError()
            .drive(onNext: { [weak self] _ in
                self?.collectionView.refreshControl?.endRefreshing()
            })
        .disposed(by: disposeBag)
        
        
        states.capture(case: HomePageState.error)
            .asDriverIgnoreError()
            .drive(onNext: { [weak self] error, _ in
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                    print("dismiss yo")
                }))
                self?.present(alert, animated: true)
            }).disposed(by: disposeBag)

        states.connect().disposed(by: disposeBag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular) where collectionView.bounds.width < 900:
            columns = 2
        case (.regular, .regular) where collectionView.bounds.width <= 1024:
            columns = 3
        case (.regular, .regular): columns = 4
        default: columns = 1
        }
        
        let target = CGSize(width: (collectionView.bounds.width - (columns * 10) - 10) / columns,
                            height: 400)
        return target
    }
    
    func applyTheme() {
        collectionView.backgroundColor = .color(forPalette: .lightGray)
        collectionView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.invalidateLayout()
        coordinator.animate(alongsideTransition: { (_) in
            self.layout.invalidateLayout()
        })
    }
}
