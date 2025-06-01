<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Settings</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', sans-serif;
    }
    .settings-container {
      max-width: 600px;
      margin: 40px auto;
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .section-title {
      border-bottom: 2px solid #dee2e6;
      padding-bottom: 8px;
      margin-bottom: 20px;
      font-weight: 600;
      color: #333;
    }
  </style>
</head>
<body>

<div class="settings-container">
  <h2 class="mb-4">Account Settings</h2>

  <!-- Profile Info -->
  <div class="mb-4">
    <h5 class="section-title">Profile Information</h5>
    <form id="profileForm">
      <div class="mb-3">
        <label for="nameInput" class="form-label">Full Name</label>
        <input type="text" class="form-control" id="nameInput" placeholder="Enter your name" value="John Doe" />
      </div>
      <div class="mb-3">
        <label for="emailInput" class="form-label">Email Address</label>
        <input type="email" class="form-control" id="emailInput" placeholder="name@example.com" value="john@example.com" />
      </div>
    </form>
  </div>

  <!-- Change Password -->
  <div class="mb-4">
    <h5 class="section-title">Change Password</h5>
    <form id="passwordForm">
      <div class="mb-3">
        <label for="currentPass" class="form-label">Current Password</label>
        <input type="password" class="form-control" id="currentPass" placeholder="Current password" />
      </div>
      <div class="mb-3">
        <label for="newPass" class="form-label">New Password</label>
        <input type="password" class="form-control" id="newPass" placeholder="New password" />
      </div>
      <div class="mb-3">
        <label for="confirmPass" class="form-label">Confirm New Password</label>
        <input type="password" class="form-control" id="confirmPass" placeholder="Confirm new password" />
      </div>
    </form>
  </div>

  <!-- Notifications -->
  <div class="mb-4">
    <h5 class="section-title">Notification Preferences</h5>
    <form id="notificationsForm">
      <div class="form-check mb-2">
        <input class="form-check-input" type="checkbox" value="" id="emailNotif" checked>
        <label class="form-check-label" for="emailNotif">
          Email notifications
        </label>
      </div>
      <div class="form-check mb-2">
        <input class="form-check-input" type="checkbox" value="" id="smsNotif">
        <label class="form-check-label" for="smsNotif">
          SMS notifications
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="pushNotif">
        <label class="form-check-label" for="pushNotif">
          Push notifications
        </label>
      </div>
    </form>
  </div>

  <!-- Save Button -->
  <button type="button" class="btn btn-primary w-100" onclick="saveSettings()">Save Changes</button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function saveSettings() {
    alert('Settings saved successfully!');
    // You can add real save logic here with AJAX or form submit
  }
</script>

</body>
</html>
