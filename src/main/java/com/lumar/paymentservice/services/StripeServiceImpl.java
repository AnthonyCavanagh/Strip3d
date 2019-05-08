package com.lumar.paymentservice.services;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.lumar.paymentservice.model.CardDetails;
import com.lumar.paymentservice.model.PaymentForm;
import com.lumar.paymentservice.model.PaymentIntentForm;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.model.PaymentIntent;
import com.stripe.model.Source.Card;
import com.stripe.model.Token;


@Service
public class StripeServiceImpl implements StripeService{

	@Override
	public Charge charge(PaymentForm payment)  {
		
		Stripe.apiKey = "sk_test_8jKxIefdjLaRhy2phDsrWNfb00tiP5v93a";
		
		Map<String, Object> chargeParams = new HashMap<>();
		    Charge charge = new Charge();
	        chargeParams.put("amount", payment.getAmount());
	        chargeParams.put("currency", payment.getCurrency());
	        chargeParams.put("description", payment.getDescription());
	        chargeParams.put("source", payment.getStripeToken());
	        try {
				charge = Charge.create(chargeParams);
			} catch (StripeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return charge;
	}

	@Override
	public Token getToken(CardDetails card)  {
		Token token = new Token();
		Stripe.apiKey = "sk_test_8jKxIefdjLaRhy2phDsrWNfb00tiP5v93a";
		Card cardSource = new Card();
		Map<String, Object> cardParams = new HashMap<String, Object>();
		cardParams.put("number", card.getCardNumber());
		cardParams.put("exp_month", card.getExpMonth());
		cardParams.put("exp_year", card.getExpYear());
		cardParams.put("cvc", card.getCsv());
		
		Map<String, Object> tokenParams = new HashMap<String, Object>();
		tokenParams.put("card", cardParams);
		try {
			token = Token.create(tokenParams);
			
			Token resp = Token.retrieve(token.getId());
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return token;
	}
	
	private void CheckFor3DSecurityCard(){
		
	}

	@Override
	public PaymentIntent createPaymentIntent(PaymentIntentForm intentForm) {
		Stripe.apiKey = "sk_test_8jKxIefdjLaRhy2phDsrWNfb00tiP5v93a";
		Map<String, Object> paymentintentParams = new HashMap<String, Object>();
		paymentintentParams.put("amount", 1099);
		paymentintentParams.put("currency", "gbp");
		PaymentIntent paymentIntent = new PaymentIntent();
		try {
			paymentIntent = PaymentIntent.create(paymentintentParams);
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return paymentIntent;
		
	}

}
