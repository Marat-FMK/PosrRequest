//
//  NetworkManager.swift
//  PosrRequest
//
//  Created by Marat Fakhrizhanov on 30.07.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(with data: Man, to url: String, completion: @escaping (Result< Man,NetworkError >) -> Void ) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard let manData = try? JSONEncoder().encode(data) else { // кодируем нашу модель в джейсон
            completion(.failure(.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //- отправка на сервер пишется всегдв
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")//-пишется опционально если в респонсе приходит неправильный отыет ключ/значение , ищем поле "Content-Type" и прописываем что там написано
        request.httpBody = manData // передавем всегда - та самая дата которую закодировали из модели
        
        URLSession.shared.dataTask(with: request) { data, response, error in //Если  нужно просто отправить на сервер не возвращая данных , то замыкание необязательно// отправляем запрос и раскрываем замыкание что бы увидеть ответ сервера и обработать ошибки и вывести дату где то далее во вьюхе
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                return
            }
            print(response) //выводим респонс на консоль смотим на код ответа и контент тайп(если неверно сохранил сервер)
            
            do {
                let man = try JSONDecoder().decode(Man.self, from: data)
                completion(.success(man))
            }catch {
                completion(.failure(.decodinError))
            }
            
        }.resume()
    }
    
}
