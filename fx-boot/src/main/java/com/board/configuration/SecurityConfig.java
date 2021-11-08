package com.board.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig  extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.headers()
				.frameOptions().sameOrigin() // 같은 Origin에서 렌더링 허용
//				.frameOptions().disable() // iframe 방어 안함
			.and()
			.httpBasic().disable(); // Spring Security
	}
}
