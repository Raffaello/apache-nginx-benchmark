
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>Title Goes Here</title></head>
<body>
    <?php
    echo '<h3>PHP for loops to make a silly test</h3>';
    for($i = 0; $i < 100; $i++) {
        echo "<p> Run = {$i} --- Results = </p>";
        for($j=0; $j<1000; $j++) {
            $res = rand();
            echo "<p>{$i}:{$j}= {$res}</p>";
        }
    }
    ?>
</body>
</html>
