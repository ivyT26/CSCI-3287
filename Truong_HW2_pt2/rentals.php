<html>
<body>
<?php
$servername = "localhost";
$username = "root";
$password = ""; 
$dbname = "carrentals_truong";

//Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

//Check connection
if($conn->connect_error) {
	die("Connection failed: ".$conn->connect_error);
}

echo "Connected successfully to car database.<br>";
?>

<h1>Welcome to the Car Rentals Database!</h1>
<h2>Choose a transaction you want to make and fill in all boxes for the transaction:</h2>
<h3>Add new customer information</h3>
<div id="customer">
<form action="rentals.php" method="post">
<label for="ID">ID number:</label><br>
<input type="text" id="ID" name="ID"><br>
<label for="finit">First initial:</label><br>
<input type="text" id="finit" name="finit"><br>
<label for="lname">Last name:</label><br>
<input type="text" id="lname" name="lname"><br>
<label for="phone">Phone number (please include dashes):</label><br>
<input type="text" id="phone" name="phone"><br>
<input type="submit">
</form>
</div>
<!-- used to ignore all warnings in code -->
<?php error_reporting (E_ALL ^ E_NOTICE); ?> 

<?php

//get input information from user
$ID = $_POST["ID"];
$Finit = $_POST["finit"];
$Lname = $_POST["lname"];
$Phone = $_POST["phone"];	

//echo $ID.$Finit.$Lname.$Phone;

//SQL to add new customer information
//attributes are ID_no, finit, lname, and phone.
$customer = "insert into customer values(".$ID.",\"".$Finit."\",\"".$Lname."\",\"".$Phone."\");";

//sending query to database and checking if it worked
if($conn->query($customer) == TRUE) {
	echo "<br>New customer inserted into database successfully.";
}
else {
	echo "Error: ".$customer."<br>".$conn->error;
}

?>

<h3>Add new car information</h3>
<!--create a dropdown list for car types
form for new car below -->
<div id="car">
<form action="rentals.php" method="post">
<label for="vID">Vehicle ID:</label><br>
<input type="text" id="vID" name="vID"><br>
<label for="ctype">Car Type:</label><br>
<input type="text" id="ctype" name="ctype"><br>
<label for="model">Car Model:</label><br>
<input type="text" id="model" name="model"><br>
<label for="year">Year Made:</label><br>
<input type="text" id="year" name="year"><br>
<input type="submit">
</form>
</div>

<?php

//get input from user
$vID = $_POST["vID"];
$ctype = $_POST["ctype"];
$model = $_POST["model"];
$year = $_POST["year"];

//SQL to insert new car information
//attributes are Vehicle_ID, car type, model, year, and ID_no. 
//When adding a new car, ID_no can be NULL becase the new car does't have to be rented right away.
$car = "insert into car values(".$vID.",\"".$ctype."\",\"".$model."\",".$year.",NULL);";

//sending query to database and checking if it worked
if($conn->query($car) == TRUE) {
	echo "New car inserted into database successfully.<br>";
}
else {
	echo "Error: ".$car."<br>".$conn->error;
}

//create a new active rental for the new car
//attributes are Vehicle_ID, ID_no, availability, amount due, rental type, no_days, no_weeks, start date, and end date.
$newRental = "insert into rentals values(".$vID.",NULL,1,0.0,NULL,0,0,\"2000-01-01\",\"2000-01-01\");";

//sending query to database and checking if it worked
if($conn->query($newRental) == TRUE) {
	echo "New active rental inserted into database successfully.";
}
else {
	echo "Error: ".$rentals."<br>".$conn->error;
}

?>

