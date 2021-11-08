package com.board;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@EnableAspectJAutoProxy
@SpringBootApplication
public class FxBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(FxBootApplication.class, args);
	}

}
