<?php
 $con = mysql_connect("192.168.60.120","usuario1","database2017");
 if (!$con)
   {
   die('Could not connect: ' . mysql_error());
   }

 mysql_select_db("base_datos_1", $con);

 $result = mysql_query("SELECT * FROM cursos");
 echo "Los datos se visualizan así:";
 echo "<br />";
 echo "Nombre curso  |  Horas Semanales  |  Salon de clase";
 echo "<br /><br />";

 while($row = mysql_fetch_array($result))
   {
   echo $row['nombre'] . "  |  " . $row['horas_semana'] . "  |  " . $row['salon'];
   echo "<br />";
   }

 mysql_close($con);
?>