<h3>Schedule a rental car</h3>
<div id="schedule">
<form action="rentals.php" method="post">
<label for="ID1">Customer ID:</label><br>
<input type="text" id="ID1" name="ID1"><br>
<label for="ctype1">Car Type:</label><br>
<input type="text" id="ctype1" name="ctype1"><br>
<label for="rtype">Rental Type:</label><br>
<input type="text" id="rtype" name="rtype"><br>
<label for="sdate">Start Date(format:YYYY-MM-DD):</label><br>
<input type="text" id="sdate" name="sdate"><br>
<label for="nDays">Number of Days:</label><br>
<input type="text" id="nDays" name="nDays"><br>
<label for="nWeeks">Number of Weeks:</label><br>
<input type="text" id="nWeeks" name="nWeeks"><br>
<input type="submit">
</form>
</div>

<?php

//get input from user
$ID1 = $_POST["ID1"];
$ctype1 = $_POST["ctype1"];
$rtype = $_POST["rtype"];
$sdate = $_POST["sdate"];
$nDays = $_POST["nDays"];
$nWeeks = $_POST["nWeeks"];

//find all available cars of chosen type
$fetchInfo = "select r.Vehicle_ID from rentals as r, car as c where c.Vehicle_ID=r.Vehicle_ID and r.Available_now=1 and c.type=\"".$ctype1."\";";

//extract a vehicle_id from the top result 
$result = $conn->query($fetchInfo);
if ($result > 0) {
	$row = $result->fetch_assoc();
	$vehicleID = $row["Vehicle_ID"];
	//echo $vehicleID."<br>";
	
	//schedule the car rental
	$modify = "update rentals set ID_no=".$ID1.",Available_now=0,rtype=\"".$rtype."\",no_days=".$nDays.",no_weeks=".$nWeeks.",start_date=\"".$sdate."\" where Vehicle_ID=".$vehicleID.";";
	$sqlMod = $conn->query($modify);	
	
	//calculate the end date given the start date and number of days/weeks
	if ($rtype == "daily") {
		//$calcReturn = "select date_add(start_date,interval no_days day) as retDate from rentals where Vehicle_ID=".$vehicleID.";";
		//$rDate = $conn->query($calcReturn);
		//$fetchDate = $rDate->fetch_assoc();
		//$retDate = $fetchDate["retDate"];
		
		//calculate end date in php
		$retDate = date_add(date_create($sdate),date_interval_create_from_date_string($nDays."days"));
		$retDate = date_format($retDate,"Y-m-d");
		//echo $retDate."<br>";
		//add return date to record
		$includeDate = "update rentals set end_date=\"".$retDate."\" where Vehicle_ID=".$vehicleID.";";
		$sqlAdd = $conn->query($includeDate);
		//calculate amount due
		$getRate = "select ct.daily_rate from rentals as r, car_type as ct, car as c where r.Vehicle_ID=c.Vehicle_ID and ct.type=c.type and c.Vehicle_ID=".$vehicleID.";";
		$dRate = $conn->query($getRate);
		$rateRow = $dRate->fetch_assoc();
		$dailyRate = $rateRow["daily_rate"];
		$amount = $dailyRate * $nDays;
		//echo $dailyRate.",".$amount."<br>";
		//input amount due in the database
		$inputAmt = "update rentals set Amount_due=".$amount." where Vehicle_ID=".$vehicleID.";";
		$execAmt = $conn->query($inputAmt);
	}
	else if ($rtype == "weekly"){
		//$wcalcReturn = "select date_add(start_date,interval no_weeks*7 day) as retDate from rentals where Vehicle_ID=".$vehicleID.";";
		//$rDate = $conn->query($wcalcReturn);
		//$wfetchDate = $rDate->fetch_assoc();
		//$wretDate = $wfetchDate["retDate"];
		
		//calculate end date in php
		$nWeeks = $nWeeks*7;
		$wretDate = date_add(date_create($sdate),date_interval_create_from_date_string($nWeeks."days"));
		$wretDate = date_format($wretDate,"Y-m-d");
		//echo $wretDate."<br>";
		//add return date to record
		$wincludeDate = "update rentals set end_date=\"".$wretDate."\" where Vehicle_ID=".$vehicleID.";";
		$wsqlAdd = $conn->query($wincludeDate);
		//calculate amount due
		$wGetRate = "select ct.weekly_rate from rentals as r, car_type as ct, car as c where r.Vehicle_ID=c.Vehicle_ID and ct.type=c.type and c.Vehicle_ID=".$vehicleID.";";
		$wRate = $conn->query($wGetRate);
		$wRateRow = $wRate->fetch_assoc();
		$weeklyRate = $wRateRow["weekly_rate"];
		$wAmount = $weeklyRate * $nWeeks;
		//input amount due into the database
		$winputAmt = "update rentals set Amount_due=".$wAmount." where Vehicle_ID=".$vehicleID.";";
		$wexecAmt = $conn->query($winputAmt);
	}
	echo "Scheduled the car rental successfully<br>";
}
else {
	echo "Sorry, there is no car available with that type.<br>";
}
?>

