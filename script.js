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
