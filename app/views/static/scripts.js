var text_input = document.getElementById('message-textbox');
text_input.focus();
text_input.select();

window.onload =toBottom; 

function toBottom() { 
	window.scrollTo(0, document.body.scrollHeight); 
} 

setInterval( "doSomething()", 1000 );

function doSomething( ) {
  $('#messages').load(document.URL +  ' #messages');
}