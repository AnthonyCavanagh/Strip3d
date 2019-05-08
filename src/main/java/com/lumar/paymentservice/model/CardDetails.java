package com.lumar.paymentservice.model;

public class CardDetails {
	 private String cardNumber;
	    private String csv;
	    private String expMonth;
	    private String expYear;
	    
	    public String getCardNumber() {
			return cardNumber;
		}
		public void setCardNumber(String cardNumber) {
			this.cardNumber = cardNumber;
		}
		public String getCsv() {
			return csv;
		}
		public void setCsv(String csv) {
			this.csv = csv;
		}
		public String getExpMonth() {
			return expMonth;
		}
		public void setExpMonth(String expMonth) {
			this.expMonth = expMonth;
		}
		public String getExpYear() {
			return expYear;
		}
		public void setExpYear(String expYear) {
			this.expYear = expYear;
		}
		@Override
		public String toString() {
			return "CardDetails [cardNumber=" + cardNumber + ", csv=" + csv + ", expMonth=" + expMonth + ", expYear="
					+ expYear + "]";
		}
}
