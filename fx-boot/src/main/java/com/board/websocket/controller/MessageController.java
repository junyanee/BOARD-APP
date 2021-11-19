package com.board.websocket.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.websocket.model.MessageMaster;

@RestController
@RequestMapping(value = "/chat")
public class MessageController {

	@RequestMapping(value = "/chatHome.do")
	public ModelAndView chatMain(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/messageIndex");
		return mv;
	}

	@MessageMapping("/chat.sendMessage")
	@SendTo("/topic/public")
	public MessageMaster sendMessage(@Payload MessageMaster chatMessage) {
		return chatMessage;
	}

	@MessageMapping("/chat.addUser")
	@SendTo("/topic/public")
	public MessageMaster addUser(@Payload MessageMaster chatMessage, SimpMessageHeaderAccessor headerAccessor) {
		headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
		return chatMessage;
	}
}
