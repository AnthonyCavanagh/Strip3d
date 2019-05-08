package com.lumar.paymentservice.model;

public class PaymentForm {


    private String description;
    private int amount;
    private String currency;
   
    
    private String stripeEmail;
    private String stripeToken;
    
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getStripeEmail() {
		return stripeEmail;
	}
	public void setStripeEmail(String stripeEmail) {
		this.stripeEmail = stripeEmail;
	}
	public String getStripeToken() {
		return stripeToken;
	}
	public void setStripeToken(String stripeToken) {
		this.stripeToken = stripeToken;
	}
	@Override
	public String toString() {
		return "PaymentRequest [description=" + description + ", amount=" + amount + ", currency=" + currency
				+ ", stripeEmail=" + stripeEmail + ", stripeToken=" + stripeToken + "]";
	}
}
