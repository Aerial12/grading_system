<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];
    
    $sql = "SELECT * FROM users WHERE username='$username'";
    $result = $conn->query($sql);
    
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            session_start();
            $_SESSION['username'] = $username;
            $_SESSION['role'] = $user['role'];
            if ($user['role'] === 'admin') {
                $_SESSION['message'] = "Welcome back, Admin! Ready to manage the system?";
                header("Location: admin_dashboard.php");
            } elseif ($user['role'] === 'professor') {
                $_SESSION['message'] = "Welcome back, Professor! Remember to inspire and educate.";
                header("Location: professor_dashboard.php");
            }
            exit(); // Always exit after redirection
        } else {
            $error = "Invalid password";
        }
    } else {
        $error = "Invalid username";
    }
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        /* External font import */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

        /* General resets and defaults */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: #1f293a;
        }
        .container {
            position: relative;
            width: 400px;
            height: 450px;
            background: #1f293a;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .container form {
            width: 100%;
            padding: 0 40px;
            margin-top: 20px;
        }
        h2 {
            font-size: 2.5em;
            color: #0ef;
            text-align: center;
            margin-bottom: 20px;
        }
        .input-box {
            position: relative;
            margin-bottom: 25px;
        }
        .input-box input {
            width: 100%;
            height: 50px;
            background: transparent;
            border: 2px solid #2c4766;
            outline: none;
            border-radius: 40px;
            font-size: 1em;
            color: #fff;
            padding: 0 20px;
            transition: .3s ease-in-out;
        }
        .input-box input:focus,
        .input-box input:valid {
            border-color: #0ef;
        }
        .input-box label {
            position: absolute;
            top: 80%;
            left: 20px;
            transform: translateY(-50%);
            font-size: 1em;
            color: #fff;
            pointer-events: none;
            transition: .3s ease-in-out;
        }
        .input-box input:focus ~ label,
        .input-box input:valid ~ label {
            top: 1px;
            font-size: .8em;
            background: #1f293a;
            padding: 0 6px;
            color: #0ef;
        }
        .btn {
            width: 100%;
            height: 45px;
            background: #0ef;
            border: none;
            outline: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1em;
            color: #1f293a;
            font-weight: 600;
            transition: background .3s ease-in-out;
        }
        .btn:hover {
            background: #0cf;
        }
        .signup-link {
            margin-top: 20px;
            text-align: center;
        }
        .signup-link a {
            font-size: 1em;
            color: #0ef;
            text-decoration: none;
            font-weight: 600;
            transition: color .3s ease-in-out;
        }
        .signup-link a:hover {
            color: #0cf;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form id="login-form" method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']);?>">
            <div class="input-box">
                <input type="text" name="username" required>
                <label>Username</label>
            </div>
            <div class="input-box">
                <input type="password" name="password" required>
                <label>Password</label>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <?php if(isset($error)) { echo "<p style='color:red;'>$error</p>"; } ?>
        <div class="signup-link">
            <a href="#" id="forgot-password-link">Forgot password?</a><br>
        </div>
    </div>

    <script>
        document.getElementById('login-form').addEventListener('submit', function() {
            document.getElementById('loading-screen').style.display = 'block';
        });

        document.getElementById('forgot-password-link').addEventListener('click', function(event) {
            event.preventDefault(); // Prevent the default link behavior
            alert("Please go to the office to reset your password or contact ulcs@gmail.com");
        });
    </script>
</body>
</html>