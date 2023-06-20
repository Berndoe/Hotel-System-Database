<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Walk In Guests</title>
	<!-- //connect to the library -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Report Home Page</title>

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

    <!-- navigation bar content  -->
   

<style>
	.container {
		background-color: rgb(179, 75, 75);
		width: 400px;
		position: relative;
		margin-top: 14%;
		background-color: white;
		padding: 20px 60px 35px 60px;
		box-shadow: 0px 0px 10px 1px rgb(239, 235, 235); 
		left:-20%;
	}

	.container1 {
		background-color: rgb(179, 75, 75);
		width: 400px;
		position: relative;
		margin-top: -10.5%;
		background-color: white;
		padding: 20px 60px 35px 60px;
		box-shadow: 0px 0px 10px 1px rgb(239, 235, 235); 
		left:55%;
	}
</style>

<body>   
      
      <div class="w3-top" id="nav-placeholder">
		<ul class="topnav" title="Toggle Navigation Menu">
		  <li><a href= "index.php"> Home </a></li>
		  <li><a href="Query_one_hotel.php"> Room Availability </a></li>
		  <li><a href="Query_two_hotel.php"> Employee-Booking Records </a></li>
		  <li><a  href="Query_three_hotel.php"> Current Reservations </a></li>
		  <li><a href="Query_four_hotel.php"> Services Tracking </a></li>
		  <li> <a href="Query_five_hotel.php"> Bills </a></li>
 		 <li><a  class="active" href="Query_six_hotel.php"> Monthly Report </a></li>
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
		$sql = "SELECT MONTHNAME(paymentDate) as Months, COUNT(bg.guestId) as numberOfGuests, SUM(Charge) as serviceCharge FROM Payment p
		JOIN BranchServiceGuest bg on p.serviceId = bg.serviceId JOIN Services s on p.serviceId = s.serviceId GROUP BY MONTH(paymentDate) ORDER BY MONTH(paymentDate)";

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
					$guest_number[] = $row["numberOfGuests"];
					$serviceCharge[] = $row["serviceCharge"];
				 		 

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
	var yValues_1 = <?php echo json_encode($guest_number); ?>;
	var yValues_2 = <?php echo json_encode($serviceCharge); ?>;

var ctx = document.getElementById("myChart").getContext("2d");

var data = {
    labels: xValues,
    datasets: [
        {
            label: "Number of Guests",
            backgroundColor: "blue",
            data: yValues_1
        },
        {
            label: "Service Charge",
            backgroundColor: "red",
            data: yValues_2
        },
    ]
};
var myBarChart = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: {
        barValueSpacing: 20,
        scales: {
            yAxes: [{
				display: true,
                ticks: {
                    beginAtZero: true
                }
            }]
        },
		legend: {display: true},
		title: {
		display: true,
		text: "Monthly Report Walk-In Guests",
		fontSize: 25	
	}
}	
});

</script>

</body>
</html>