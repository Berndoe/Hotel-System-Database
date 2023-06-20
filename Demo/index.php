
<!DOCTYPE html>
<html>
<head>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 

	<meta charset="utf-8">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Home Page</title>



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
		  <li><a class="active" href= "#home"> Home </a></li>
		  <li><a  href="Query_one_hotel.php"> Room Availability </a></li>
		  <li><a href="Query_two_hotel.php"> Employee-Booking Records </a></li>
		  <li><a href="Query_three_hotel.php"> Current Reservations </a></li>
		  <li><a href="Query_four_hotel.php"> Bills </a></li>
		  <li> <a href="Query_five_hotel.php"> Services Tracking </a></li>
 		 <li><a href="Query_six_hotel.php"> Monthly Report </a></li>
	</ul>
</div>

<
<!-- Page content -->
<div class="w3-content" style="max-width:2000px;margin-top:0px">
  <!-- Images -->
  <div class="mySlides w3-display-container w3-center">
    <img src="/Demo/img/hotel_3.jpg" style="width:100%">
    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-14 w3-hide-small">
      <h3>Beyond the Hills </h3>
      <p><b>Branches in Accra, Berekuso, Kumasi, CapeCoast, Takoradi</b></p>   
    </div>
  </div>
</div>

  <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide">Beyond the Hills</h2>
    <p class="w3-opacity"><i>Expert service is our goal</i></p>
    <p class="w3-justify">A rich daddy Bernd has a conglomerate of five Hotels. His hotels, Beyond the Hills, provide a range of 5-star luxury suites and studio apartments honing modest qualities of both small and larger high-priced hostels. The purpose of his establishment is to provide paid lodging for travellers on a short-term basis. Currently, the various branches are located in Accra, Berekuso, Kumasi, Takoradi and Cape Coast.  The hotel consists of over 1000 rooms of various types as well as top notch recreational facilities.</p>
	
	<h2 class="w3-wide">Case Study</h2>
   <p>Rich Daddy Bernd’s conglomerate works based on a booking/ reservation system. The Guest books a room or walks into the reception, the employee(receptionist) takes down the Guest details and creates a booking or looks up a Guest booking on the database system. On the system, it displays the Guests room and room type and after the stay, the Guest’s bill is generated. His hotel also has an in-house restaurant where guests from the hotel or outside can come and eat.</p>
	<h2 class="w3-wide">Reason For This Projecty</h2>
	<p> Due to an increase in tourism in Ghana, the number of travellers requiring accommodation is increasing and Beyond the Hill’s current management system cannot keep up. Rich Daddy Bernd initially started his business using a file-based system to manage his hotels’ data and has realized some data inconsistencies due to the increasing number of bookings across the company’s various branches. The file-based system has also led to data redundancy and causes the company to face several security issues. Due to this the company has encountered issues with room reservations and billing. For these reasons, it is advised that the company switch to a relational based system.  This team project is aimed at building and delivering an efficient and effective hotel database management system that Daddy Bernd can use to maximize his profitability and service capacity. It would be to avoid all the problems he currently faces with booking reservations and data inconsistency amongst all departments as the priority of his hotels are his guests’ comfort. </p> 
</div>

</body>
</html>
