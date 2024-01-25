//
//  jsonTestFile.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 14.12.2023.
//
import Foundation

let fileName = "downloadedFile.txt"
let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL

// Путь к скачанному TXT файлу
let txtFilePath = documentsUrl.appendingPathComponent(fileName)

// Путь к выходному JSON файлу
let jsonFilePath = "/путь/к/вашему/выходному_файлу.json"

//// Чтение содержимого TXT файла
//do {
//    let txtContent = try String(contentsOfFile: documentsUrl, encoding: .utf8)
//
//    // Разделение строки на массив строк (предполагается, что каждая строка - элемент в JSON массиве)
//    let lines = txtContent.components(separatedBy: "\n")
//
//    // Создание массива JSON
//    let jsonArray = lines.map { line -> [String: Any] in
//        // Ваши операции для преобразования строки в объект JSON
//        // В данном примере предполагается, что каждая строка - просто значение в массиве
//        return ["value": line]
//    }
//
//    // Преобразование массива JSON в JSON-данные
//    let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
//
//    // Запись JSON-данных в файл
//    try jsonData.write(to: URL(fileURLWithPath: jsonFilePath))
//
//    print("JSON файл успешно создан.")
//} catch {
//    print("Ошибка при создании JSON файла:", error)
//}
