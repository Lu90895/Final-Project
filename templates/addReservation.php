<html>
<head><title>Add Reservation</title></head>
<body>
    <h1>Add Reservation</h1>
    <form method="POST" action="index.php?action=addReservation">
        Customer Name: <input type="text" name="customer_name" required><br>
        Contact Info: <input type="text" name="contact_info" required><br>
        Reservation Time: <input type="datetime-local" name="reservation_time" required><br>
        Number of Guests: <input type="number" name="number_of_guests" required min="1"><br>
        Special Requests: <textarea name="special_requests"></textarea><br>
        <button type="submit">Submit</button>
    </form>
    <a href="index.php">Back to Home</a>
</body>
</html>
