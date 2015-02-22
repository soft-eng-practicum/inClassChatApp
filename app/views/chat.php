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
  <link rel="stylesheet" href="css/normalize.css">
  <link rel="stylesheet" href="css/skeleton.css">

  <!-- Favicon
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="icon" type="image/png" href="images/favicon.png">

</head>
<body>


  <!-- Primary Page Layout
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <div class="container">
    <div class="row">
        <h2><?php echo $user->email; ?></h2>
        <p> <a href="/bulletin/logout"> Log Out </a> </p>
        <h2>Add a Class</h2>
        <?php 
          if (isset($error)) { 
            echo "<p> {$error} </p>"; 
          } 

          if (isset($_GET["0"])) {
            echo "<form action='/bulletin/chat/{$_GET["0"]}' method='post'>"; 
          } else {
            echo "<form action='/bulletin/chat' method='post'>"; 
          }
        ?>
        
          Class Name: <input type="text" name="class"><br>
          <input type="submit" value="Submit">
        </form>

        <?php
          if (sizeof($enrolled_courses) > 0) {
            foreach ($enrolled_courses as $course) {
              echo "<p> <a href='/bulletin/chat/" . $course["id"] . "'>" . $course["name"] . "</a> </p>"; 
            }

            if (isset($_GET['0'])) {
              echo "<h2>{$enrolled_courses[$_GET['0']]['name']}</h2>"; 
            }

          }
        ?>


        <?php
          if (isset($messages) and sizeof($messages) > 0) {
            foreach ($messages as $message) {
              echo "<p> <strong>{$message['owner_name']}:</strong> {$message['content']} </p>";
            }
          } else {
            echo "<p> <em> No messages yet... Get the convo started!</em> </p>";
          }
        ?>

        <?php 
          if (isset($_GET["0"])) {
            echo "<form action='/bulletin/chat/{$_GET["0"]}' method='post'>"; 
          }
        ?>

        <?php if (isset($_GET["0"])): ?>
          New Message: <input type="text" name="message"><br>
          <input type="submit" value="Submit">
          </form>
        <?php endif; ?>

    </div>
  </div>

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
