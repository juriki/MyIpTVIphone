//
//  VideoPlayerManager.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.12.2023.
//



//import UIKit
//import AVKit
//
//class VideoPlayerManager: NSObject, UIGestureRecognizerDelegate {
//    var playerViewController: AVPlayerViewController?
//    var isTextVisible = true
//    var textTimer: Timer?
//    var chanelList: [(key: String, value: String)] = []
//    var playingChanell = ""
//    let controller = UIViewController()
//    
//
//    func playVideo(videoURL: URL, text: String, in viewController: UIViewController) -> String {
//        let player = AVPlayer(url: videoURL)
//        playingChanell = text
//        playerViewController = AVPlayerViewController()
//        playerViewController?.player = player
//        
//        // Проигрываем видео
//        viewController.present(playerViewController!, animated: true){
//            self.addTextOverlayToVideo(text: text)
//            self.playingChanell = text
//            player.play()
//            
//            // Запускаем таймер для автоматического скрытия текста через 3 секунды после начала воспроизведения
//            self.textTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.handleTextTimer), userInfo: nil, repeats: false)
//
//            // Добавляем обработчики жестов
//            self.addTapGesture()
//            self.addPanGesture()
//        }
//        return text
//    }
//
//    func addTextOverlayToVideo(text: String) {
//        // Создаем текстовый слой
//        let textLayer = CATextLayer()
//        textLayer.string = text
//        textLayer.fontSize = 24
//        textLayer.foregroundColor = UIColor.white.cgColor
//        textLayer.alignmentMode = .center
//        textLayer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
//
//        // Позиционируем текстовый слой внизу экрана по центру
//        textLayer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 50)
//
//        // Создаем слой наложения для текста
//        let overlayLayer = CALayer()
//        overlayLayer.addSublayer(textLayer)
//
//        // Добавляем слой наложения к видеоплееру
//        playerViewController?.contentOverlayView?.layer.addSublayer(overlayLayer)
//    }
//
//    @objc func handleTextTimer() {
//        toggleTextVisibility()
//    }
//
//    private func toggleTextVisibility() {
//        UIView.animate(withDuration: 0.5) {
//            self.playerViewController?.contentOverlayView?.alpha = self.isTextVisible ? 0.0 : 1.0
//        }
//        isTextVisible.toggle()
//
//        // Очищаем таймер
//        textTimer?.invalidate()
//        textTimer = nil
//    }
//
//    func addTapGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tapGesture.delegate = self
//        playerViewController?.view.addGestureRecognizer(tapGesture)
//    }
//
//    func addPanGesture() {
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        panGesture.delegate = self
//        playerViewController?.view.addGestureRecognizer(panGesture)
//    }
//
//    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        let touchPoint = sender.location(in: playerViewController?.view)
//        print("Tap Point: \(touchPoint)")
//        toggleTextVisibility()
//    }
//
//    var startPonitX = 0
//    
//    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
//        if sender.state == .began {
//            // Запоминаем начальное место касания
//            initialPanPoint = sender.location(in: playerViewController?.view)
//            print("Pan Start Point: \(initialPanPoint!)")
//        } else if sender.state == .ended {
//            // Получаем конечное место касания
//            let endPoint = sender.location(in: playerViewController?.view)
//
//            // Вычисляем разницу между начальной и конечной координатой x
//            let deltaX = endPoint.x - (initialPanPoint?.x ?? 0)
//
//            if deltaX < -120{
//                nextChanell(nextChanelList: chanelList, isNextChannel: true)
//            }
//            if deltaX > 120{
//                nextChanell(nextChanelList: chanelList, isNextChannel: false)
//            }
//            initialPanPoint = nil
//        }
//    }
//    
//    var chanelToPlay = 0
//    
//    func nextChanell(nextChanelList: [(key: String, value: String)], isNextChannel: Bool){
//        
//        for (index, (key, _)) in nextChanelList.enumerated() {
//            if(key == playingChanell){
//                if isNextChannel{
//                    if  index < (nextChanelList.count - 1) {
//                        chanelToPlay = index + 1
//                        break
//                    }
//                    chanelToPlay = 0
//                    break
//
//                }else{
//                    if index > 0 {
//                        chanelToPlay = index - 1
//                        break
//                    }
//                    chanelToPlay = (nextChanelList.count - 1)
//                    break
//                }
//
//            }
//        }
//        let videoURL = URL(string: nextChanelList[chanelToPlay].value)
//        let channelName = nextChanelList[chanelToPlay].key
//        print(channelName)
//        replaceVideo(with: (videoURL)!, text: channelName)
//        playingChanell = channelName
//    }
//
//    private var initialPanPoint: CGPoint?
//
//    // Метод делегата для разрешения одновременного распознавания жестов
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    
//    
//    
//    func replaceVideo(with videoURL: URL, text: String) {
//        // Останавливаем текущее воспроизведение
//        stopPlayback()
//
//        // Создаем новый плеер с новым видео
//        let newPlayer = AVPlayer(url: videoURL)
//
//        // Заменяем текущий плеер новым
//        playerViewController?.player = newPlayer
//
//        // Очищаем предыдущие слои наложения текста
//        playerViewController?.contentOverlayView?.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//
//        // Проигрываем новое видео
//        newPlayer.play()
//
//        // Добавляем текстовый слой для нового видео
//
//        addTextOverlayToVideo(text: text)
//        let test = CollectionViewControllerChanels()
//        test.lastChannel = text
//        test.viewDidLoad()
//    }
//    func stopPlayback() {
//        playerViewController?.player?.pause()
//        playerViewController?.player?.replaceCurrentItem(with: nil)
//    }
//}



