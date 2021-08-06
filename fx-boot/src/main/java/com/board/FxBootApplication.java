package com.board;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@EnableAspectJAutoProxy
@SpringBootApplication
public class FxBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(FxBootApplication.class, args);
	}

}
