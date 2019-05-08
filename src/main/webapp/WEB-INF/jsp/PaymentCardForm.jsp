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
			  //on3DSComplete();
		      //stripeTokenHandler(result.token);
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
	    	  onHandle3D();
 		      //stripeTokenHandler(result.token);
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
      
      function onHandle3D() {
		  var frame = document.createElement('iframe')
		  var cardholderName = document.getElementById('cardholder-name');
		  frame.remove();
		  stripe.handleCardAction(clientSecret,
				  card, {
		      payment_method_data: {
		        billing_details: {name:'Jenny Rosen'}
		      }
		    }  
		  ).then(function(result) {
			  document.write('Handle result.error or result.paymentIntent');
		      if (result.error) {
		    	  displayError.textContent = result.error.message;
		      } else {
		        if (result.paymentIntent.status === 'succeeded') {
		        	displayError.textContent = result.paymentIntent.status
		        } else if (result.paymentIntent.status === 'requires_payment_method') {
		        	displayError.textContent = result.paymentIntent.status
		        }else if (result.paymentIntent.status === 'requires_action') {  
		        	var iframe = document.create('iframe');
		        	iframe.src = paymentIntent.next_action.redirect_to_url.url;
		        	iframe.width = 400;
		        	iframe.height = 600;
		        	frame.appendChild(iframe);
		        } else if (result.paymentIntent.status === 'pending'){
		        	displayError.textContent = result.paymentIntent.status
		        } 
		        else if (result.paymentIntent.status === 'undefined'){
		        	displayError.textContent = result.paymentIntent.status
		        } 
		      }
		    });
		}

	  
	  function on3DSComplete() {
		  var frame = document.createElement('iframe')
		  frame.remove();
		  //var res =stripe.retrievePaymentIntent('pi_4000000000003220_secret_sk_test_8jKxIefdjLaRhy2phDsrWNfb00tiP5v93a')
		  stripe.retrievePaymentIntent('pi_1_secret_sk_test_8jKxIefdjLaRhy2phDsrWNfb00tiP5v93a')
		    .then(function(result) {
		      if (result.error) {
		    	  displayError.textContent = result.error.message;
		      } else {
		        if (result.paymentIntent.status === 'succeeded') {
		        	displayError.textContent = result.paymentIntent.status
		        } else if (result.paymentIntent.status === 'requires_payment_method') {
		        	displayError.textContent = result.paymentIntent.status
		        }else if (result.paymentIntent.status === 'requires_action') {  
		        	var iframe = document.create('iframe');
		        	iframe.src = paymentIntent.next_action.redirect_to_url.url;
		        	iframe.width = 400;
		        	iframe.height = 600;
		        	frame.appendChild(iframe);
		        } else if (result.paymentIntent.status === 'pending'){
		        	displayError.textContent = result.paymentIntent.status
		        } 
		        else if (result.paymentIntent.status === 'undefined'){
		        	displayError.textContent = result.paymentIntent.status
		        } 
		      }
		    });
		}


	});
</script>
</body>
</html>