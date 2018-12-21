//
//  CarPlayer.swift
//  CarPlayTest
//
//  Created by dlernatovich on 12/20/18.
//  Copyright © 2018 dlernatovich. All rights reserved.
//

import UIKit
import MediaPlayer

/// Class which provide to play media items
class CarPlayer: NSObject, MPPlayableContentDataSource, MPPlayableContentDelegate {
    
    /// Instance of the {@link PlayCallback}
    public typealias PlayCallback = (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus;
    
    /// Instance of the {@link CarPlayer}
    private static var instance: CarPlayer = {
        let player = CarPlayer();
        return player;
    }();
    
    /// Instance of the {@link MPMoviePlayerController}
    fileprivate var controller: MPMoviePlayerController?;
    
    /// Instance of the {@link String}
    fileprivate var url: String?;
    
    /// Instance of the {@link PlayCallback}
    fileprivate var playHandler: PlayCallback?;
    
    /// Instance of the {@link PlayCallback}
    fileprivate var stopHandler: PlayCallback?;
    
    
    /// {@link Bool} value if the callback setted
    fileprivate var isSetCallback: Bool = false;
    
    /// Method which provide the getting of the {@link CarPlayer}
    ///
    /// - Returns: instance of the {@link CarPlayer}
    class func shared() -> CarPlayer {
        return instance;
    }
    
    /// Method which provide the setting up of the player
    public static func setUpPlayer() {
        MPPlayableContentManager.shared().dataSource = CarPlayer.shared();
        MPPlayableContentManager.shared().delegate = CarPlayer.shared();
    }
    
    /// Default constructor
    override init() {
        super.init();
        self.playHandler = { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            DispatchQueue.main.async {
                self.playWithPrevious();
            }
            return .success;
        };
        self.stopHandler = { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            DispatchQueue.main.async {
                self.stop();
            }
            return .success;
        };
        let center = MPRemoteCommandCenter.shared();
        center.playCommand.isEnabled = true;
        center.stopCommand.isEnabled = true;
        center.pauseCommand.isEnabled = false;
        center.nextTrackCommand.isEnabled = false;
        center.previousTrackCommand.isEnabled = false;
    }
    
    /// Method which provide the getting of the items count
    ///
    /// - Parameter indexPath: instance of the {@link IndexPath}
    /// - Returns: instance of the {@link Int}
    func numberOfChildItems(at indexPath: IndexPath) -> Int {
        print("CARPLAY: number of items")
        if indexPath.indices.count == 0 {
            return 3;
        } else if indexPath.indices.count == 1 {
            let cell = indexPath[0];
            if (cell == 0) {
                return 10;
            } else if (cell == 1) {
                return 30;
            } else if (cell == 2) {
                return 2;
            }
            return 0;
        }
        return 0
    }
    
    
    /// Method which provide the getting instance of the {@link MPContentItem}
    ///
    /// - Parameter indexPath: instance of the {@link IndexPath}
    /// - Returns: instance of the {@link MPContentItem}
    func contentItem(at indexPath: IndexPath) -> MPContentItem? {
        let indexCount = indexPath.count;
        return self.getItem(withIndex: indexCount,
                            withTab: indexPath.first ?? 0,
                            withStep: indexPath.last ?? 0);
    }
    
    /// Method which provide the getting of the content item
    ///
    /// - Parameters:
    ///   - indexCount: instance of the {@link Int}
    ///   - tabIndex: instance of the {@link Int}
    /// - Returns: instance of the {@link MPContentItem}
    fileprivate func getItem(withIndex indexCount: Int,
                             withTab tabIndex: Int,
                             withStep step: Int) -> MPContentItem? {
        var item: MPContentItem? = nil;
        if (indexCount == 1) {
            if (tabIndex == 0) {
                item = self.createItem(withTitle: "Home",
                                       withSubtitle: nil,
                                       withContainer: true,
                                       withArtworkImage: "ic_home");
            } else if (tabIndex == 1) {
                item = self.createItem(withTitle: "Music",
                                       withSubtitle: nil,
                                       withContainer: true,
                                       withArtworkImage: "ic_music");
            } else if (tabIndex == 2) {
                item = self.createItem(withTitle: "Favorites",
                                       withSubtitle: nil,
                                       withContainer: true,
                                       withArtworkImage: "ic_fav");
            }
        } else {
            item = self.createItem(withTitle: "Beautiful song \(step + 1)",
                withSubtitle: "Play hard, work hard",
                withContainer: false,
                withArtworkImage: "ic_song");
            item?.isStreamingContent = true;
        }
        return item;
    }
    
    /// Method which provide the create of the instance of the {@link MPContentItem}
    ///
    /// - Parameters:
    ///   - title: instance of the {@link String}
    ///   - subtitle: instance of the {@link String}
    ///   - isContainer: {@link Bool} value if the item is container
    ///   - imageName: instance of the {@link String}
    /// - Returns: instance of the {@link MPContentItem}
    fileprivate func createItem(withTitle title: String,
                                withSubtitle subtitle: String?,
                                withContainer isContainer: Bool,
                                withArtworkImage imageName: String?) -> MPContentItem {
        let item = MPContentItem.init(identifier: UUID.init().uuidString);
        item.title = title;
        if let subtitle = subtitle {
            item.subtitle = subtitle;
        }
        item.isContainer = isContainer;
        item.isPlayable = !isContainer;
        if let imageName = imageName, let image = UIImage.init(named: imageName) {
            item.artwork = MPMediaItemArtwork(image: image);
        }
        return item;
    }
    
    /// Method which provide the action when user click media item
    ///
    /// - Parameters:
    ///   - contentManager: instance of the {@link MPPlayableContentManager}
    ///   - indexPath: instance of the {@link IndexPath}
    ///   - completionHandler: instance of the handler
    func playableContentManager(_ contentManager: MPPlayableContentManager,
                                initiatePlaybackOfContentItemAt indexPath: IndexPath,
                                completionHandler: @escaping (Error?) -> Void) {
        self.play(withUrl: "http://us4.internet-radio.com:8266/", completionHandler: completionHandler);
    }
    
    /// Method which provide the start playing with URL
    ///
    /// - Parameter url: instance of the {@link String}
    @objc fileprivate func playWithPrevious() {
        self.play(withUrl: self.url, completionHandler: nil);
    }
    
    /// Method which provide the start playing with URL
    ///
    /// - Parameter url: instance of the {@link String}
    fileprivate func play(withUrl url: String?,
                          completionHandler: ((Error?) -> Void)?) {
        DispatchQueue.main.async {
            self.stop();
            if let url = url {
                if let urlObject = URL.init(string: url) {
                    self.url = url;
                    self.controller = MPMoviePlayerController(contentURL: urlObject);
                    if let controller = self.controller {
                        controller.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0);
                        controller.view.sizeToFit();
                        controller.movieSourceType = .streaming;
                        controller.prepareToPlay();
                        controller.play();
                    }
                    let center = MPNowPlayingInfoCenter.default();
                    center.nowPlayingInfo = [
                        MPMediaItemPropertyArtist: url,
                        MPMediaItemPropertyAssetURL: url,
                        MPMediaItemPropertyTitle: "Live Stream Radio",
                        MPNowPlayingInfoPropertyPlaybackRate: 1.0,
                        MPNowPlayingInfoPropertyIsLiveStream: true
                    ];
                    center.playbackState = .playing;
                    completionHandler?(nil);
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.endReceivingRemoteControlEvents();
                        if (self.isSetCallback == false) {
                            let remote = MPRemoteCommandCenter.shared();
                            remote.playCommand.addTarget(handler: self.playHandler!);
                            remote.stopCommand.addTarget(handler: self.stopHandler!);
                            self.isSetCallback = true;
                        }
                    })
                }
            }
        }
    }
    
    /// Method which provide the start playing with URL
    ///
    /// - Parameter url: instance of the {@link String}
    @objc fileprivate func stop() {
        let center = MPNowPlayingInfoCenter.default();
//        let remote = MPRemoteCommandCenter.shared();
        self.controller?.stop();
        self.controller = nil;
        center.playbackState = .stopped;
        UIApplication.shared.beginReceivingRemoteControlEvents();
//        remote.playCommand.removeTarget(self.playHandler);
//        remote.stopCommand.removeTarget(self.stopHandler);
    }
    
}
