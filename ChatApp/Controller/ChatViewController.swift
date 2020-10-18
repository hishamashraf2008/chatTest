//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/18/20.
//

import UIKit
import MessageKit


struct message: MessageType{
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
    
}
struct sender: SenderType{
    var senderId: String
    var photoURL: String
    var displayName: String
    
    
}
class ChatViewController: MessagesViewController {

    private var messages = [message]()
    private var selfSender = sender(senderId: "1", photoURL: "", displayName: "joeyboi")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(message(sender: selfSender, messageId: "hi", sentDate: Date(), kind: .text("helloo")))
        messages.append(message(sender: selfSender, messageId: "hi", sentDate: Date(), kind: .text("sooo, how are you?")))
    }


}
extension ChatViewController :MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
