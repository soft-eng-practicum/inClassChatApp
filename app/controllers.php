<?php
include "./settings.php";

// optionally include some usefull functions
include "helpers.php";

// Must include this function. You can change its name in settings.php
function home() {
	// CODE HERE
	_showCookies(); 
	include("views/home.php"); 
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

?>