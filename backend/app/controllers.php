<?php
include "./settings.php";

// optionally include some usefull functions
include "helpers.php";

// API Endpoints

function createAccount() {

}

function createCourseInSchool() {

}

function enrollUserInCourse() {
	
}

function dropUserFromCourse() {

}

function createSchool() {

}

function sendMessage() {

}

function likeMessage() {

}

// Helper Functions

function courseExists($course_id, $school_id) {

}

function userExists($email) {

}

function schoolExists($school_id) {

}



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