<h3>Return a rental car</h3>
<div id="return">
<form action ="rentals.php" method="post">
<label for="vID2">Vehicle ID:</label><br>
<input type="text" id="vID2" name="vID2"><br>
<input type="submit">
</form>
</div>

<?php

//get input from user
$vID2 = $_POST["vID2"];

if (isset($_POST["vID2"])) {
	//look for amount due based on the vehicle ID and print it out
	$find = "select Amount_due from rentals where Vehicle_ID=".$vID2.";";
	$getAmount = $conn->query($find);

	$findR = $getAmount->fetch_assoc();
	echo "Amount due: $".$findR["Amount_due"]."<br>";
	echo "Thank you for renting our cars!<br>";


	//after printing out the amount due, update the returned rental attributes and make it an active rental
	$changeActive = "update rentals set ID_no=NULL,Available_now=1,Amount_due=0.0,rtype=NULL,no_days=0,no_weeks=0,start_date=\"2000-01-01\",end_date=\"2000-01-01\" where Vehicle_ID=".$vID2.";";
	$tryChange = $conn->query($changeActive);
	if ($tryChange == TRUE) {
		echo "Car is now available for rental.<br>";
	}
}
//$updateR = "update rentals set ID_no=NULL,Available_now=1,Amount_due=0.0,rtype=NULL,no_days=0,no_weeks=0,start_date=\"2000-01-01\",end_date=\"2000-01-01\" where Vehicle_ID=".$vID2.";";
//$updateTry = $conn->query($updateR);


?>

<h3>Update rental rates for a car type</h3>
<div id="rate">
<form action="rentals.php" method="post">
<label for="ctype2">Car Type:</label><br>
<input type="text" id="ctype2" name="ctype2"><br>
<p> For the rates below, include a decimal number up to 2 decimal places (ie. 59->59.00)</p>
<label for="daily">Daily Rate:</label><br>
<input type="text" id="daily" name="daily"><br>
<label for="weekly">Weekly Rate:</label><br>
<input type="text" id="weekly" name="weekly"><br>
<input type="submit">
</form>
</div>

<?php

//get input from user
$ctype2 = $_POST["ctype2"];
$daily = $_POST["daily"];
$weekly = $_POST["weekly"];

//check if the car type exists
$exists = "select count(*) as here from car_type where exists (select type from car_type where type=\"".$ctype2."\");" ;
$here = $conn->query($exists);
$value = $here->fetch_assoc();

if($value["here"] > 0) {
	//update the rental rates for a car type
	$change = "update car_type set daily_rate=".$daily.",weekly_rate=".$weekly."where type=\"".$ctype2."\";";
	$updateDone = $conn->query($change);
	echo "Updated daily and weekly rates for the ".$ctype2." car type was successful.";
}
else {
	//inserts a new car type and its rental rates
	$add ="insert into car_type values(\"".$ctype2."\",".$daily.",".$weekly.");";
	$addDone = $conn->query($add);
	echo "Added new car type with its daily and weekly rates to the database sucessfully.";
}

?>

</body>
</html>