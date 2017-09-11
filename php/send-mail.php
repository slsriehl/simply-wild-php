<?php
//requires autoloaders
	require '../vendor/autoload.php';
	require '../vendor/recaptcha-lib/recaptcha/lib/ReCaptcha/CaptchaAutoloader.php';

//requires for recatpcha
	require '../config/secret.php';
//recipient email
	require '../config/recipient.php';

//smtp server
	require '../config/host.php';
	require '../config/user.php';
	require '../config/pass.php';

//load classes from requires
	use ReCaptcha\ReCaptcha;
	use Nette\Mail\Message;
	use Nette\Mail\SmtpMailer;

//error reporting
	// error_reporting(-1);
	// ini_set('display_errors', 'On');
	// set_error_handler("var_dump");

//parse object from front end
	$json = file_get_contents('php://input');
	$json_decode = json_decode($json, true);
	// $json_encode = json_encode($json_decode);
	// echo $json_encode;

//if recaptcha sent, verify
	if($json_decode["g-recaptcha-response"]) {
		$reCaptcha = new ReCaptcha($secret);
		//$reCaptcha->setPrivateKey();
		$trueCaptcha = $reCaptcha->verify(
			$json_decode["g-recaptcha-response"]
		);
		if(!$trueCaptcha) {
			//if the captcha fails, return fail
			exit("captcha fail");
		} else {
			//if the captcha succeeds, try to send the mail
			try {
					$time = date('Y-m-d H:i:s');
					//$formatted_time = $time->format;
					$message = "New message from " . $json_decode['name'] . " at " . $json_decode['email'] . PHP_EOL . PHP_EOL . $json_decode['message'] . PHP_EOL . PHP_EOL . "Sent " . $time . " from simplywildgardens.com.";
					if(isset($json_decode['tel'])) {
						$message .= PHP_EOL . PHP_EOL . $json_decode['name'] . "'s phone number is " . $json_decode['tel'];
					}
					$transport = new SmtpMailer([
						'host' => $host,
						'username' => $user,
						'password' => $pass,
						'secure' => 'ssl',
					]);
					$mail = new Message;
					$mail->setFrom($user);
					$mail->addTo( $recipient );
					$mail->setSubject("New mail from simplywildgardens.com: " . $json_decode['subject']);
					$mail->setBody( $message );
					$transport->send( $mail );
					exit('success sending');
			} catch ( Exception $e ) {
				//if mail not sent, return fail
					exit("fail to send");
			}
		}
	} else {
		//if captcha not sent, return fail
		exit("captcha fail");
	}
