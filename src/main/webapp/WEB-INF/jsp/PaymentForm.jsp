<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Create a Field</title>
</head>
<body>
	<h3>Enter Payment Details</h3>
	<form:form method="POST" action="${pageContext.request.contextPath}/sendPayment" modelAttribute="paymentForm">
		<table>
	         <tr>
				<td><form:label path="description">Description</form:label></td>
				<td><form:input path="description" /></td>
			</tr>
		    <tr>
				<td><form:label path="amount">Amount</form:label></td>
				<td><form:input path="amount" /></td>
			</tr>
			<tr>
				<td><form:label path="currency">Currency</form:label></td>
				<td><form:input path="currency" /></td>
			</tr>
			<tr>
				<td><form:label path="stripeEmail">Stripe Email</form:label></td>
				<td><form:input path="stripeEmail" /></td>
			</tr>
			<tr>
				<td><form:label path="stripeToken">Stripe Token</form:label></td>
				<td><form:input path="stripeToken" /></td>
			</tr>
			<tr>
				<td><input type="submit" value="Submit" /></td>
			</tr>
		</table>
	</form:form>
	

</body>