import UIKit
import AVKit

class VideoPlayerManager: NSObject, UIGestureRecognizerDelegate {
    var playerViewController: AVPlayerViewController?
    var isTextVisible = true
    var textTimer: Timer?
    var chanelList: [(key: String, value: String)] = []
    var playingChanell = ""
    var initialPanPoint: CGPoint?

    func playVideo(videoURL: URL, text: String, in viewController: UIViewController) -> String {
        let playerItem = AVPlayerItem(url: videoURL)
        playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: nil)

        let player = AVPlayer(playerItem: playerItem)
        playingChanell = text
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        viewController.present(playerViewController!, animated: true) {
            self.addTextOverlayToVideo(text: text)
            self.playingChanell = text
            player.play()

            self.textTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.handleTextTimer), userInfo: nil, repeats: false)

            self.addTapGesture()
            self.addPanGesture()
        }
        return text
    }

    func addTextOverlayToVideo(text: String) {
        // Создаем текстовый слой
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.fontSize = 24
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = .center
        textLayer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

        // Позиционируем текстовый слой внизу экрана по центру
        textLayer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 50)

        // Создаем слой наложения для текста
        let overlayLayer = CALayer()
        overlayLayer.addSublayer(textLayer)

        // Добавляем слой наложения к видеоплееру
        playerViewController?.contentOverlayView?.layer.addSublayer(overlayLayer)
    }

    @objc func handleTextTimer() {
        toggleTextVisibility()
    }

    private func toggleTextVisibility() {
        UIView.animate(withDuration: 0.5) {
            self.playerViewController?.contentOverlayView?.alpha = self.isTextVisible ? 0.0 : 1.0
        }
        isTextVisible.toggle()

        textTimer?.invalidate()
        textTimer = nil
    }

    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        playerViewController?.view.addGestureRecognizer(tapGesture)
    }

    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        playerViewController?.view.addGestureRecognizer(panGesture)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: playerViewController?.view)
        print("Tap Point: \(touchPoint)")

        if let playerView = playerViewController?.view,
           let overlayView = playerViewController?.contentOverlayView {
            let convertedPoint = overlayView.convert(touchPoint, from: playerView)

            if let tappedLayer = overlayView.layer.hitTest(convertedPoint) as? CATextLayer {
                print("Tapped Text: \(tappedLayer.string as? String ?? "N/A")")
            }
        }

        toggleTextVisibility()
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            initialPanPoint = sender.location(in: playerViewController?.view)
            print("Pan Start Point: \(initialPanPoint!)")
        } else if sender.state == .ended {
            let endPoint = sender.location(in: playerViewController?.view)
            let deltaX = endPoint.x - (initialPanPoint?.x ?? 0)

            if deltaX < -120 {
                nextChanell(nextChanelList: chanelList, isNextChannel: true)
            }
            if deltaX > 120 {
                nextChanell(nextChanelList: chanelList, isNextChannel: false)
            }
            initialPanPoint = nil
        }
    }

    var chanelToPlay = 0

    func nextChanell(nextChanelList: [(key: String, value: String)], isNextChannel: Bool) {
        for (index, (key, _)) in nextChanelList.enumerated() {
            if key == playingChanell {
                if isNextChannel {
                    if index < (nextChanelList.count - 1) {
                        chanelToPlay = index + 1
                        break
                    }
                    chanelToPlay = 0
                    break
                } else {
                    if index > 0 {
                        chanelToPlay = index - 1
                        break
                    }
                    chanelToPlay = (nextChanelList.count - 1)
                    break
                }
            }
        }
        let videoURL = URL(string: nextChanelList[chanelToPlay].value)
        let channelName = nextChanelList[chanelToPlay].key
        print(channelName)
        replaceVideo(with: videoURL!, text: channelName)
        playingChanell = channelName
    }

    func replaceVideo(with videoURL: URL, text: String) {
        stopPlayback()

        let newPlayer = AVPlayer(url: videoURL)
        playerViewController?.player = newPlayer
        playerViewController?.contentOverlayView?.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        newPlayer.play()
        addTextOverlayToVideo(text: text)

    }

    func stopPlayback() {
        playerViewController?.player?.pause()
        playerViewController?.player?.replaceCurrentItem(with: nil)
    }

    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            if let newStatus = (change?[.newKey] as? NSNumber)?.intValue {
                switch newStatus {
                case AVPlayerItem.Status.readyToPlay.rawValue:
                    // Воспроизведение готово
                    break
                case AVPlayerItem.Status.failed.rawValue:
                    // Воспроизведение не удалось
                    break
                default:
                    break
                }
            }
        }
    }
}
