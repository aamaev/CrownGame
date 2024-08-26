//
//  SoundAssistant.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import Foundation
import AVFAudio

class SoundAssistant: ObservableObject {
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var clickPlayer: AVAudioPlayer?
    private var victoryPlayer: AVAudioPlayer?
    private var defeatPlayer: AVAudioPlayer?
    
    @Published var isMusicEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isMusicEnabled, forKey: "isMusicEnabled")
            if isMusicEnabled {
                  playBackgroundMusic()
              } else {
                  stopBackgroundMusic()
              }
        }
    }
    
    @Published var areSoundsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(areSoundsEnabled, forKey: "areSoundsEnabled")
        }
    }
    
    init() {
        self.areSoundsEnabled = UserDefaults.standard.bool(forKey: "areSoundsEnabled")
        self.isMusicEnabled = UserDefaults.standard.bool(forKey: "isMusicEnabled")
    }

    
    func playBackgroundMusic() {
        guard isMusicEnabled else { return }
        if let path = Bundle.main.path(forResource: "bg_music", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.play()
            } catch {
                print("Error with background music: \(error.localizedDescription)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playClickSound() {
        guard areSoundsEnabled else { return }
        if let path = Bundle.main.path(forResource: "click_sound", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                clickPlayer = try AVAudioPlayer(contentsOf: url)
                clickPlayer?.play()
            } catch {
                print("Error with click sound: \(error.localizedDescription)")
            }
        }
    }
    
    func playVictorySound() {
        guard areSoundsEnabled else { return }
        if let path = Bundle.main.path(forResource: "win_sound", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                victoryPlayer = try AVAudioPlayer(contentsOf: url)
                victoryPlayer?.play()
            } catch {
                print("Error with victory sound: \(error.localizedDescription)")
            }
        }
    }
    
    func playDefeatSound() {
        guard areSoundsEnabled else { return }
        if let path = Bundle.main.path(forResource: "failure_sound", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                defeatPlayer = try AVAudioPlayer(contentsOf: url)
                defeatPlayer?.play()
            } catch {
                print("Error with defeat sound: \(error.localizedDescription)")
            }
        }
    }
}
