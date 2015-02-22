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
        <p> <a href="/bulletin/logout"> Logout </a> </p>

        <h4>Posts</h4>
        <?php 
          if (isset($error)) {
            echo "<p> {$error} </p>"; 
          }
        ?>
        <form action="/bulletin/posts" method="post">
          Post: <input type="text" name="post"><br>
          <input type="submit" value="Submit">
        </form>

        <?php 
          foreach ($results as $value) {
            echo "<form action='/bulletin/delete_post' method='post'> <p>{$value['description']}</p> <input type='hidden' name='post_id' value='{$value['id']}'> <input type='submit' value='Delete'></form>";
          }
        ?>  

    </div>
  </div>

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
