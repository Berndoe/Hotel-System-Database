<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Employee-Booking Records</title>

	<!-- //connect to the libraries -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style>
body {margin:0;}
ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

ul.topnav li {float: left;}

ul.topnav li a {
  display: inline-block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: 0.3s;
  font-size: 17px;
}
ul.topnav a.active {
  background-color: #04AA6D;
  color: white;
}

ul.topnav li a:hover {background-color: #111;}

ul.topnav li.icon {display: none;}

@media screen and (max-width:680px) {
  ul.topnav li:not(:first-child) {display: none;}
  ul.topnav li.icon {
    float: right;
    display: inline-block;
  }
}

@media screen and (max-width:680px) {
  ul.topnav.responsive {position: relative;}
  ul.topnav.responsive li.icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  ul.topnav.responsive li {
    float: none;
    display: inline;
  }
  ul.topnav.responsive li a {
    display: block;
    text-align: left;
  }
}
body {font-family: "Lato", sans-serif}

</style>

</head>
<body>
<div class="w3-top" id="nav-placeholder">
		<ul class="topnav" title="Toggle Navigation Menu">
		  <li><a  href= "index.php"> Home </a></li>
		  <li><a   href="Query_one_hotel.php"> Room Availability </a></li>
		  <li><a class="active" href="Query_two_hotel.php"> Employee-Booking Records </a></li>
		  <li><a href="Query_three_hotel.php"> Current Reservations </a></li>
		  <li><a href="Query_four_hotel.php"> Service Tracking </a></li>
		  <li> <a href="Query_five_hotel.php"> Bills </a></li>
 		 <li><a href="Query_six_hotel.php"> Monthly Report </a></li>
	</ul>
</div>

    
<style>
    td button:nth-child(1){background-color: #0298cf;}
    td button:nth-child(2) {background-color: #f80000;}
    tr:hover td {color: #0298cf;}  
    table {width:100%;}
 </style>
<a class="navbar-brand" style="font-size: 25;font-family:Arial, Helvetica, sans-serif;">Employee-Booking Records</a>


	<?php
	 	//database connection parameters
		// Check connection
		
		if(isset($_POST['Submit1']))
		{ 
		$servername = "localhost";
		$username = "hotelsytem";
		$password = "admin";
		$dbname = "hotelsystem";

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);

		if ($conn->connect_error) 
		{
		  die("Connection failed: " . $conn->connect_error);
		}

		
		//connection to the mysql database,
		$dbhandle = mysqli_connect($servername, $username, $password, $dbname);



		if(!empty($_POST["id"])) 	{
		 	$result = mysqli_query($dbhandle, "SELECT bookingId, e.empId, firstName, lastName, bookingDate, bookingTime from Employee e inner join  Booking bk  on  e.empId = bk.empId WHERE bk.bookingId = ".$_POST["id"]);
		 	
	    }

		else
		{ 
			$result = mysqli_query($dbhandle, "SELECT bookingId, e.empId, firstName, lastName, bookingDate, bookingTime from Employee e inner join  Booking bk  on  e.empId = bk.empId");
		}
		
        $count = 1;
        //echo json_encode($result);
			 echo '<table class="table table-hover">';
             echo '<thead class="thead-light" style="text-align:center;">';
                 echo "<tr>";
                     echo '<th scope="col">#</th>';
                     echo '<th scope="col">Booking ID</th>';
                     echo '<th scope="col">Employee ID</th>';
                     echo '<th scope="col">First Name</th>';
                     echo '<th scope="col">Last Name</th>';
                     echo '<th scope="col">Booking Date</th>';
                     echo '<th scope="col">Booking Time</th>';
                 echo "</tr>";
             echo "</thead>";

		while ($row = mysqli_fetch_array($result)) {
		        	echo "<tr>";
                        echo '<td style="text-align:center; scope="row">'.$count.'</td>';
		        		echo '<td style="text-align:center; scope="row">'.$row['bookingId'].'</td>';
						echo '<td style="text-align:center; scope="row">'.$row['empId'].'</td>';
						echo '<td style="text-align:center; scope="row">'.$row['firstName'].'</td>';
						echo '<td style="text-align:center; scope="row">'.$row['lastName'].'</td>';
						echo '<td style="text-align:center; scope="row">'.$row['bookingDate'].'</td>';
						echo '<td style="text-align:center; scope="row">'.$row['bookingTime'].'</td>';
					echo"</tr>";
            // echo"<br>";
		    
            $count = $count+1;
	
		}
		echo "</table>";
		//close the connection to database
		$conn->close();
		}
	?>

    <!-- Pagination -->
    <nav style="margin-top:-20px;">
        <ul class="pagination justify-content-end">
            <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous" >
                <span aria-hidden="true">&laquo;</span>
            </a>
            </li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
            </li>
        </ul>
    </nav>
</body>
</form>
</html>