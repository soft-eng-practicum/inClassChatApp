<!DOCTYPE html>
<html lang="en">
<head>

  <!-- Basic Page Needs
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta charset="utf-8">
  <title>Your page title here :)</title>
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Mobile Specific Metas
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- FONT
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link href="//fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">

  <!-- CSS
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="stylesheet" href="/bulletin/app/views/static/normalize.css">
  <link rel="stylesheet" href="/bulletin/app/views/static/skeleton.css">
  
  <!-- Favicon
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="icon" type="image/png" href="images/favicon.png">

</head>
<body>


  <!-- Primary Page Layout
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->

  <div class="sidebar-classes">
    <p class="u-upper-title" style="width:100%; text-align:center;">YOUR CLASS CHATS</p>
    <?php
      if (sizeof($enrolled_courses) > 0) {
        echo "<ul>"; 
        foreach ($enrolled_courses as $course) {
          if (isset($_GET["0"]) && $course["id"] == $_GET["0"]) {
            echo "<li class = 'selected' style='margin-left:20px;'> <strong> <a href='/bulletin/chat/" . $course["id"] . "'>" . $course["name"] . "</a> </strong> </li>"; 
          } else {
            echo "<li> <a href='/bulletin/chat/" . $course["id"] . "'>" . $course["name"] . "</a> </li>";
          }
        }
        echo "</ul>"; 
        if (isset($error)) { 
          echo "<p> {$error} </p>"; 
        } 
      }
    ?>
  </div> 

  <div class="sidebar-bottom">

    <?php 

      if (isset($_GET["0"])) {
        echo "<form style='margin-top:45px;' action='/bulletin/chat/{$_GET["0"]}' method='post'>"; 
      } else {
        echo "<form action='/bulletin/chat' method='post'>"; 
      }
    ?>
    
      <input type="text" name="class" style="width:100%;"><br>
      <input type="submit" value="add class" class="button" style="width:100%;">
      <a class="button button-primary" href="/bulletin/logout" style="width:100%;"> Log Out</a>
    </form>

  </div>

  <div class="content">

    <div class="navbar">
      <?php
        if (isset($_GET['0'])) {
          echo "<p style='margin-top:30px;' class='u-upper-title'>{$enrolled_courses[$_GET['0']]['name']}</p>"; 
        }
      ?>
    </div>
    
    <div class="chat">
      <?php
        if (isset($_GET['0'])) {
          if (isset($messages) and sizeof($messages) > 0) {
            foreach ($messages as $message) {
              echo "<p> <strong>{$message['owner_name']}:</strong> {$message['content']}</p>";
              // <em> - {$message['createdAt']} </em> 
            }
          } else {
            echo "<p> <em> No messages yet... Get the convo started!</em> </p>";
          }

        }
      ?>
    </div>

    <div class="send-message">

      <?php 
        if (isset($_GET["0"])) {
          echo "<form action='/bulletin/chat/{$_GET["0"]}' method='post'>"; 
        }
      ?>

      <?php if (isset($_GET["0"])): ?>
        <input id="message-textbox" style="width:100%;" type="text" name="message">
        <input style="display:none;" type="submit" value="Submit">
        </form>
      <?php endif; ?>

    </div>
  </div>



<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>

<script src="/bulletin/app/views/static/scripts.js"></script>

</html>
