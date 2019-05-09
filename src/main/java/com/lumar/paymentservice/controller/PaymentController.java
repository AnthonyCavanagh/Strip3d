package com.lumar.paymentservice.controller;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lumar.paymentservice.model.PaymentForm;
import com.lumar.paymentservice.model.PaymentIntentForm;
import com.lumar.paymentservice.services.StripeService;
import com.stripe.model.Charge;
import com.stripe.model.PaymentIntent;



import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
@Controller
public class PaymentController {

	@Autowired
	StripeService paymentService;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@RequestMapping(value = "/paymentIntent", method = RequestMethod.GET)
    public ModelAndView showPaymentIntentForm() {
        return new ModelAndView("PaymentIntentForm", "paymentIntentForm", new PaymentIntentForm());
    }
	
	@RequestMapping(value = "/paymentIntentComplete", method = RequestMethod.POST)
	public ModelAndView submitPaymentIntent(@Valid @ModelAttribute("paymentIntentForm") PaymentIntentForm intentForm, BindingResult result, ModelMap model)  {
		if (result.hasErrors()) {
			
		}
		PaymentIntent intent = paymentService.createPaymentIntent(intentForm);
		String clientSecret = intent.getClientSecret();
		logger.info(clientSecret);
		ModelAndView modelView = new ModelAndView("PaymentCheckCardForm");
		modelView.addObject("clientSecret", clientSecret);
		return modelView;
	}
	 
	
	@RequestMapping(value = "/paymentCompleted", method = RequestMethod.POST)
	public ModelAndView submitPayment(@Valid @ModelAttribute("paymentForm") PaymentForm payment, BindingResult result, ModelMap model)  {
		if (result.hasErrors()) {
			
		}
		Charge charge = paymentService.charge(payment);
		logger.info(charge.toString());
		 return new ModelAndView("completed");
	}
	
	
	
	
}
