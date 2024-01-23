package com.capgemini.springboot.cruddemo.security;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class DemoSecurityConfig {
	
	//add support for JDBC and no more hard coded users

	@Bean
	public UserDetailsManager userDetailsManager(DataSource dataSource) {
		JdbcUserDetailsManager jdbcUserDetailsManager = new JdbcUserDetailsManager(dataSource);
		//define query to retrieve user by username
		jdbcUserDetailsManager.setUsersByUsernameQuery("SELECT user_id, pw, active FROM members where user_id=?");
		//define query to retrieve user by roles
		jdbcUserDetailsManager.setCreateAuthoritySql("SELECT user_id, role FROM roles where user_id=?");
		
		return jdbcUserDetailsManager;
	}
	
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception
	{
		http.authorizeHttpRequests(configurer ->
		configurer.requestMatchers(HttpMethod.GET, "/api/employees").hasRole("EMPLOYEE")
		.requestMatchers(HttpMethod.GET, "/api/employees/**").hasRole("EMPLOYEE")
		.requestMatchers(HttpMethod.POST, "/api/employees").hasRole("MANAGER")
		.requestMatchers(HttpMethod.PUT, "/api/employees").hasRole("MANAGER")
		.requestMatchers(HttpMethod.DELETE, "/api/employees/**").hasRole("ADMIN")
		);
		
		//using basic authentication
		http.httpBasic();
		
		//in general not required for stateless REST api that post put delete patch
		http.csrf().disable();
		
		return http.build();
		
	}
	/*@Bean
	public InMemoryUserDetailsManager userDetailsManager() {
		UserDetails john = User.builder().username("john")
				.password("{noop}test123")
				.roles("EMPLOYEE")
				.build();
		UserDetails marry = User.builder().username("marry")
				.password("{noop}test123")
				.roles("EMPLOEE","MANAGER")
				.build();
		
		UserDetails susan = User.builder().username("sasan")
				.password("{noop}test123")
				.roles("EMPLOEE","MANAGER","ADMIN")
				.build();
		return new InMemoryUserDetailsManager(john,marry,susan);
		
	}*/

}
