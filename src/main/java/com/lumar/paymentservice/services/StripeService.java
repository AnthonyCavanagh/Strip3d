package com.lumar.paymentservice.services;

import com.lumar.paymentservice.model.CardDetails;
import com.lumar.paymentservice.model.PaymentForm;
import com.lumar.paymentservice.model.PaymentIntentForm;
import com.stripe.model.Charge;
import com.stripe.model.PaymentIntent;
import com.stripe.model.Token;

public interface StripeService {
	public Charge charge(PaymentForm payment);
	public Token getToken(CardDetails card);
	public PaymentIntent createPaymentIntent(PaymentIntentForm intentForm);
}
