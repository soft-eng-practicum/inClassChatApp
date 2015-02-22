<?php

require './jakephp/Model.php';

/* 

EXAMPLE: 

class User extends Model {
	public $email;
	public $username;
	public $password; 
	public $createdAt; 
	public $session_id; 
}

*/

class User extends Model {
	public $email;
	public $name;
	public $domain;
	public $school_id;
	public $password;
	public $createdAt;
	public $session_id;
}

class School extends Model {
	public $domain;
	public $name;
}

class Course extends Model {
	public $name;
	public $school_id;
}

class Enrollment extends Model {
	public $user_id; 
	public $course_id; 
}

class Message extends Model {
	public $content;
	public $likes;
	public $createdAt;
	public $owner_id;
	public $course_id;
}

?>










