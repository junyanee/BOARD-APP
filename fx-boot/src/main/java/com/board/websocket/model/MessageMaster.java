package com.board.websocket.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MessageMaster {

	private MessageType type;
	private String content;
	private String sender;
}
