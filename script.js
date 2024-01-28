let mybutton = document.getElementById("myBtn");

window.onscroll = function() {
  scrollFunction();
};

function scrollFunction() {
  if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}


//Form Validationn
function validateAndSubmitForm() {
  // Customers name
  var nameRegex = /^[a-zA-Z]+\s[a-zA-Z]+$/;
  var customerName = document.getElementById('customerName').value;
  if (!nameRegex.test(customerName)) {
      alert('Please enter a valid full name (e.g., "John Doe").');
      return false;
  }

  // Email address
  var emailRegex = /\S+@\S+\.\S+/;
  var email = document.getElementById('email').value;
  if (!emailRegex.test(email)) {
      alert('Please enter a valid email address.');
      return false;
  }

  // Phone Number
  var phoneRegex = /^04\d{8}$/;
  var phone = document.getElementById('phone').value;
  if (!phoneRegex.test(phone)) {
      alert('Please enter a valid phone number starting with "04".');
      return false;
  }

  // Check-in date
  var checkInDate = document.getElementById('checkInDate').value;
  if (new Date(checkInDate) < new Date()) {
      alert('Please select a future check-in date.');
      return false;
  }

  // Number of check-in persons based on room type
  var roomType = document.getElementById('roomType').value;
  var numOfPersons = document.getElementById('numOfPersons').value;

  if (
      (roomType === 'standard_twin' || roomType === 'executive_twin') && numOfPersons > 2 ||
      (roomType === 'superior_suite' || roomType === 'deluxe_suite' || roomType === 'executive_suite') && numOfPersons > 3 ||
      (roomType === 'presidential_suite' && numOfPersons > 5)
  ) {
      alert('Invalid number of persons for the selected room type.');
      return false;
  }

  // If all validations pass, submit the form
  return true;
}


//Checking availability

function checkAvailability(roomType) {
  // Make an AJAX request to check availability
  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'checkAvailability.php?roomType=' + roomType, true);

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        //availability status
        var response = xhr.responseText;
        if (response === 'available') {
          alert('The room is available for booking!');
        } else if (response === 'booked') {
          alert('Sorry, the rooms for this type are booked. Please try another room.');
        } else {
          alert(response);
        }
      } else {
        //In case ther server request fails
        alert('Error checking availability. Status code: ' + xhr.status);
      }
    }
  };

  xhr.send();
}