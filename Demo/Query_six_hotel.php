<!-- find a way to space out the employee, assets and blah without affecting it when the window sized is reduced -->
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

.btn-primary, .btn-primary:hover, .btn-primary:active {
    background-color: #04AA6D !important;
    border: none;
}
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
		  <li><a href="Query_three_hotel.php"> Current Reservations </a></li>
		  <li><a href="Query_four_hotel.php"> Services Tracking </a></li>
		  <li> <a href="Query_five_hotel.php"> Bills </a></li>
 		 <li><a  class="active" href="Query_six_hotel.php"> Monthly Report </a></li>
	</ul>
</div>
<!-- Walk in report -->
<form method="post" action="Query_six_hotel_walk_in.php">
	<div class="form control container">
		<p class="text-xl-center font-weight-bold">Walk In Records</p><hr style="width:400px; position: relative; left: -60px;">
		<div class="mb-3">
				<a href="Query_six_hotel_walk_in.php"><input class="btn btn-primary form control btn-block" type="submit" value="SELECT" name="Submit1"></a>
			</div>	
		</div>
	</div>
</form>


<!--Overnight report -->
<form method="post" action="Query_six_hotel_night.php">
	<div class="form control container1">
		<p class="text-xl-center font-weight-bold">Stay In Records</p><hr style="width:400px; position: relative; left: -60px;">
		<div class="mb-3">
				<a href="Query_six_hotel_night.php"><input class="btn btn-primary form control btn-block" type="submit" value="SELECT" name="Submit1"></a>
			</div>	
		</div>
	</div>
</form>

         
</body>
</html>