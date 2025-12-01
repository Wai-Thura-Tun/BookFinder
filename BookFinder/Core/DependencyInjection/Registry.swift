//
//  Registry.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 1/11/2568 BE.
//

import Foundation

extension Resolver {
    func registerDependencies() {
        
        // MARK: - Singletons
        self.register(KeychainManager.self, .singleton) {
            KeychainManagerImpl()
        }
        
        self.register(SessionManager.self, .singleton) {
            let keychainManager = Resolver.shared.resolve(KeychainManager.self)
            return SessionManagerImpl(keychainManager: keychainManager)
        }
        
        self.register(NetworkInterceptor.self, .singleton) {
            let keychainManager = Resolver.shared.resolve(KeychainManager.self)
            let sessionManager = Resolver.shared.resolve(SessionManager.self)

            return NetworkInterceptorImpl(
                keychainManager: keychainManager,
                sessionManager: sessionManager
            )
        }
        
        self.register(NetworkManager.self, .singleton) {
            let networkInterceptor = Resolver.shared.resolve(NetworkInterceptor.self)
            return NetworkManagerImpl(interceptor: networkInterceptor)
        }
        
        self.register(ImageDownloader.self, .singleton) {
            return ImageDownloaderImpl()
        }
        
        // MARK: - Trasient class
        
        self.register(AuthRepository.self) {
            let keychainManager = Resolver.shared.resolve(KeychainManager.self)
            let networkManager = Resolver.shared.resolve(NetworkManager.self)
            return AuthRepositoryImpl(
                network: networkManager,
                keychain: keychainManager
            )
        }
        
        
        // MARK: - Login
        self.register(LoginUseCase.self) {
            let authRepository = Resolver.shared.resolve(AuthRepository.self)
            return LoginUseCaseImpl(authRepository: authRepository)
        }
        
        self.register(LoginVM.self) {
            let loginUseCase = Resolver.shared.resolve(LoginUseCase.self)
            return LoginVM(loginUseCase: loginUseCase)
        }
        
        // MARK: - Book List
        
        self.register(BookRepository.self) {
            let networkManager = Resolver.shared.resolve(NetworkManager.self)
            return BookRepositoryImpl(network: networkManager)
        }
        
        self.register(FetchBooksUseCase.self) {
            let bookRepository = Resolver.shared.resolve(BookRepository.self)
            return FetchBooksUseCaseImpl(bookRepository: bookRepository)
        }
        
        self.register(SearchBooksUseCase.self) {
            return SearchBooksUseCaseImpl()
        }
        
        self.register(BookListVM.self) {
            let fetchBooksUseCase: FetchBooksUseCase = Resolver.shared.resolve(FetchBooksUseCase.self)
            let searchBooksUseCase: SearchBooksUseCase = Resolver.shared.resolve(SearchBooksUseCase.self)
            
            return BookListVM(
                fetchBooksUseCase: fetchBooksUseCase,
                searchBooksUseCase: searchBooksUseCase
            )
        }
    }
}
