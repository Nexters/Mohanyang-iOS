//
//  AudioClient.swift
//  AudioClient
//
//  Created by MinseokKang on 11/27/24.
//

import AVFoundation

import AudioClientInterface

import Dependencies

extension AudioClient: DependencyKey {
  public static let liveValue: AudioClient = .live()
  
  public static func live() -> AudioClient {
    actor AudioSession {
      var player: AVAudioPlayer?
      
      func playSound(fileURL: URL) throws -> Bool {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try AVAudioSession.sharedInstance().setActive(true)
        
        player = try AVAudioPlayer(contentsOf: fileURL)
        player?.prepareToPlay()
        return player?.play() ?? false
      }
    }
    
    let audioSession = AudioSession()
    
    return .init(
      playSound: { fileURL in
        try await audioSession.playSound(fileURL: fileURL)
      }
    )
  }
}
