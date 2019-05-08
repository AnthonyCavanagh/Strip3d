package com.lumar.paymentservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan("com.lumar.paymentservice")
@SpringBootApplication
public class Payment {
    
	public static void main( String[] args ) {
    	SpringApplication.run(Payment.class, args);
    }
}
