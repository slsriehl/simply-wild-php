<?php
	require '../config/secret.php';
	require '../vendor/autoload.php';
	// need zetacomponents/main, google/recaptcha, and recaptcha-lib/recatpcha
	var_dump($_POST);
	if(!$_POST['name'] || !$_POST['email'] || !$_POST['subject'] || !$_POST['message']) {
		echo 'All fields besides phone number are required.  Please try again or ';
		return;
	}

	// if($_POST["g-recaptcha-response"]) {
	// 	$reCaptcha = new ReCaptcha($secret);
	// 	//$reCaptcha->setPrivateKey();
	// 	$trueCaptcha = $reCaptcha->verify(
	// 		$_POST["g-recaptcha-response"]
	// 	);
	// 	if(!$trueCaptcha) {
	// 		echo "Sorry, we couldn't send your message.  Please check the captcha ";
	// 		return;
	// 	} else {
			try {
					$time = new DateTime();
					$formatted_time = $time->format('Y-m-d H:i:s');
					$message = 'New message from' . $_POST['name'] . PHP_EOL . PHP_EOL . $_POST['message'] . PHP_EOL . PHP_EOL . 'Sent on ' . $time . ' at ' . $formatted_time . ' from simplywildgardens.com.';
					$transport = new ezcMailTransportSmtp();
					$mail = new ezcMail();
					$mail->from = new ezcMailAddress( $_POST['email'], $_POST['name'] );
					$mail->addTo( new ezcMailAddress( "sarah@riehlhelp.com" ) );
					$mail->subject = $_POST['subject'];
					$mail->body = new ezcMailText( $message );
					$transport->send( $mail );
					echo 'Your message was successfully sent!';
			} catch ( Exception $e ) {
					echo "Sorry, we couldn't send your message.  Please try again later ";
			}
	// 	}
	// } else {
	// 	echo "Sorry, we couldn't send your message.  Please check the captcha ";
	// }
