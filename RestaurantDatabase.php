<?php
class RestaurantDatabase {
    private $host = "localhost";
    private $port = "3306";
    private $database = "restaurant_reservations";
    private $user = "root";
    private $password = "n2o4p5e:)";
    private $connection;

    public function __construct() {
        $this->connect();
    }

    private function connect() {
        $this->connection = new mysqli($this->host, $this->user, $this->password, $this->database, $this->port);
        if ($this->connection->connect_error) {
            die("Connection failed: " . $this->connection->connect_error);
        }
    }

    public function getCustomerById($customerId) {
        $stmt = $this->connection->prepare("SELECT * FROM customers WHERE customerId = ?");
        $stmt->bind_param("i", $customerId);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }

    public function addReservation($customerId, $reservationTime, $numberOfGuests, $specialRequests) {
        $stmt = $this->connection->prepare(
            "INSERT INTO reservations (customerId, reservationTime, numberOfGuests, specialRequests) VALUES (?, ?, ?, ?)"
        );
        $stmt->bind_param("isis", $customerId, $reservationTime, $numberOfGuests, $specialRequests);
        $stmt->execute();
        $stmt->close();
        echo "Reservation added successfully";
    }


    public function getAllReservations() {
        $result = $this->connection->query("SELECT * FROM reservations");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function addCustomer($customerName, $contactInfo) {
        $existingCustomer = $this->getCustomerByName($customerName);
    
        if ($existingCustomer) {
        return $existingCustomer['customerId'];
       } else {
        $stmt = $this->connection->prepare("INSERT INTO customers (customerName, contactInfo) VALUES (?, ?)");
        $stmt->bind_param("ss", $customerName, $contactInfo);
        $stmt->execute();
        $customerId = $stmt->insert_id;
        $stmt->close();
        return $customerId;
        }
    }

    public function getCustomerByName($customerName) {
        $stmt = $this->connection->prepare("SELECT * FROM customers WHERE customerName = ?");
        $stmt->bind_param("s", $customerName);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc(); 
    }

    public function getCustomerPreferences($customerId) {
        $stmt = $this->connection->prepare("SELECT * FROM dining_preferences WHERE customerId = ?");
        $stmt->bind_param("i", $customerId);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }

   
}
?>
