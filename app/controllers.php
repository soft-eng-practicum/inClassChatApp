<?php
include "./settings.php";

// optionally include some usefull functions
include "helpers.php";

// Must include this function. You can change its name in settings.php
function home() {
	if (_isLoggedIn()) {
		_goto("chat");
		exit; 
	}

	// CODE HERE
	if (isset($_POST["email"]) && isset($_POST["password"]) && isset($_POST["confirm"]) && isset($_POST["name"])) {
		
		if ($_POST["password"] == $_POST["confirm"]) {
			$user = new User(); 
			if (!$user->search("email", $_POST["email"]) ) {
				$user->email = $_POST["email"];
				$user->name = $_POST["name"];
				$user->domain = substr(strrchr($_POST["email"], "@"), 1);
				$user->password = _hash($_POST["password"]);
				$user->createdAt = time(); 
				$user->save();
				$user->get("email", $_POST["email"]); 
				if (_logUserIn($user)) {
					_goto("chat"); 
				} else {
				}
			} else {
				$error = "User Exists";
				include("views/signup.php"); 
			}
		} else {
			$error = "Passwords Didn't Match";
			include("views/signup.php"); 
		}


	} else {
		include("views/signup.php"); 
	}
}

function login() {
	// CODE HERE
	if (isset($_POST["email"]) && isset($_POST["password"])) {
		$user = new User(); 
			if ($user->get("email", $_POST["email"]) ) {
				if ($user->password == _hash($_POST["password"])) {
					_logUserIn($user); 		
					_goto("chat"); 
				} else {
					$error = "Wrong Password"; 
					include("views/login.php"); 
				}
			} else {
				$error = "Username is Incorrect"; 
				include("views/login.php"); 
			}
	} else {
		include("views/login.php"); 
	}
}

function chat() {
	$user = _isLoggedIn(); 
	if ($user) {

		if (isset($_POST["class"]) && $_POST["class"] != " " && $_POST["class"] != "") {
			// sanitize
			$class_name = strtoupper(str_replace(' ', '', $_POST["class"]));

			// create the class if it doesn't exist
			$course = new Course(); 
			$results = $course->match(array("name" => $class_name, "school_id" => $user->domain));
			if (sizeof($results) == 0) {
				$course->name = $class_name;
				$course->school_id = $user->domain;
				$course->save();
				$results = $course->match(array("name" => $class_name, "school_id" => $user->domain));
			}
			
			// enroll student in class
			$enroll = new Enrollment(); 
			$enroll_results = $enroll->match(array("user_id" => $user->id, "course_id" => $results[0]["id"])); 
			if (sizeof($enroll_results) == 0) {
				$enroll->user_id = $user->id;
				$enroll->course_id = $results[0]["id"];
				$enroll->save();
			} else {
				$error = "You are already in that chat!"; 
			}
		}

		// set $classes == to enrolled classes
		$enroll = new Enrollment(); 
		$results = $enroll->search("user_id", $user->id); 
		$course_names = array(); 
		foreach ($results as $result) {
			array_push($course_names, $result["course_id"]);
		}


		include("views/chat.php"); 
	} else {
		_goto("login");  
	}
}

function logout() {
	setcookie("user", "", time()-3600);
	unset($_COOKIE["user"]); 
	_goto("login"); 
	exit; 
}

// Must include this function. You can change its name in settings.php
function notfound() {
	// CODE HERE

	include("views/notfound.php"); 
}

/*  
	FUNCTIONS
	Note:	functions that begin with '_' are not expected to return pages, 
			and are reserved for user defined functions. 
	Ex: 	"_logUserIn()" or "_getPostsForUser($username)" 
*/  

// Useful for system wide announcments / debugging
function _everypage() {

}

function _logUserIn($user) {
	$random = rand(10000,99999); 
	$session_id = $random . ":" . $user->email; 

	$user->session_id = _hash($session_id);
	$user->save(); 

	if (setcookie("user", $session_id, time()+60*60*24*7)) {
		$_COOKIE['user'] = $session_id;
		return TRUE; 
	} else {
		return FALSE; 
	}
}

function _isLoggedIn() {
	if (isset($_COOKIE['user'])) {
		$user = new User(); 
		if ($user->get("session_id", _hash($_COOKIE['user']))) {
			return $user;
		}
	}
	return FALSE; 
}

?>



