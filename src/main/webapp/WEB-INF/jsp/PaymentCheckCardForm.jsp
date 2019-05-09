<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Stripe Payment Form</title>

<script type="text/javascript" src="https://js.stripe.com/v3/"></script>

</head>
<body>
	<h3>Enter Credit Card Details</h3>
	<script type="text/javascript">
	</script>
	<% 
	String clientSecret = (String)request.getAttribute("clientSecret"); 
	System.out.println("clientSecret is "+clientSecret);
	%>
	<form action="/charge" method="post" id="payment-form">
		<div class="form-row">
			<label for="card-element"> Credit or debit card </label>
			<div id="card-element" class="form-control"></div>
			<!-- Used to display Element errors. -->
			<div id="card-errors" role="alert"></div>
		</div>
		<button>Submit Payment</button>
	</form>
	
	<script type="text/javascript">
	
	
	
	var clientSecret = "<%= clientSecret %>" 
    var stripe = Stripe('pk_test_zlH4cfJHickLsXiPODZMXUFP00q1Hbvk6T');
	var elements = stripe.elements();
	var style = {
			  base: {
			    // Add your base input styles here. For example:
			    fontSize: '16px',
			    color: "#32325d",
			  }
			};
	var card = elements.create('card', {hidePostalCode: true, style: style});
	card.mount('#card-element');
	
	//Reads in data
	card.addEventListener('change', function(event) {
		  var displayError = document.getElementById('card-errors');
		  if (event.error) {
		    displayError.textContent = event.error.message;
		  } else {
			
		  }
		});
	
	var form = document.getElementById('payment-form');
	form.addEventListener('submit', function(event) {
	  event.preventDefault();

	  stripe.createToken(card).then(function(result) {
	    if (result.error) {
	      // Inform the customer that there was an error.
	      var errorElement = document.getElementById('card-errors');
	      errorElement.textContent = result.error.message;
	    } else {
	    	onHandle3D(result.token);
	    }
	  });

      
      function debug3DResponse(){
    	  stripe.handleCardPayment(clientSecret).catch(function(rejected){
    	      console.log(rejected);
    	  });
      }
      
      function onHandle3D(token) {
		  var frame = document.createElement('iframe')
		  var cardholderName = document.getElementById('cardholder-name');
		  frame.remove();
		  stripe.handleCardPayment(clientSecret,card).then(function(result) {
			  var message = null;
		      if (result.error) {
		    	  message =result.error.message;
		      } else {
		        if (result.paymentIntent && result.paymentIntent.status === 'succeeded') {
		        	//window.location.pathname = '/jsp/PaymentCompleted.jsp';
		        	 message = "Succededed "+JSON.stringify(token);
		        } else if (result.paymentIntent.status === 'requires_payment_method') {
		        	message = 'The PaymentIntent has been created, but has no payment method attached to it.'
		        } else if (result.paymentIntent.status === 'requires_action') {  
		        	message = 'The PaymentIntent has been created, but needs 3D checking'
		        } else if (result.paymentIntent.status === 'requires_confirmation') {  
		        	message = 'The PaymentIntent has been created and has a source attached, but has not yet been confirmed.'
		        } else if (result.paymentIntent.status === 'processing') {  
		        	message = 'Once required actions are handled, a PaymentIntent moves to processing'
		        } else if (result.paymentIntent.status === 'requires_capture') {  
		        	message = 'The PaymentIntent has been created and has a source, but requires capture'
		        } else if (result.paymentIntent.status === 'canceled') {  
		        	message = 'The PaymentIntent has been canceled'
		        } 
		      }
			  document.write(message);
		    });
		}


	});
</script>
</body>
</html>