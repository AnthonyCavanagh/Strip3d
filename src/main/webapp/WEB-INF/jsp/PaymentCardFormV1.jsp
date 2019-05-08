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
	
	var cardholderName = document.getElementById('cardholder-name');
	var cardButton = document.getElementById('card-button');

	cardButton.addEventListener('click', function(ev) {
	  stripe.createPaymentMethod('card', cardElement, {
	    billing_details: {name: cardholderName.value}
	  }).then(function(result) {
	    if (result.error) {
	      // Show error in payment form
	    } else {
	      // Otherwise send paymentMethod.id to your server (see Step 2)
	      fetch('/ajax/confirm_payment', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify({ payment_method_id: result.paymentMethod.id })
	      }).then(function(result) {
	        // Handle server response (see Step 3)
	        result.json().then(function(json) {
	          handleServerResponse(json);
	        })
	      });
	    }
	  });

      function stripeTokenHandler(token) {
		  var form = document.getElementById('payment-form');
		  var hiddenInput = document.createElement('input');
		  hiddenInput.setAttribute('type', 'hidden');
		  hiddenInput.setAttribute('name', 'stripeToken');
		  hiddenInput.setAttribute('value', token.id);
		  form.appendChild(hiddenInput);
		  form.submit();
		}
	  
	  


	});
</script>
</body>
</html>