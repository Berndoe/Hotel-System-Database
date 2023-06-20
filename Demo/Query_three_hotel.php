<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Monthly Reservation Trend</title>
	<!-- //connect to the library -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	  <!-- //navbar -->
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
		  <li><a href= "index.php"> Home </a></li>
		  <li><a href="Query_one_hotel.php"> Room Availability </a></li>
		  <li><a href="Query_two_hotel.php"> Employee-Booking Records </a></li>
		  <li><a class="active" href="Query_three_hotel.php"> Current Reservations </a></li>
		  <li><a href="Query_four_hotel.php"> Services Tracking </a></li>
		  <li> <a href="Query_five_hotel.php"> Bills </a></li>
 		 <li><a  href="Query_six_hotel.php"> Monthly Report </a></li>
	</ul>
</div>

	 <?php
	 	//database connection parameters
	 	//change the database name to suite what you have in phpmyadmin
		$servername = "localhost";
		$username = "hotelsytem";
		$password = "admin";
		$dbname = "hotelsystem";

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);
		// Check connection
		if ($conn->connect_error) 
		{
		  die("Connection failed: " . $conn->connect_error);
		}
		

		//write sql
		$sql = "SELECT MONTHNAME(BookingDate) as Months, COUNT(RoomNumber) as NumberOfRooms FROM Booking GROUP BY MONTH(BookingDate)";

		//execute sql
		$result = $conn->query($sql);

		//check if any record was found
		if ($result->num_rows > 0) 
		{
			
			  // loop through the query result and fetch one record at a time
			  while($row = $result->fetch_assoc()) 
			  {
				  	//add record to array
					$months[] = $row["Months"];
					$numberOfRooms[] = $row["NumberOfRooms"];
				  	// $rooms[] = $row["roomType"];
					// $frequency[] = $row["NumberRooms"];		 

			   }//end of loop

		}//end of  if condition

		//close the connection to database
		$conn->close();
	?> 

	<!-- //starting drawing canvas -->
	<canvas id="myChart" style="width:100%;
	max-width:900px;
	margin-left:20%; margin-top: 10%;"></canvas>

	<!-- //canvas script -->
	<script>

	//change the content of the xvalues to be record from the database
	var xValues = <?php  

				//echo the array list on 39 and 46 as json list of items
				echo json_encode($months);
			?>
	
	// the data list below are hardcoded
	var yValues = <?php echo json_encode($numberOfRooms); ?>;

	new Chart("myChart", {
	  type: "line",
	  data: {
	    labels: xValues,
	    datasets: [{
	      data: yValues,
		  borderColor: "blue",
		  fill: false,
		  pointBackgroundColor: "red",
		  pointRadius: 5
	    }]
	  },
	  options: {
		scales: {
		yAxes: [{
			display: true,
			ticks: {
				beginAtZero: true
			}				
	  }]
	},
	legend: {display: false},
	title: {
		display: true,
		text: "2022 Monthly Reservation Trend",
		fontSize: 25	
	}
}	
});
</script>
</body>
</html>